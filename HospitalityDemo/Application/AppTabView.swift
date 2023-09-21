//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct AppTabView: View {
  @EnvironmentObject var appState: AppState
  @State var checkin = CheckIn.sample
  
  var body: some View {
    TabView(selection: $appState.currentTab) {
      Group {
        // RESERVATIONS TAB
        ZStack {
          ReservationsView()
          SessionBannerView()
        }
        .tabItem {
          Label("Reservations", systemImage: "calendar")
        }
        .tag(AppTabs.reservations)
        // CONCIERGE TAB
        ZStack {
          ConciergeView()
            .padding(.top, 35)
          SessionBannerView()
        }
        .tabItem {
          Label("Concierge", systemImage: "photo.on.rectangle.angled")
        }
        .tag(AppTabs.conceirge)
        // CHECK IN TAB ## OPTIONAL ##
        if !checkin.checkedIn {
          ZStack {
            CheckInView()
              .padding(.top, 10)
            SessionBannerView()
          }
          .tabItem {
            Label("Check In", systemImage: "door.left.hand.open")
          }
          .tag(AppTabs.checkin)
        }
        // CHECK OUT TAB ## OPTIONAL ##
        if checkin.checkedIn {
          ZStack {
            CheckOutView()
              .padding(.top, 35)
            SessionBannerView()
          }
          .tabItem {
            Label("Check Out", systemImage: "figure.walk.departure")
          }
          .tag(AppTabs.checkout)
        }
        // REWARDS TAB
        ZStack {
          RewardsView()
            .padding(.top, 35)
          SessionBannerView()
        }
        .tabItem {
          Label("Rewards", systemImage: "trophy")
        }
        .tag(AppTabs.rewards)
      }
    }
  }
}

struct AppTabView_Previews: PreviewProvider {
  static var previews: some View {
    AppTabView().environmentObject(AppState())
  }
}
