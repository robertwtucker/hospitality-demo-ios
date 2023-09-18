//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct AppTabView: View {
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    TabView(selection: $appState.currentTab) {
      ReservationsView()
        .tabItem {
          Label("Reservations", systemImage: "calendar")
        }
        .tag(AppTabs.reservations)
      ConciergeView()
        .tabItem {
          Label("Concierge", systemImage: "photo.on.rectangle.angled")
        }
        .tag(AppTabs.conceirge)
      CheckOutView()
        .tabItem {
          Label("Check Out", systemImage: "figure.walk.departure")
        }
        .tag(AppTabs.checkout)
      RewardsView()
        .tabItem {
          Label("Rewards", systemImage: "trophy")
        }
        .tag(AppTabs.rewards)
    }
  }
}

struct AppTabView_Previews: PreviewProvider {
  static var previews: some View {
    AppTabView().environmentObject(AppState())
  }
}
