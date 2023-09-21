//
//  ReservationBannerView.swift
//  HospitalityDemo
//
//  Created by j.stobie on 9/18/23.
//

import SwiftUI

struct ReservationBannerView: View {
  let reservation = Reservation.sample
  
  var body: some View {
    HStack {
      Image(reservation.hotel.imageName)
        .padding(.leading, 20)
        .frame(height: 25)
        .aspectRatio(contentMode: .fit)
      Text(reservation.hotel.name)
        .font(.caption)
        .padding(.vertical, 10)
        .bold()
      Spacer()
      HStack {
        // Loop through all the full star for each whole number rating
        ForEach(0..<Int(reservation.hotel.rating), id: \.self) { _ in
          buildStar(starType: "star.fill")
        }
        // Determine if a half star is needed next
        if (reservation.hotel.rating != floor(reservation.hotel.rating)) {
          buildStar(starType: "star.leadinghalf.fill")
        }
        // Complete with remaining empty stars if needed
        ForEach(0..<Int(5 - reservation.hotel.rating), id: \.self) { _ in
          buildStar(starType: "star")
        }
      }
      .foregroundColor(.yellow)
      .font(.caption2)
      .padding(.trailing, 20)
    }
    .background(Color(UIColor.systemBackground))
    .shadow(radius: 10, x: 0, y: 0)
  }
}

func buildStar(starType: String) -> some View {
  return Image(systemName: starType)
    .padding(.horizontal, -3)
}


struct ReservationBannerView_Previews: PreviewProvider {
  static var previews: some View {
    ReservationBannerView()
  }
}
