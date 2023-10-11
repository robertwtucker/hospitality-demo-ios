//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

struct CloudConfig: Codable {
  let companyName: String
  let cloudUrl: String
  var advantageSdk: AdvantageSdkSettings
  var generate: GenerateSettings
}

struct AdvantageSdkSettings: Codable {
  let applicationId: String
  let authenticationClientId: String
  let redirectUrl: String
  let minimumSupportedCloudVersion: String
  var rootedDeviceEnabled: Bool
}

struct GenerateSettings: Codable {
  let apiKey: String
  let checkOutPipeline: String
}
