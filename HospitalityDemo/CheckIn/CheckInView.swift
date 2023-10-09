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
    AsyncContentView(source: model) { reservations in
      NavigationStack {
        Text("Upcoming Reservations")
          .foregroundStyle(Color("brand/brown"))
          .padding(.top, 10)
          .font(.headline).bold()
        List(reservations) { reservation in
          NavigationLink {
            VStack {
              Text(reservation.hotel.name).font(.headline)
              Image("general/checkIn")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemBackground))
              Text("Checking In?")
                .font(.title)
                .bold()
              Text("Who is staying?")
                .font(.callout)
              Form {
                Section("Your Information") {
                  TextField("Name", text: Binding(
                    get: { user.name! },
                    set: {_ in }))
                  TextField("E-mail", text: Binding(
                    get: { user.email! },
                    set: { _ in }))
                  .keyboardType(.emailAddress)
                }
                Section {
                  DatePicker(
                    selection: $arrivalTime,
                    in: ...Date.now,
                    displayedComponents: .hourAndMinute
                  ) {
                    Text("Arrival Time")
                  }
                }
                .listSectionSpacing(16)
                .listRowBackground(Color(UIColor.secondarySystemBackground))
                Section {
                  Button(action: {
                    // TODO: Find another way to update this
                    model.currentReservation.checkedIn = true
                    appState.selectedTab = .reservations
                    showDetails.toggle()
                  }, label: {
                    VStack {
                      Image(systemName: "door.left.hand.open")
                        .padding(.bottom, 5)
                        .imageScale(.large)
                      Text("Check In")
                        .frame(maxWidth: .infinity)
                        .font(.subheadline)
                        .bold()
                    }
                  })
                  .background(Color("brand/turquoise"))
                  .foregroundColor(.white)
                  .buttonStyle(.bordered)
                  .controlSize(.large)
                  .cornerRadius(10)
                }
                .listSectionSpacing(0)
                .listRowBackground(Color(UIColor.secondarySystemBackground))
              }
            }
          } label: {
            Text("\(reservation.hotel.name)\n").bold() +
            Text("Check-In: \(reservation.checkInDate)").font(.caption)
          }
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
    }
  }
}

struct CheckInView_Previews: PreviewProvider {
  static var previews: some View {
    CheckInView()
  }
}
