//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ActivityItemView: View {
  let activity: Activity
  
  private let cornerRadius: CGFloat = 20
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: cornerRadius)
        .strokeBorder(.clear)
        .frame(width: 360, height: 100)
      HStack {
        VStack(alignment: .leading) {
          Text(
            "\(activity.hotelName!)",
            comment: "Hotel name"
          ).bold()
          Text(
            "Stay: \(activity.checkIn!) to \(activity.checkOut!)",
            comment: "Dates of stay"
          ).font(.caption)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        Spacer()
      }
      .background(.white)
      .cornerRadius(cornerRadius)
    }
    .padding(.horizontal, 8)
    .shadow(radius: 2)
    .cornerRadius(cornerRadius)
  }
}

#Preview {
  ActivityItemView(activity: Activity.sampleData)
}
