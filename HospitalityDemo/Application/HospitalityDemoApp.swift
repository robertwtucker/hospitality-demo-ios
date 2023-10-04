//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import os

@main
struct HospitalityDemoApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
  
  @SwiftUI.State private var userPreferences = UserPreferences.shared
  @SwiftUI.State private var userManager = UserManager.shared
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(userPreferences)
        .environment(userManager)
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: AppDelegate.self))
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    initializeAdvantageSdk()
    return true
  }
  
  private func initializeAdvantageSdk() {
    guard let sdk = AdvantageSDK.sharedInstance() else {
      logger.error("Unable to accees shared instance of SDK")
      return
    }
    
    logger.debug("Reading cloud configuration from file")
    var config = Bundle.main.decode(CloudConfig.self, from: "quadientcloud.json")
#if targetEnvironment(simulator)
    config.rootedDeviceEnabled = true
#else
    config.rootedDeviceEnabled = false
#endif
    
    let connectionSettings = ConnectionSettings()
    connectionSettings.applicationId = config.applicationId
    connectionSettings.companyName = config.companyName
    connectionSettings.cloudURL = config.cloudUrl
    connectionSettings.authenticationClientId = config.authenticationClientId
    connectionSettings.redirectUrl = config.redirectUrl
    
    let options = Options(
      customSettings: true,
      rootedDeviceEnabled: config.rootedDeviceEnabled,
      loggerSettings: LoggerSettings.server.rawValue,
      encryptionRequired: false)
    options?.minimumSupportedCloudVersion = config.minimumSupportedCloudVersion
    
    sdk.initialize(with: connectionSettings, databaseKey: "", options: options)
    
    if sdk.isInitialized {
      guard let libraryInfo = sdk.libraryInfo() else {
        logger.warning("Advantage SDK initialized but library info could not be determined")
        return
      }
      logger.info("Advantage SDK v\(libraryInfo.versionName!) initialized")
    } else {
      logger.error("Advantage SDK could not be initialized")
    }
  }
}
