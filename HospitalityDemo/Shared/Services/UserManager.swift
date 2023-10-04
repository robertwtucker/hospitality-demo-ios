//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

@Observable public class UserManager {
  public var currentSession: SessionInfo?
  
  public var isAuthenticated: Bool {
    guard let sessionInfo = self.currentSession else { return false }
    return !sessionInfo.isExpired()
  }
  
  static let shared = UserManager()
  
  private init() { }
}

