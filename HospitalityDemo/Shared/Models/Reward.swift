//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

struct Reward {
  var _id: Int
  var reservationNumber, guests, points: Int?
  var hotelName, checkIn, checkOut: String?
  var document: DocumentInfo?
  
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

typealias Rewards = [Reward]

// MARK: - Identifiable

extension Reward: Identifiable {
  public var id: Int { _id }
}
