//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct SessionBannerView: View {
  @Environment(UserManager.self) private var user
  
  @SwiftUI.State private var showSettings = false
  
  var body: some View {
    VStack {
      HStack {
        Text("Welcome, \(user.name ?? "Guest")!")
        Spacer()
        SessionBannerMenu(showSettings: $showSettings)
      }
      .padding(EdgeInsets(top: 0, leading: 16, bottom: 8, trailing: 16))
      .background(Color("brand/brown"))
      .foregroundColor(.white)
      .bold()
      Spacer()
    }
    .sheet(isPresented: $showSettings) {
      SettingsView(showSettings: $showSettings)
        .presentationDetents([.medium])
    }
  }
}

#Preview {
  SessionBannerView()
    .environment(UserManager.shared)
}
