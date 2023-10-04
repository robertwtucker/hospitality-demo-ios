//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

@Observable public class UserPreferences {
  class Storage {
    @AppStorage("advantageSdkClientId") public var clientId = ""
    @AppStorage("advantageSdkRegistrationId") public var registrationId = ""
  }
  
  public static let shared = UserPreferences()
  private let storage = Storage()
  
  public var clientId: String {
    didSet {
      storage.clientId = clientId
    }
  }
  
  public var registrationId: String {
    didSet {
      storage.registrationId = registrationId
    }
  }
  
  private init() {
    clientId = storage.clientId
    registrationId = storage.registrationId
  }
}
