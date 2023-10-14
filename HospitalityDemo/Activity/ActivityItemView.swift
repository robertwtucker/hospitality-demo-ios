//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ActivityItemView: View {
  let activity: Activity
  
  private let cornerRadius: CGFloat = 16
  
  var body: some View {
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
    .background(Color("brand/aqua"))
    .cornerRadius(cornerRadius)
    .padding(.horizontal, 8)
    .shadow(radius: 2)
  }
}

#Preview {
  ActivityItemView(activity: Activity.sampleData)
}
