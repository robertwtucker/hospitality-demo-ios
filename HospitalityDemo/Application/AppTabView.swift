//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct AppTabView: View {
  @Environment(UserManager.self) private var userManager
  
  @SwiftUI.State private var selectedTab: Tab = .reservations
  @SwiftUI.State private var checkin = CheckIn.sample
  
  var body: some View {
    TabView(selection: $selectedTab) {
      Group {
        // RESERVATIONS TAB
        ZStack {
          ReservationsView()
          SessionBannerView()
        }
        .tabItem {
          Label("Reservations", systemImage: "calendar")
        }
        .tag(Tab.reservations)
        // CONCIERGE TAB
        ZStack {
          ConciergeView()
            .padding(.top, 35)
          SessionBannerView()
        }
        .tabItem {
          Label("Concierge", systemImage: "photo.on.rectangle.angled")
        }
        .tag(Tab.conceirge)
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
          .tag(Tab.checkin)
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
          .tag(Tab.checkout)
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
        .tag(Tab.rewards)
      }
    }
    .overlay {
      if !userManager.isAuthenticated {
        LoginView()
      }
    }
  }
}

struct AppTabView_Previews: PreviewProvider {
  static var previews: some View {
    AppTabView()
  }
}
