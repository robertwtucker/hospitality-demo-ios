//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationsListView: View {
  @SwiftUI.State private var model = ReservationsModel()
  @SwiftUI.State private var arrivalTime = Date.now
  @SwiftUI.State private var showDetails = false
  
  var body: some View {
    NavigationStack {
      AsyncContentView(source: model) { reservations in
        Text("reservations.list.title")
          .foregroundStyle(Color("brand/brown"))
          .padding(.top, 20)
          .font(.title2).bold()
        ScrollView {
          ForEach(reservations) { reservation in
            NavigationLink {
              CheckInView(reservation: reservation)
            } label: {
              ReservationCardView(reservation: reservation)
            }
          }
        }
        .buttonStyle(.plain)
        .scrollIndicators(.hidden)
        .toolbar(.hidden)
        .overlay {
          if reservations.count == 0 {
            ContentUnavailableView {
              Label("reservations.list.empty.title", systemImage: "figure.fall")
            } description: {
              Text("reservations.list.empty.message")
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
