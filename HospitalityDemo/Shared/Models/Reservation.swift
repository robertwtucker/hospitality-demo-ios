//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

// TODO: Complete implementation

struct Reservation: Codable {
  let _id: Int
  var hotel: Hotel
  let confirmationNumber, guests, creditPrefix, creditSuffix: Int
  let checkIn, checkOut: String
  
  enum CodingKeys: String, CodingKey {
    case _id = "id"
    case hotel, confirmationNumber, guests, checkIn, checkOut, creditPrefix, creditSuffix
  }
}

// MARK: - Identifiable
extension Reservation: Identifiable {
  public var id: Int { _id }
}

// MARK: - Sample Data
extension Reservation {
  static var sample = Reservation(
    _id: 1,
    hotel: Hotel.sample,
    confirmationNumber: 1756895,
    guests: 2,
    creditPrefix: 54,
    creditSuffix: 79,
    checkIn: "2023-10-14",
    checkOut: "2023-10-18"
  )
}