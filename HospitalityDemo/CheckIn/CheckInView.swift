//
//  CheckInView.swift
//  HospitalityDemo
//
//  Created by j.stobie on 9/20/23.
//

import SwiftUI

struct CheckInView: View {
  @SwiftUI.State var checkin = CheckIn.sample
  @SwiftUI.State var reservations = [Reservation.sample]
  @SwiftUI.State private var selectedReservation = ""
  @SwiftUI.State private var arrivalTime = Date.now
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          Picker("Hotel", selection: $selectedReservation) {
            ForEach(reservations) {reservation in
              Text(reservation.hotel.name)
            }
          }
          Picker("Date", selection: $selectedReservation) {
            ForEach(reservations) {reservation in
              Text(reservation.checkIn)
            }
          }
        } header: {Text("Select Reservation")}
        Section {
          TextField("First name", text: $checkin.firstName)
          TextField("Last name", text: $checkin.lastName)
          TextField("Phone", text: $checkin.phone)
            .keyboardType(.phonePad)
          TextField("E-mail", text: $checkin.email)
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
