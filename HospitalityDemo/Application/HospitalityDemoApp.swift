//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import OSLog
import UserNotifications

@main
struct HospitalityDemoApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  
  @Environment(\.scenePhase) private var scenePhase
  
  @SwiftUI.State private var launchScreen = LaunchScreenManager()
  @SwiftUI.State private var sdkModel = AdvantageSdkModel()
  @SwiftUI.State private var stayModel = StayModel()
  @SwiftUI.State private var userPreferences = UserPreferences.shared
  
  var body: some Scene {
    WindowGroup {
      ZStack {
        if userPreferences.showLaunchScreen && launchScreen.state != .finished {
          LaunchScreen().zIndex(1)
        } else {
          ContentView()
        }
      }
      .task {
        sdkModel.initializeAdvantageSdk(delegate: appDelegate)
        sdkModel.loginWithCurrentSession()
        authorizeDeviceForNotifications()
      }
      .environment(launchScreen)
      .environment(sdkModel)
      .environment(stayModel)
      .environment(userPreferences)
      .onChange(of: scenePhase) { _, newValue in
        handleScenePhase(scenePhase: newValue)
      }
    }
  }
  
  private func handleScenePhase(scenePhase: ScenePhase) {
    switch scenePhase {
    case .background:
      setIconBadgeCount()
    case .active:
      break
    default:
      break
    }
  }
  
  private func authorizeDeviceForNotifications() {
    Task {
      let userNotificationCenter = UNUserNotificationCenter.current()
      userNotificationCenter.delegate = appDelegate
      try await userNotificationCenter.requestAuthorization(options: [.badge, .sound, .alert])
    }
  }
  
  private func setIconBadgeCount() {
    Task {
      let count = await sdkModel.iconBadgeCount()
      await MainActor.run {
        UNUserNotificationCenter.current().setBadgeCount(count)
      }
    }
  }
}

// MARK: - AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
  private let logger = Logger(
    subsystem: K.Logging.bundleIdentifier,
    category: K.Logging.delegate)
  
  private var sdk: AdvantageSDK {
    return AdvantageSDK.sharedInstance()
  }
  
  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let registrationId = registrationId(with: deviceToken)
    logger.info("Device provided notification registration ID: \(registrationId)")
    checkPreviousRegistrationId(against: registrationId)
    
    Task {
      do {
        let verificationResult = try await sdk.notificationService.verifyCloudSettings(withDeviceToken: registrationId)
        guard let verificationResult = verificationResult else {
          logger.error("Verification result unexpectedly not found")
          return
        }
        if verificationResult.isCorrectSettings {
          try await sdk.notificationService.registerForNotifications(withDeviceToken: registrationId)
          logger.info("Successfully registered device with Digital Services")
          UserPreferences.shared.registrationId = registrationId
        } else {
          logger.info("Notification registration skipped due to verification status: \(verificationResult.status.rawValue)")
        }
      } catch {
        logger.error("Notification registration failed due to error: \(error.localizedDescription)")
      }
    }
  }
  
  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    logger.error("Remote notifications not available due to error: \(error.localizedDescription)")
  }
  
  func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
    logger.debug("Received remote notification: \(userInfo)")
    
    guard let notification = sdk.notificationService.notification(fromJsonObject: userInfo) else {
      logger.error("Unable to parse notification data received")
      return .failed
    }
    
    if let token = notification.notificationToken {
      try? await sdk.statisticsService.confirmNotificationDelivery(withNotificationToken: token)
    }
    
    if notification.isSilent {
      return await processSilentNotification(notification)
    } else {
      return await scheduleLocalNotification(notification)
    }
  }
  
  private func registrationId(with deviceToken: Data) -> String {
    return deviceToken.map({ String(format: "%02.2x", $0) }).joined()
  }
  
  private func checkPreviousRegistrationId(against newValue: String) {
    let oldValue = UserPreferences.shared.registrationId
    if newValue != oldValue {
      UserPreferences.shared.registrationId = ""
      let clientId = UserPreferences.shared.clientId
      if !oldValue.isEmpty && !clientId.isEmpty {
        Task {
          do {
            try await sdk.notificationService.unregisterFromNotifications(withDeviceToken: oldValue, clientID: clientId)
          } catch {
            logger.error("Failed to unregister previous device due to error: \(error.localizedDescription)")
          }
        }
      }
    }
  }
  
  private func processSilentNotification(_ notification: PushNotification) async -> UIBackgroundFetchResult {
    guard let documentId = notification.documentId else {
      logger.error("Could not find document ID in silent notification")
      return .failed
    }
    
    do {
      let documentInfo = try await sdk.documentService.document(withDocumentId: documentId)
      guard let documentInfo = documentInfo else { return .noData }
      if let downloaded = documentInfo.isDownloaded, downloaded.boolValue  {
        self.logger.debug("Document id:\(documentId) already downloaded")
        return .noData
      }
      sdk.notificationService.save(notification)
      sdk.documentService.downloadDocumentContent(inBackground: documentInfo.documentID)
      return .newData
    } catch {
      logger.error("Failed to get document w/ID:\(documentId) due to error: \(error.localizedDescription)")
      return .failed
    }
  }
  
  private func scheduleLocalNotification(_ notification: PushNotification) async -> UIBackgroundFetchResult {
    let content = UNMutableNotificationContent()
    content.title = notification.title ?? "Notification"
    content.body = notification.message ?? "Notification Message"
    content.userInfo = sdk.notificationService.jsonObject(from: notification)
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    let request = UNNotificationRequest(identifier: "\(notification.notificationToken!)", content: content, trigger: trigger)
    do {
      try await UNUserNotificationCenter.current().add(request)
      return .noData
    } catch {
      return .failed
    }
  }
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
    let id = response.notification.request.identifier
    logger.debug("Received response from notification with id: \(id)")
    
    guard let notification = sdk.notificationService.notification(fromJsonObject: response.notification.request.content.userInfo) else {
      logger.error("Unable to parse notification data for id: \(id)")
      return
    }
    
    if let notificationToken = notification.notificationToken, let documentId = notification.documentId {
      logger.debug("Received response for notificationToken: \(notificationToken), with documentId: \(documentId)")
      do {
        try await sdk.statisticsService.confirmDocumentOpen(fromNotification: documentId, notificationToken: notificationToken)
      } catch {
        logger.error("Failed to confirm document open due to error: \(error.localizedDescription)")
      }
      /*
       * Dispatch documentId for open
       */
    }
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
    return [.banner, .sound, .badge]
  }
}

// MARK: - DocumentDownloadStatusDelegate

extension AppDelegate: DocumentDownloadStatusDelegate {
  func documentDownloaded(_ dcid: String!) {
    logger.info("Document downloaded [dcid:\(dcid)]")
    
    if let notifications = sdk.notificationService.listNotifications(dcid) {
      logger.debug("Notification(s) for document [dcid:\(dcid)]: \(notifications.count)")
      for notification in notifications {
        // show local notification
        // if !error {
        sdk.notificationService.remove([notification])
        // }
      }
    }
  }
  
  func documentDownloadFailed(_ dcid: String!, error: Error!) {
    logger.error("Failed to download document [dcid:\(dcid)]:\(error.localizedDescription)")
  }
}

// MARK: - SdkErrorHandlerDelegate

extension AppDelegate: SdkErrorHandlerDelegate {
  func runtimeDidSendError(_ errorMessage: ErrorMessage!) {
    var message = errorMessage.message ?? "Unknown error"
    if let tag = errorMessage.tag {
      message = "\(tag): \(message)"
    }
    
    var category = "Error"
    if IsCloudError(errorMessage.error) {
      category = "Cloud Error"
    } else if IsStorageError(errorMessage.error) {
      category = "Database Error"
    } else if IsNetworkError(errorMessage.error) {
      category = "Network Error"
    }
    logger.error("[Advantage SDK] \(category): \(message)")
  }
}
