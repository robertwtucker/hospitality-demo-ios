//
//  RewardsModel.swift
//  HospitalityDemo
//
//  Created by j.stobie on 10/4/23.
//

import Foundation

class RewardsModel: ObservableObject {
  @Published var rewards: [Reward] = []
  
  @MainActor
  func load() {
    rewards = Bundle.main.decode(Rewards.self, from: "rewards.json")
  }
}

