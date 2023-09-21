//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

// TODO: Complete implementation

// MARK: - Hotel
struct Hotel: Codable {
  let _id: Int
  let name, location, imageName, checkInTime, checkOutTime: String
  let rating: Double
  
  enum CodingKeys: String, CodingKey {
    case _id = "id"
    case name, location, checkInTime, checkOutTime, imageName, rating
  }
}

// MARK: - Sample Data
extension Hotel {
  static var sample = Hotel(
    _id: 1,
    name: "QUADY Boutique Hotel",
    location: "Santorini",
    imageName: "hotel/logo",
    checkInTime: "15:00",
    checkOutTime: "12:00",
    rating: 3.5
  )
}
