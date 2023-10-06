//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

@Observable class RewardsModel {
  var rewards: [Reward] = []
  
  @MainActor
  func load() {
    rewards = Bundle.main.decode(Rewards.self, from: "rewards.json")
  }
}

