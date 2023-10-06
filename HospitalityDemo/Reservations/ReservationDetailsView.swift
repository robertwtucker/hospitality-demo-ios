//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationDetailsView: View {
  @Environment(ReservationsModel.self) private var model
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("We are happy to provide you with your hotel confirmation for your upcoming stay at the **\(model.currentReservation.hotel.name)**.")
        .padding(.bottom, 10)
      Text("Your booking details:")
        .bold()
        .padding(.bottom, 10)
      HStack {
        Text("Hotel: ")
          .padding(.trailing, -5)
        Spacer()
        Image(systemName: "mappin.and.ellipse")
          .foregroundColor(.red)
          .padding(.horizontal, -5)
        Text("**\(model.currentReservation.hotel.name) | \(model.currentReservation.hotel.location)**")
      }
      .padding(.bottom, 1)
      HStack {
        Text("Confirmation Number: ")
        Spacer()
        Text(String(model.currentReservation.confirmationNumber))
          .bold()
      }
      .padding(.bottom, 1)
      HStack {
        Text("Check-In Date: ")
        Spacer()
        Text(model.currentReservation.checkInDate)
          .bold()
      }
      .padding(.bottom, 1)
      HStack {
        Text("Check-Out Date: ")
        Spacer()
        Text(model.currentReservation.checkOutDate)
          .bold()
      }
      .padding(.bottom, 10)
      Text("Hotel check-in time is **\(model.currentReservation.hotel.checkInTime)**, check out time is **\(model.currentReservation.hotel.checkOutTime)**")
        .padding(.bottom, 10)
        .font(.system(size: 10))
      HStack {
        Text("Credit Card Number: ")
        Spacer()
        Image(systemName: "creditcard.and.123")
        Text("\(String(model.currentReservation.creditPrefix))** **** **** **\(String(model.currentReservation.creditSuffix))")
          .bold()
      }
      .padding(.bottom, 10)
    }
    .font(.system(size: 13))
    .fixedSize(horizontal: false, vertical: true)
  }
}

struct ReservationDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    ReservationDetailsView()
  }
}
