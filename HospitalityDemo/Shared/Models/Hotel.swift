//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

// TODO: Complete implementation

// MARK: - Hotel
struct Hotel: Codable {
    let _id: Int
    let name, location, imageName: String

    enum CodingKeys: String, CodingKey {
        case _id = "id"
        case name, location, imageName
    }
}

// MARK: - Sample Data
extension Hotel {
  static var sample = Hotel(
    _id: 1,
    name: "QUADY Boutique Hotel",
    location: "Santorini",
    imageName: "tbdAssetName"
  )
}
