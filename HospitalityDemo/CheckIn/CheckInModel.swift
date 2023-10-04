//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

class CheckInModel: ObservableObject {
  
  @Published var checkins: [CheckIn] = []
  
  @MainActor
  func loadAsync() async {
    checkins = [CheckIn.sample]
  }
}
