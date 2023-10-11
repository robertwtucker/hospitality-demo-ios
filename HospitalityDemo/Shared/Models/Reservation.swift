//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

struct Reservation: Codable {
  var hotel: Hotel
  let _id, confirmationNumber, guests, creditPrefix, creditSuffix, points: Int
  let checkInDate, checkOutDate: String
  var checkedIn: Bool
  var guestName, guestEmail: String?

  enum CodingKeys: String, CodingKey {
    case _id = "id"
    case hotel, confirmationNumber, guests, creditPrefix, creditSuffix
    case checkInDate, checkOutDate, checkedIn, points
    case guestName, guestEmail
  }
}

typealias Reservations = [Reservation]

// MARK: - Hotel

struct Hotel: Codable {
  let name, location, imageName, checkInTime, checkOutTime, conciergeUrl: String
  let rating: Double

  enum CodingKeys: String, CodingKey {
    case name, location, imageName, checkInTime, checkOutTime, rating, conciergeUrl
  }
}

// MARK: - Identifiable


extension Reservation: Identifiable {
  public var id: Int { _id }
}

// MARK: - Sample Data


extension Reservation {
  static var sample = Reservation(
    hotel: Hotel(
      name: "QUADY Boutique Hotel",
      location: "Santorini",
      imageName: "hotel/logo",
      checkInTime: "15:00",
      checkOutTime: "12:00",
      conciergeUrl: "https://www.tripadvisor.com/Tourism-g189433-Santorini_Cyclades_South_Aegean-Vacations.html",
      rating: 3.5),
    _id: 0,
    confirmationNumber: 1756895,
    guests: 2,
    creditPrefix: 54,
    creditSuffix: 79,
    points: 300,
    checkInDate: "2023-10-14",
    checkOutDate: "2023-10-18",
    checkedIn: false)
  static var empty = Reservation(
    hotel: Hotel(
      name: "",
      location: "",
      imageName: "",
      checkInTime: "",
      checkOutTime: "",
      conciergeUrl: "",
      rating: 0),
    _id: 0,
    confirmationNumber: 0,
    guests: 0,
    creditPrefix: 0,
    creditSuffix: 0,
    points: 0,
    checkInDate: "",
    checkOutDate: "",
    checkedIn: false)
}
