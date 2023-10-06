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
      List(model.reservations) { reservation in
        Button(action: {
          model.currentReservation = reservation
          showDetails.toggle()
        }, label: {
          Text("\(reservation.hotel.name)\n").bold() +
          Text("Check-In: \(reservation.checkInDate)").font(.caption)
        })
      }
      .navigationTitle("Reservations")
    }
    .sheet(isPresented: $showDetails) {
      Text("Self Check-In").font(.title)
      Form {
        Section("Your Information") {
          TextField("Name", text: Binding(
            get: { user.name! },
            set: {_ in }))
          TextField("Phone", text: Binding(
            get: { model.currentReservation.checkIn.phone },
            set: { newValue in model.currentReservation.checkIn.phone = newValue }))
          .keyboardType(.phonePad)
          TextField("E-mail", text: Binding(
            get: { user.email! },
            set: { _ in }))
          .keyboardType(.emailAddress)
        }
        Section {
          DatePicker(selection: $arrivalTime, in: ...Date.now, displayedComponents: .hourAndMinute) {
            Text("Arrival Time")
          }
        }
        Section {
          Button(action: {
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
      }
    }
  }
}

struct CheckInView_Previews: PreviewProvider {
  static var previews: some View {
    CheckInView()
  }
}
