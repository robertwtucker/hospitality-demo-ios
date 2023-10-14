//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct SettingsView: View {
  @Environment(UserPreferences.self) private var userPreferences
  
  @Binding var showSettings: Bool
  
  var body: some View {
      VStack {
        Spacer()
        Text("settings.temp.content")
          .padding(.bottom, 16)
        Button {
          showSettings.toggle()
        } label: {
          Text("button.dismiss")
        }
        Spacer()
      }
    }
}

#Preview {
  SettingsView(showSettings: .constant(false))
    .environment(UserPreferences.shared)
}
