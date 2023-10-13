//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct HomeView: View {
  @Environment(StayManager.self) private var stay
  
  var body: some View {
    Text("You are\(stay.checkedIn ? " " : " not ")checked in.")
  }
}

#Preview {
  HomeView()
    .environment(StayManager.shared)
}
