//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

// MARK: - Reward
struct Reward: Codable {
  let _id, reservationNumber, guests, points: Int
  let hotelName, checkIn, checkOut: String
  
  enum CodingKeys: String, CodingKey {
    case _id = "id"
    case reservationNumber, guests, points, hotelName, checkIn, checkOut
  }
}

typealias Rewards = [Reward]

// MARK: - Identifiable

extension Reward: Identifiable {
  public var id: Int { _id }
}

// MARK: - Sample Data
extension Reward {
  static var samples = [
    Reward(
      _id: 1,
      reservationNumber: 1756895,
      guests: 2,
      points: 300,
      hotelName: "Omni Quady Inn",
      checkIn: "2023-10-14",
      checkOut: "2023-10-18"
    ),
    Reward(
      _id: 2,
      reservationNumber: 1445875,
      guests: 1,
      points: 150,
      hotelName: "Quady Holiday Inn",
      checkIn: "2023-8-17",
      checkOut: "2023-8-21"
    )]
}
