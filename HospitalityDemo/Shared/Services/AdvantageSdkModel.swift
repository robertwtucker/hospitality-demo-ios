//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation
import OSLog

@Observable public final class AdvantageSdkModel {
  public private(set) var currentUser: SessionInfo? //= SessionInfo()
  public private(set) var documents: [DocumentInfo] = []
  private var cloudConfig = CloudConfigSettings.shared.cloudConfig
  
  private let logger = Logger(
    subsystem: K.Logging.bundleIdentifier,
    category: K.Logging.sdk)
  
  public var isSignedIn: Bool {
    currentUser != nil
  }
  
  public func signOut() {
    resetUser()
  }
  
  public func initializeAdvantageSdk(delegate: UIApplicationDelegate) {
#if targetEnvironment(simulator)
    cloudConfig.advantageSdk.rootedDeviceEnabled = true
#else
    cloudConfig.advantageSdk.rootedDeviceEnabled = false
#endif
    
    let connectionSettings = ConnectionSettings()
    connectionSettings.applicationId = cloudConfig.advantageSdk.applicationId
    connectionSettings.companyName = cloudConfig.companyName
    connectionSettings.cloudURL = cloudConfig.cloudUrl
    connectionSettings.authenticationClientId = cloudConfig.advantageSdk.authenticationClientId
    connectionSettings.redirectUrl = cloudConfig.advantageSdk.redirectUrl
    
    let options = Options(
      customSettings: true,
      rootedDeviceEnabled: cloudConfig.advantageSdk.rootedDeviceEnabled,
      loggerSettings: LoggerSettings.server.rawValue,
      encryptionRequired: false)
    options?.minimumSupportedCloudVersion = cloudConfig.advantageSdk.minimumSupportedCloudVersion
    
    AdvantageSDK.sharedInstance().initialize(with: connectionSettings, databaseKey: "", options: options)
    
    if AdvantageSDK.sharedInstance().isInitialized {
      guard let libraryInfo = AdvantageSDK.sharedInstance().libraryInfo() else {
        logger.warning("Advantage SDK initialized but library info could not be determined")
        return
      }
      logger.info("Advantage SDK v\(libraryInfo.versionName!) initialized")
      
      // Register delegates
      AdvantageSDK.sharedInstance().documentService.setDocumentDownloadStatusDelegate(delegate as? DocumentDownloadStatusDelegate)
      AdvantageSDK.sharedInstance().addErrorDelegate(delegate as? SdkErrorHandlerDelegate)
    } else {
      fatalError("Advantage SDK could not be initialized")
    }
  }
  
  public func login(username: String, password: String) async throws {
    let identityProvider = try await selectIdentityProvider(using: AdvantageSDK.sharedInstance())
    if let sessionInfo = try await AdvantageSDK.sharedInstance().authenticationService.login(withCredentials: username, password: password, identityProvider: identityProvider) {
      setupUser(sessionInfo: sessionInfo)
    }
  }
  
  private func selectIdentityProvider(using sdk: AdvantageSDK, ofType: String = "InspireAuthentication" ) async throws -> IdentityProvider? {
    let providers = try await sdk.authenticationService.listAvailableIdentityProviders()
    for provider in providers! {
      if provider.providerType == ofType {
        return provider
      }
    }
    return nil
  }
  
  public func loginWithCurrentSession() {
    Task {
      do {
        guard let sessionInfo = try await AdvantageSDK.sharedInstance().authenticationService.loginWithCurrentSession() else { return }
        logger.info("Current Advantage SDK session is still valid")
        setupUser(sessionInfo: sessionInfo)
      } catch {
        logger.debug("No valid Advantage SDK session found, will prompt to log in")
      }
    }
  }
  
  public func logout() {
    Task {
      await withCheckedContinuation { continuation in
        AdvantageSDK.sharedInstance().authenticationService.logout { error in
          self.logger.info("Logged out \(error == nil ? "successfully" : "with error: \(String(describing: error))")")
          continuation.resume()
        }
      }
      currentUser = nil
    }
  }
  
  public func loadDocuments() async {
    do {
      documents = try await fetchRemoteDocuments()
      logger.debug("Fetch returned \(self.documents.count) documents")
    } catch {
      logger.error("Error loading remote documents: \(error)")
    }
  }
  
  private func fetchRemoteDocuments() async throws -> [DocumentInfo] {
    return try await withCheckedThrowingContinuation { continuation in
      AdvantageSDK.sharedInstance().documentService.listDocuments { documents, error in
        if let error = error {
          continuation.resume(throwing: error)
          return
        }
        if let documents = documents {
          continuation.resume(returning: documents)
        }
      }
    }
  }
  
  public func iconBadgeCount() async -> Int {
    let count = await withCheckedContinuation { continuation in
      AdvantageSDK.sharedInstance().documentService.unreadDocumentsCount { result, error in
        continuation.resume(returning: result)
      }
    }
    return Int(count)
  }
  
  var activities: Activities {
    get {
      let filtered = documents.filter { document in
        guard let metadata = document.metadata else { return false }
        guard let metatype = metadata.first(where: { meta in
          meta.name == "type"
        }) else {
          return false
        }
        return metatype.value == "reward_activity"
      }
      
      return filtered.map { Activity(from: $0) }
    }
    set { }
  }
  
  public func deleteActivities(at offsets: IndexSet) async {
    let idsToDelete = offsets.map { activities[$0].document!.documentID }
    
    for id in idsToDelete {
      do {
        try await AdvantageSDK.sharedInstance().documentService.removeDocument(withDocumentId: id)
      } catch {
        logger.error("Error deleting document: \(error)")
      }
    }
  }
  
  private func setupUser(sessionInfo: SessionInfo) {
    currentUser = sessionInfo
    UserPreferences.shared.clientId = sessionInfo.clientID!
    logger.info("Setting up for user: \(sessionInfo.name!) (\(sessionInfo.email!))")
#if !targetEnvironment(simulator)
    Task {
      await MainActor.run(body: {
        UIApplication.shared.registerForRemoteNotifications()
      })
    }
#endif
    Task {
      await self.loadDocuments()
    }
  }
  
  private func resetUser() {
    currentUser = nil
    UserPreferences.shared.clientId = ""
    logger.info("Resetting user settings")
    documents = []
    Task {
      await withCheckedContinuation { continuation in
        AdvantageSDK.sharedInstance().storageService.clearDatabase { error in
          if let error = error {
            self.logger.error("Failed to clear Advantage SDK database: \(error)")
          }
          continuation.resume()
        }
      }
    }
  }
}
