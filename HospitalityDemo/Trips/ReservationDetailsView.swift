//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationDetailsView: View {
  let reservation: Reservation
  
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("reservation.hotel")
          .padding(.trailing, -5)
        Spacer()
        Image(systemName: "mappin.and.ellipse")
          .foregroundColor(.red)
          .padding(.horizontal, -5)
        Text("\(Text(reservation.hotel.name).bold()) | \(Text(reservation.hotel.location).bold())", comment: "Hotel name and city")
      }
      .padding(.bottom, 1)
      HStack {
        Text("reservation.confirmation.number")
        Spacer()
        Text(String(reservation.confirmationNumber))
          .bold()
      }
      .padding(.bottom, 1)
      HStack {
        Text("reservation.checkin.date")
        Spacer()
        Text(reservation.checkInDate)
          .bold()
      }
      HStack {
        Text("reservation.checkout.date")
        Spacer()
        Text(reservation.checkOutDate)
          .bold()
      }
      .padding(.bottom, 10)
      Text("Hotel check in time is \(Text(reservation.hotel.checkInTime).bold()), check out time is \(Text(reservation.hotel.checkOutTime).bold())",
           comment: "Message specifying the hotel's check in and check out times")
        .padding(.bottom, 10)
        .font(.system(size: 10))
      HStack {
        Text("reservation.creditcard.number")
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
  ReservationDetailsView(reservation: Reservation.sampleData)
}
