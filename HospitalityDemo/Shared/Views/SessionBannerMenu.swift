//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct SessionBannerMenu: View {
  @Environment(AdvantageSdkModel.self) private var sdkModel
  
  @Binding var showSettings: Bool
  
  var body: some View {
    Menu {
      Button {
        showSettings.toggle()
      } label: {
        Label("menu.settings", systemImage: "gear")
      }
      Button {
        sdkModel.logout()
      } label: {
        Label("menu.logout", systemImage: "person.slash.fill")
      }
    } label: {
      Label("menu.usericon", systemImage: "person.crop.circle")
    }
    .font(.title)
    .labelStyle(.iconOnly)
  }
}

#Preview {
  SessionBannerMenu(showSettings: .constant(false))
    .environment(AdvantageSdkModel())
}
