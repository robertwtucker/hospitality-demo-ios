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
    if stay.currentStay == nil {
      Tab.checkedOutTabs()
    } else {
      Tab.checkedInTabs()
    }
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      ForEach(availableTabs) { tab in
        tab.makeContentView()
          .tabItem {
            tab.label
          }
          .tag(tab)
      }
      .padding(.top, 32)
    }
    .overlay {
      ZStack {
        SessionBannerView()
        if AdvantageSDK.sharedInstance().isInitialized && !user.isAuthenticated {
          LoginView()
            .presentationDetents([.large])
            .presentationDragIndicator(.hidden)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .environment(StayManager())
      .environment(UserManager.shared)
  }
}
