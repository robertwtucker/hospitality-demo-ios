//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

// MARK: - CheckIn
struct CheckInElement: Codable {
    let id: Int
    var firstName, lastName, phone, email: String
    var checkIn: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case firstName, lastName, phone, email
    case checkIn
  }
}
