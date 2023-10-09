//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct SessionBannerMenu: View {
  @Environment(UserManager.self) private var user
  
  @Binding var showSettings: Bool
  
  var body: some View {
    Menu {
      Button {
        showSettings.toggle()
      } label: {
        Label("Settings", systemImage: "gear")
      }
      Button {
        logout()
      } label: {
        Label("Log Out", systemImage: "person.slash.fill")
      }
    } label: {
      Label("User Icon", systemImage: "person.crop.circle")
    }
    .font(.title)
    .labelStyle(.iconOnly)
  }
  
  private func logout() {
    Task {
      await withCheckedContinuation { continuation in
        AdvantageSDK.sharedInstance().authenticationService.logout { error in
          print("Logged out \(error == nil ? "successfully" : "with error: ")\(String(describing: error))")
          continuation.resume()
        }
      }
      user.currentSession = nil
    }
  }
}

#Preview {
  SessionBannerMenu(showSettings: .constant(false))
}
