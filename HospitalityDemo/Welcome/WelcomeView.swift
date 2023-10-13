//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct WelcomeView: View {
  @Environment(StayManager.self) private var stay
  
  var checkedIn: Bool {
    guard let _ = stay.currentStay else {
      return false
    }
    return true
  }
  
  var body: some View {
    Text("Hello! You are\(checkedIn ? " " : " not ")checked in.")
  }
}

#Preview {
  WelcomeView()
    .environment(StayManager.shared)
}
