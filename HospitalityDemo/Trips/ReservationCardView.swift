//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationCardView: View {
  let reservation: Reservation
  
  private let cornerRadius: CGFloat = 24
  private let cardAndImageWidth: CGFloat = 340
  private let cardHeight: CGFloat = 240
  private let imageHeight: CGFloat = 180
  
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
            Text("\(reservation.hotel.name)").bold()
            Text("Check-In: \(reservation.checkInDate)").font(.caption)
          }
          Spacer()
          RatingView(rating: reservation.hotel.rating)
        }
        .padding(.horizontal, 8)
        Spacer()
      }
      .background(Color("brand/turquoise"))
      .foregroundColor(.white)
      .frame(width: cardAndImageWidth, height: cardHeight)
      .cornerRadius(cornerRadius)
    }
  }
}

#Preview {
  ReservationCardView(reservation: Reservation.sampleData)
}