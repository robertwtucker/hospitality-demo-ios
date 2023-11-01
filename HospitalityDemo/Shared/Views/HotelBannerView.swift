//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct HotelBannerView: View {
  let reservation: Reservation
  
  var body: some View {
    HStack {
      Image(K.Images.Hotel.logo)
        .padding(.leading, 20)
        .frame(height: 25)
        .aspectRatio(contentMode: .fit)
      Text(reservation.hotel.name)
        .font(.caption)
        .padding(.vertical, 10)
        .bold()
      Spacer()
      RatingView(rating: reservation.hotel.rating).padding(.horizontal, 20)
    }
    .background(Color(UIColor.secondarySystemBackground))
    .shadow(radius: 10, x: 0, y: 0)
  }
}

#Preview {
  HotelBannerView(reservation: Reservation.sampleData)
}
