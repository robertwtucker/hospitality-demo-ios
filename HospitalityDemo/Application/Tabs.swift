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
      ActivityView()
    case .other:
      EmptyView()
    }
  }
  
  @ViewBuilder
  var label: some View {
    switch self {
    case .home:
      Label("Home", systemImage: iconName)
    case .concierge:
      Label("Concierge", systemImage: iconName)
    case .trips:
      Label("Trips", systemImage: iconName)
    case .checkout:
      Label("Check Out", systemImage: iconName)
    case .activity:
      Label("Activity", systemImage: iconName)
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
