//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

@Observable public class UserPreferences {
  class Storage {
    @AppStorage("advantageSdkClientId") public var clientId = ""
    @AppStorage("advantageSdkDeviceId") public var deviceId = ""
  }
  
  public static let shared = UserPreferences()
  private let storage = Storage()
  
  public var clientId: String {
    didSet {
      storage.clientId = clientId
    }
  }
  
  public var deviceId: String {
    didSet {
      storage.deviceId = deviceId
    }
  }
  
  private init() {
    clientId = storage.clientId
    deviceId = storage.deviceId
  }
}
