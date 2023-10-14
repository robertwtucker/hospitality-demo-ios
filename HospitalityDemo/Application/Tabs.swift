//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

enum Tab: Int, Identifiable, Hashable {
  case home, concierge, trips, checkout, activity, other
  
  var id: Int {
    rawValue
  }
  
  static func checkedInTabs() -> [Tab] {
    [.home, .concierge, .checkout, .activity ]
  }
  
  static func checkedOutTabs() -> [Tab] {
    [.home, .trips, .activity]
  }
  
  @ViewBuilder
  func makeContentView() -> some View {
    switch self {
    case .home:
      HomeView()
    case .concierge:
      ConciergeView()
    case .trips:
      ReservationsListView()
    case .checkout:
      CheckOutView()
    case .activity:
      ActivityListView()
    case .other:
      EmptyView()
    }
  }
  
  @ViewBuilder
  var label: some View {
    switch self {
    case .home:
      Label("tab.home", systemImage: iconName)
    case .concierge:
      Label("tab.concierge", systemImage: iconName)
    case .trips:
      Label("tab.trips", systemImage: iconName)
    case .checkout:
      Label("tab.checkout", systemImage: iconName)
    case .activity:
      Label("tab.activity", systemImage: iconName)
    case .other:
      EmptyView()
    }
  }
  
  var iconName: String {
    switch self {
    case .home:
      "house"
    case .concierge:
      "photo.on.rectangle.angled"
    case .trips:
      "briefcase"
    case .checkout:
      "figure.walk.departure"
    case .activity:
      "person.and.background.dotted"
    case .other:
      ""
    }
  }
}
