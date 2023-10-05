//
//  Reward.swift
//  HospitalityDemo
//
//  Created by j.stobie on 10/4/23.
//

//import Foundation
//
//// TODO: Complete implementation
//
//struct Reward: Codable {
//  let _id: Int
//  let reservationNumber, guests, points: Int
//  let hotel, checkIn, checkOut: String
//
//  enum CodingKeys: String, CodingKey {
//    case _id = "id"
//    case hotel, reservationNumber, guests, checkIn, checkOut, points
//  }
//}
//
//// MARK: - Identifiable
//extension Reward: Identifiable {
//  public var id: Int { _id }
//}
//
//// MARK: - Sample Data
//extension Reward {
//  static var sample = [
//    Reward(
//      _id: 1,
//      reservationNumber: 1756895,
//      guests: 2,
//      points: 300,
//      hotel: "Omni Quady Inn",
//      checkIn: "2023-10-14",
//      checkOut: "2023-10-18"
//    ),
//    Reward(
//      _id: 2,
//      reservationNumber: 1445875,
//      guests: 1,
//      points: 150,
//      hotel: "Quady Holiday Inn",
//      checkIn: "2023-8-17",
//      checkOut: "2023-8-21"
//    )]
//}
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

// MARK: - Identifiable
extension Reward: Identifiable {
  public var id: Int { _id }
}

typealias Rewards = [Reward]
