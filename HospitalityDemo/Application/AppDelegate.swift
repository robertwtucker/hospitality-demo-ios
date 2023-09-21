//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    initializeAdvantageSdk()
    return true
  }
  
  func initializeAdvantageSdk() {
    let connectionSettings = ConnectionSettings()
    connectionSettings.applicationId = "1782581025"
    connectionSettings.companyName = "spt-dev"
    connectionSettings.cloudURL = "https://<company>.quadientcloud.eu"
    connectionSettings.authenticationClientId = "C4YK4KBMqa65fc2gSMQd2RRq"
    connectionSettings.redirectUrl = ""
    
    let options = Options(
        customSettings: true,
        rootedDeviceEnabled: true,  // Must be true to run on iOS Simulator
        loggerSettings: LoggerSettings.server.rawValue,
        encryptionRequired: false)
    options?.minimumSupportedCloudVersion = "23.06"
    
    AdvantageSDK.sharedInstance().initialize(with: connectionSettings, databaseKey: "", options: options)
    if AdvantageSDK.sharedInstance().isInitialized {
    print("Advantage SDK\(AdvantageSDK.sharedInstance().isInitialized ? "" : "_not_") initialized")
      guard let sdkVersion = AdvantageSDK.sharedInstance().libraryInfo().versionName else {
        print("Warning: Advantage SDK version could not be determined")
              return
      }
      print("Using Advantage SDK v\(sdkVersion)")
    }
  }
}
