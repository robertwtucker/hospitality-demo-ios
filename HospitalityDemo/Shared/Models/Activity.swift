//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

struct Activity {
  var _id: Int
  var reservationNumber, guests, points: Int?
  var hotelName, checkIn, checkOut: String?
  var document: DocumentInfo?
  
  init(_id: Int, reservationNumber: Int? = nil, hotelName: String? = nil, guests: Int? = nil, points: Int? = nil, checkIn: String? = nil, checkOut: String? = nil, document: DocumentInfo?) {
    self._id = _id
    self.reservationNumber = reservationNumber
    self.hotelName = hotelName
    self.guests = guests
    self.points = points
    self.checkIn = checkIn
    self.checkOut = checkOut
    self.document = document
  }
  
  init(from document: DocumentInfo) {
    self._id = Int(document.documentID!)!
    self.document = document
    
    if let metadata = document.metadata {
      for meta in metadata {
        guard let name = meta.name else {
          break
        }
        switch name {
        case "checkIn":
          self.checkIn = meta.value
        case "checkOut":
          self.checkOut = meta.value
        case "hotelName":
          self.hotelName = meta.value
        case "guests":
          self.guests = Int(meta.value!)
        case "points":
          self.points = Int(meta.value!)
        case "reservationNumber":
          self.reservationNumber = Int(meta.value!)
        default:
          break
        }
      }
    }
  }
}

typealias Activities = [Activity]

// MARK: - Identifiable

extension Activity: Identifiable {
  public var id: Int { _id }
}

// MARK: - Sample Data

extension Activity {
  static var sampleData = Activity(
    _id: 16,
    reservationNumber: 1756895,
    hotelName: "QUADY Boutique Hotel",
    guests: 2,
    points: 300,
    checkIn: "2023-10-14",
    checkOut: "2023-10-18",
    document: nil)
}
