//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationDetailsView: View {
  let reservation: Reservation
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("We are happy to provide you with your hotel confirmation for your upcoming stay at the **\(reservation.hotel.name)**.")
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
        Text("**\(reservation.hotel.name) | \(reservation.hotel.location)**")
      }
      .padding(.bottom, 1)
      HStack {
        Text("Confirmation Number: ")
        Spacer()
        Text(String(reservation.confirmationNumber))
          .bold()
      }
      .padding(.bottom, 1)
      HStack {
        Text("Check-In Date: ")
        Spacer()
        Text(reservation.checkInDate)
          .bold()
      }
      .padding(.bottom, 1)
      HStack {
        Text("Check-Out Date: ")
        Spacer()
        Text(reservation.checkOutDate)
          .bold()
      }
      .padding(.bottom, 10)
      Text("Hotel check-in time is **\(reservation.hotel.checkInTime)**, check out time is **\(reservation.hotel.checkOutTime)**")
        .padding(.bottom, 10)
        .font(.system(size: 10))
      HStack {
        Text("Credit Card Number: ")
        Spacer()
        Image(systemName: "creditcard.and.123")
        Text("\(String(reservation.creditPrefix))** **** **** **\(String(reservation.creditSuffix))")
          .bold()
      }
      .padding(.bottom, 10)
    }
    .font(.system(size: 13))
    .fixedSize(horizontal: false, vertical: true)
  }
}

#Preview {
  ReservationDetailsView(reservation: Reservation.sample)
}
