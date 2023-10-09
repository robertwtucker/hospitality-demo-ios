//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

struct Reward {
  let _id, reservationNumber, guests, points: Int
  let hotelName, checkIn, checkOut: String
  let document: DocumentInfo?

  init(from document: DocumentInfo) {
    self._id = Int(document.documentID!)!
    self.reservationNumber = 0
    self.guests = 1
    self.points = 0
    self.hotelName = document.name!
    self.checkIn = "temp"
    self.checkOut = "temp"
    self.document = document
  }
}

typealias Rewards = [Reward]

// MARK: - Identifiable

extension Reward: Identifiable {
  public var id: Int { _id }
}

// MARK: - Sample Data
extension Reward {
  static var documents: [DocumentInfo] {
    let doc1 = DocumentInfo()
    doc1.name = "doc1"
    let doc2 = DocumentInfo()
    doc2.name = "doc2"
    return [doc1, doc2]
  }

  static var samples = [
    Reward(from: documents[0]),
    Reward(from: documents[1])
  ]
}
