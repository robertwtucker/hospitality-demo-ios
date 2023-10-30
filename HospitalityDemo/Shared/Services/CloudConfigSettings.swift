//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

public final class CloudConfigSettings {
  private(set) var cloudConfig: CloudConfig
  
  public static var shared = CloudConfigSettings()
  
  private init() {
    cloudConfig = Bundle.main.decode(CloudConfig.self, from: "quadientcloud.json")
  }
}
