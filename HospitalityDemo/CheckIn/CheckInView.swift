//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckInView: View {
  @Environment(AppState.self) private var appState
  @Environment(UserManager.self) private var user
  @Environment(ReservationsModel.self) private var model
  
  //  @SwiftUI.State private var selectedReservation
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
            VStack {
              Image("general/checkIn")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
              ZStack(alignment: .top) {
                ReservationDetailsView(reservation: reservation)
                  .padding(.top, 60)
                  .padding(.bottom, 20)
                  .padding(.horizontal, 20)
                  .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
                  .background(Color("brand/beige").opacity(0.4))
                  .cornerRadius(15)
                ReservationBannerView(reservations: reservations)
              }
              .padding(.top, -10)
              .padding(.bottom, 20)
              DatePicker(
                selection: $arrivalTime,
                in: ...Date.now,
                displayedComponents: .hourAndMinute
              ) {
                Text("Arrival Time")
              }
              .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
              Button(action: {
                // TODO: Find another way to update this
                model.currentReservation.checkedIn = true
                appState.selectedTab = .reservations
                showDetails.toggle()
              }, label: {
                HStack {
                  Spacer()
                  Text("Check In")
                  Spacer()
                }
              })
              .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
              .background(Color("brand/turquoise"))
              .foregroundColor(.white)
              .buttonStyle(.bordered)
              .controlSize(.large)
              .cornerRadius(10)
              .padding(.vertical, 20)
            }
//            .padding(.top, -40)
            Spacer()
          } label: {
            Text("\(reservation.hotel.name)\n").bold() +
            Text("Check-In: \(reservation.checkInDate)").font(.caption)
          }
        }
        .toolbar(.hidden)
        .overlay {
          if reservations.count == 0 {
            ContentUnavailableView {
              Label("No reservations found", systemImage: "figure.walk.arrival")
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

struct CheckInView_Previews: PreviewProvider {
  static var previews: some View {
    CheckInView()
  }
}
