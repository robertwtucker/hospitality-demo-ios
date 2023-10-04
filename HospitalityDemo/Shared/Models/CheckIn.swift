//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

// TODO: Complete implementation

// MARK: - CheckIn
struct CheckIn: Codable {
  let _id: Int
  var firstName, lastName, phone, email: String
  var checkedIn: Bool
  
  enum CodingKeys: String, CodingKey {
    case _id = "id"
    case firstName, lastName, phone, email, checkedIn
  }
}

// MARK: - Sample Data
extension CheckIn {
  static var sample = CheckIn(
    _id: 1,
    firstName: "Rob",
    lastName: "Ott",
    phone: "(972) 757-3698",
    email: "j.stobie@quadient.com",
    checkedIn: false
  )
}
