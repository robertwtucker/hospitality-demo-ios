//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ContentView: View {
  @Environment(StayModel.self) private var stayModel
  @Environment(AdvantageSdkModel.self) private var sdkModel
  
  @SwiftUI.State private var selectedTab: Tab = .home
  
  private var availableTabs: [Tab] {
    stayModel.checkedIn ? Tab.checkedInTabs() : Tab.checkedOutTabs()
  }
  
  private var showLogin: Binding<Bool> {
    Binding {
      !sdkModel.isSignedIn
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
      
      SessionBannerView(guestName: sdkModel.currentUser?.name ?? "Guest")
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
    .environment(StayModel())
    .environment(AdvantageSdkModel())
}
