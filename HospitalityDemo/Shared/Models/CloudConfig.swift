//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

struct CloudConfig: Codable {
  let applicationId, companyName, cloudUrl: String
  let authenticationClientId, redirectUrl, minimumSupportedCloudVersion: String
  var rootedDeviceEnabled: Bool
  
  enum CodingKeys: String, CodingKey {
    case applicationId, companyName, cloudUrl
    case authenticationClientId, redirectUrl
    case minimumSupportedCloudVersion, rootedDeviceEnabled
  }
}
