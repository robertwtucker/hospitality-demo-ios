//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

enum AppTabs: Int {
  case reservations, conceirge, checkout, rewards
}

class AppState: ObservableObject {
  @Published var currentTab = AppTabs.reservations
}
