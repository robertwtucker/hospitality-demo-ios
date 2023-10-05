//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

//import Foundation
//
//// TODO: Complete implementation
//
//struct Reservation: Codable {
//  let _id: Int
//  var hotel: Hotel
//  let confirmationNumber, guests, creditPrefix, creditSuffix: Int
//  let checkIn, checkOut: String
//
//  enum CodingKeys: String, CodingKey {
//    case _id = "id"
//    case hotel, confirmationNumber, guests, checkIn, checkOut, creditPrefix, creditSuffix
//  }
//}
//
//// MARK: - Identifiable
//extension Reservation: Identifiable {
//  public var id: Int { _id }
//}
//
//// MARK: - Sample Data
//extension Reservation {
//  static var sample = Reservation(
//    _id: 1,
//    hotel: Hotel.sample,
//    confirmationNumber: 1756895,
//    guests: 2,
//    creditPrefix: 54,
//    creditSuffix: 79,
//    checkIn: "2023-10-14",
//    checkOut: "2023-10-18"
//  )
//}

import Foundation

// MARK: - ReservationElement
struct Reservation: Codable {
    var hotel: Hotel
  var checkIn: CheckIn
    let _id, confirmationNumber, guests, creditPrefix, creditSuffix: Int
    let checkInDate, checkOutDate: String
  
    enum CodingKeys: String, CodingKey {
      case _id = "id"
      case hotel, checkIn, confirmationNumber, guests, creditPrefix, creditSuffix, checkInDate, checkOutDate
    }
}

// MARK: - Hotel
struct Hotel: Codable {
    let name, location, imageName, checkInTime, checkOutTime: String
    let rating: Double
  
  enum CodingKeys: String, CodingKey {
    case name, location, imageName, checkInTime, checkOutTime, rating
  }
}

// MARK: - CheckIn
struct CheckIn: Codable {
  var firstName, lastName, phone, email: String
  var checkedIn: Bool
  
  enum CodingKeys: String, CodingKey {
    case firstName, lastName, phone, email, checkedIn
  }
}

// MARK: - Identifiable
extension Reservation: Identifiable {
  public var id: Int { _id }
}

typealias Reservations = [Reservation]

