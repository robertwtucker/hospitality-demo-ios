//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

@Observable public class UserManager {
  static let shared = UserManager()
  
  public var currentSession: SessionInfo?
  
  public var clientId: String? {
    guard let session = currentSession else { return nil }
    return session.clientID
  }
  
  public var email: String? {
    guard let session = currentSession else { return nil }
    return session.email
  }
  
  public var name: String? {
    guard let session = currentSession else { return nil }
    return session.name
  }
  
  public var isAuthenticated: Bool {
    guard let sessionInfo = currentSession else { return false }
    return !sessionInfo.isExpired()
  }
  
  private init() { }
}

