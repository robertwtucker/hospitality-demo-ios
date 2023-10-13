//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct AppTabView: View {
  @Environment(UserManager.self) private var user
  @Environment(StayManager.self) private var stay
  @Environment(AppState.self) private var appState
  
  private var selectedTab: Binding<Tab> {
    Binding {
      appState.selectedTab
    } set: {
      appState.selectedTab = $0
    }
  }
  
  var body: some View {
    TabView(selection: selectedTab) {
      Group {
        // RESERVATIONS TAB
        WelcomeView()
          .tabItem {
            Label("Welcome", systemImage: "figure.wave")
          }
          .tag(Tab.reservations)
        ConciergeView()
          .tabItem {
            Label("Concierge", systemImage: "photo.on.rectangle.angled")
          }
          .tag(Tab.conceirge)
        if stay.currentStay == nil {
          // CHECK IN TAB ## OPTIONAL ##
          ReservationsListView()
            .tabItem {
              Label("Check In", systemImage: "door.left.hand.open")
            }
            .tag(Tab.checkin)
        } else {
          // CHECK OUT TAB ## OPTIONAL ##
          CheckOutView()
            .tabItem {
              Label("Check Out", systemImage: "figure.walk.departure")
            }
            .tag(Tab.checkout)
        }
        // REWARDS TAB
        RewardsView()
          .tabItem {
            Label("Activity", systemImage: "person.and.background.dotted")
          }
          .tag(Tab.rewards)
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

#Preview {
  AppTabView()
    .environment(AppState())
    .environment(StayManager.shared)
    .environment(UserManager.shared)
}
