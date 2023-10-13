//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct WelcomeView: View {
  @Environment(StayManager.self) private var stay
  
  var body: some View {
    Text("You are\(stay.checkedIn ? " " : " not ")checked in.")
  }
}

#Preview {
  WelcomeView()
    .environment(StayManager.shared)
}
