//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

public enum Tab: Int, Identifiable, Hashable {
  case reservations, conceirge, checkout, checkin, rewards
  
  public var id: Int {
    rawValue
  }
}

@Observable public class AppState {
  public var selectedTab: Tab = .reservations
}
