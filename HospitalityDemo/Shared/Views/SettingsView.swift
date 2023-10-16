//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct SettingsView: View {
  @Environment(UserPreferences.self) private var userPreferences
  
  @Binding var showSettings: Bool
  
  var body: some View {
    Form {
      generalSection
      aboutSection
      Button {
        showSettings.toggle()
      } label: {
        Text("button.dismiss")
      }
      .frame(maxWidth: .infinity)
    }
  }
  
  
  private var generalSection: some View {
    Section("settings.general") {
      HStack(spacing: 8) {
        Label("settings.general.launchscreen", systemImage: "play.square")
        Spacer()
        Toggle(isOn: Binding {
          userPreferences.showLaunchScreen
        } set: { newValue in
          userPreferences.showLaunchScreen = newValue
        }) {}
      }
    }
  }
  
  private var aboutSection: some View {
    Section("settings.about") {
      HStack {
        Label("settings.about.demo", systemImage: "number.square")
        Spacer()
        Text("v\(UIApplication.version)")
      }
    }
  }
}

#Preview {
  SettingsView(showSettings: .constant(false))
    .environment(UserPreferences.shared)
}
