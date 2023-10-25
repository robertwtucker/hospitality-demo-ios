//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationCardView: View {
  let reservation: Reservation
  
  private let cornerRadius: CGFloat = 24
  private let cardAndImageWidth: CGFloat = 340
  private let cardHeight: CGFloat = 180
  private let imageHeight: CGFloat = 120
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
        .strokeBorder(Color("brand/turquoise"), lineWidth: 1)
        .frame(width: cardAndImageWidth, height: cardHeight)
        .shadow(radius: 2)
      
      VStack(alignment: .leading) {
        Image(reservation.hotel.imageName)
          .aspectRatio(contentMode: .fill)
          .frame(width: cardAndImageWidth, height: imageHeight)
          .clipped()
        HStack {
          VStack(alignment: .leading) {
            Spacer()
            Text("\(reservation.hotel.name)",
                 comment: "Hotel name"
            ).bold()
            Text("Check In: \(reservation.checkInDate)",
                 comment: "Date of check in"
            ).font(.caption)
            Spacer()
          }
          Spacer()
          RatingView(rating: reservation.hotel.rating)
        }
        .padding(.horizontal, 16)
        Spacer()
      }
      .background(Color("brand/brown"))
      .foregroundColor(.white)
      .frame(width: cardAndImageWidth, height: cardHeight)
      .cornerRadius(cornerRadius)
    }
  }
}

#Preview {
  ReservationCardView(reservation: Reservation.sampleData)
}
