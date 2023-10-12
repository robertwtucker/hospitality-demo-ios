//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationsListView: View {
  @Environment(AppState.self) private var appState
  @Environment(UserManager.self) private var user
  
  @SwiftUI.State private var model = ReservationsModel()
  @SwiftUI.State private var arrivalTime = Date.now
  @SwiftUI.State private var showDetails = false
  
  var body: some View {
    NavigationStack {
      AsyncContentView(source: model) { reservations in
        Text("Upcoming Reservations")
          .foregroundStyle(Color("brand/brown"))
          .padding(.top, 20)
          .font(.title2).bold()
        List(reservations) { reservation in
          NavigationLink {
            CheckInView(reservation: reservation)
          } label: {
            Text("\(reservation.hotel.name)\n").bold() +
            Text("Check-In: \(reservation.checkInDate)").font(.caption)
          }
        }
        .toolbar(.hidden)
        .overlay {
          if reservations.count == 0 {
            ContentUnavailableView {
              Label("No reservations found", systemImage: "figure.fall")
            } description: {
              Text("You need to make a reservation to check in.")
            }
          }
        }
        .refreshable {
          await model.load()
        }
      }
    }
  }
}

#Preview {
    ReservationsListView()
}
