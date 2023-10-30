//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationsListView: View {
  @Environment(StayModel.self) private var stayModel
  
  @SwiftUI.State private var arrivalTime = Date.now
  @SwiftUI.State private var showDetails = false
  
  var body: some View {
    NavigationStack {
      Text("reservations.list.title")
        .foregroundStyle(Color("brand/brown"))
        .padding(.top, 20)
        .font(.title2)
        .bold()
      ScrollView {
        ForEach(stayModel.reservations) { reservation in
          NavigationLink {
            CheckInView(reservation: reservation)
          } label: {
            ReservationCardView(reservation: reservation)
              .padding(.top, 8)
          }
        }
      }
      .buttonStyle(.plain)
      .scrollIndicators(.hidden)
      .toolbar(.hidden)
      .overlay {
        if stayModel.reservations.count == 0 {
          ContentUnavailableView {
            Label("reservations.list.empty.title", systemImage: "figure.fall")
          } description: {
            Text("reservations.list.empty.message")
          }
        }
      }
      .onAppear {
        Task {
          await stayModel.loadReservations()
        }
      }
      .refreshable {
        await stayModel.loadReservations()
      }
    }
  }
}

#Preview {
  ReservationsListView()
}
