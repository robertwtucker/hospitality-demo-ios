//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct SessionBannerMenu: View {
  @Environment(StayManager.self) private var stay
  @Environment(UserManager.self) private var user
  
  @Binding var showSettings: Bool
  
  var body: some View {
    Menu {
      Button {
        showSettings.toggle()
      } label: {
        Label("menu.settings", systemImage: "gear")
      }
      Button {
        logout()
      } label: {
        Label("menu.logout", systemImage: "person.slash.fill")
      }
    } label: {
      Label("menu.usericon", systemImage: "person.crop.circle")
    }
    .font(.title)
    .labelStyle(.iconOnly)
  }
  
  private func logout() {
    Task {
      await withCheckedContinuation { continuation in
        AdvantageSDK.sharedInstance().authenticationService.logout { error in
          print("Logged out \(error == nil ? "successfully" : "with error: \(String(describing: error))")")
          continuation.resume()
        }
      }
      stay.currentStay = nil
      user.currentSession = nil
    }
  }
}

#Preview {
  SessionBannerMenu(showSettings: .constant(false))
    .environment(StayManager.shared)
    .environment(UserManager.shared)
}
