//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckInView: View {
  @SwiftUI.StateObject var model = ReservationsModel()
  @SwiftUI.State private var selectedReservation = ""
  @SwiftUI.State private var arrivalTime = Date.now
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          Picker("Hotel", selection: $selectedReservation) {
            ForEach(model.reservations) {reservation in
              Text(reservation.hotel.name)
            }
          }
          Picker("Date", selection: $selectedReservation) {
            ForEach(model.reservations) {reservation in
              Text(reservation.checkInDate)
            }
          }
        } header: {Text("Select Reservation")}
        Section {
          TextField("First name", text: $model.reservations[0].checkIn.firstName)
          TextField("Last name", text: $model.reservations[0].checkIn.lastName)
          TextField("Phone", text: $model.reservations[0].checkIn.phone)
            .keyboardType(.phonePad)
          TextField("E-mail", text: $model.reservations[0].checkIn.email)
            .keyboardType(.emailAddress)
        } header: {Text("Your Information")}
        Section {
          DatePicker(selection: $arrivalTime, in: ...Date.now, displayedComponents: .hourAndMinute) {
            Text("Arrival Time")
          }
        }
        Section {} header: {
          HStack {
            Spacer()
            Button(action:{
              // NEED TO APPLY A CHECK IN ACTION HERE
            }) {
              VStack {
                Image(systemName: "door.left.hand.open")
                  .padding(.bottom, 5)
                  .imageScale(.large)
                Text("Check In")
                  .frame(maxWidth: .infinity)
                  .font(.subheadline)
                  .bold()
              }
            }
            .background(Color("brand/turquoise"))
            .foregroundColor(.white)
            .buttonStyle(.bordered)
            .controlSize(.large)
            .cornerRadius(10)
            Spacer()
          }
        }
        .padding(.top, -10)
      }
      .navigationBarTitle(Text("Self Check-in"))
    }
  }
}

struct CheckInView_Previews: PreviewProvider {
  static var previews: some View {
    CheckInView()
  }
}
