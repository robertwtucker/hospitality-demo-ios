//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ContentView: View {
  @Environment(StayManager.self) private var stay
  @Environment(UserManager.self) private var user
  
  @SwiftUI.State private var selectedTab: Tab = .home
  
  private var availableTabs: [Tab] {
    stay.checkedIn ? Tab.checkedInTabs() : Tab.checkedOutTabs()
  }
  
  private var showLogin: Binding<Bool> {
    Binding {
      !user.isAuthenticated
    } set: { _ in }
  }
  
  var body: some View {
    ZStack {
      TabView(selection: $selectedTab) {
        ForEach(availableTabs) { tab in
          tab.makeContentView()
            .tabItem {
              tab.label
            }
            .tag(tab)
        }
      }
      .padding(.top, 32)
      
      SessionBannerView()
    }
    .sheet(isPresented: showLogin) {
      LoginView()
        .presentationDetents([.large])
        .presentationDragIndicator(.hidden)
    }
  }
}

#Preview {
  ContentView()
    .environment(StayManager.shared)
    .environment(UserManager.shared)
}
