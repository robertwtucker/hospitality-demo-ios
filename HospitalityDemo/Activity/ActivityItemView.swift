//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ActivityItemView: View {
  let activity: Activity
  
  private let cornerRadius: CGFloat = 16
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 10)
        .fill(Color("brand/sand").opacity(0.4))
      HStack {
        VStack {
          ZStack {
            RoundedRectangle(cornerRadius: 10)
              .fill(Color("brand/brown"))
            RoundedRectangle(cornerRadius: 0)
              .fill(Color("brand/brown"))
              .padding(.leading, 10)
            VStack {
              Text("\(activity.points!)",
                   comment: "Points")
              .font(.title)
              .bold()
              Text("Points")
                .font(.footnote)
            }
            .foregroundColor(Color("brand/beige"))
          }
        }
        .frame(maxWidth: 75)

        VStack(alignment: .leading) {
          Text(
            "\(activity.hotelName!)",
            comment: "Hotel name"
          )
          .font(.subheadline)
          .bold()
          HStack(spacing: 15) {
            Image(systemName: "door.left.hand.open")
            Text(
              "\(activity.checkIn!) to \(activity.checkOut!)",
              comment: "Dates of stay"
            )
            .font(.caption)
          }
          HStack {
            Image(systemName: "rectangle.portrait.and.arrow.right")
            
            Text(
              "\(activity.document?.created?.formatted() ?? Date().formatted())",
              comment: "Dates of checkout"
            )
            .font(.caption)
          }
        }
        .padding(.leading, 10)
        
        Spacer()
        
//        VStack {
//          ZStack {
//            RoundedRectangle(cornerRadius: 10)
//              .fill(Color("brand/brown"))
//            RoundedRectangle(cornerRadius: 0)
//              .fill(Color("brand/brown"))
//              .padding(.trailing, 10)
//            Image(systemName: "doc")
//          }
//        }
//        .frame(maxWidth: 50)
      }
    }
    .frame(maxHeight: 100)
  }
  
  //    HStack {
  //      VStack(alignment: .leading) {
  //        Text(
  //          "\(activity.hotelName!)",
  //          comment: "Hotel name"
  //        ).bold()
  //        Text(
  //          "Stay: \(activity.checkIn!) to \(activity.checkOut!)",
  //          comment: "Dates of stay"
  //        ).font(.caption)
  //        Text(
  //          "Checked Out: \(activity.document?.created?.formatted() ?? Date().formatted())",
  //          comment: "Dates of checkout"
  //        ).font(.caption)
  //      }
  //      .padding(.horizontal, 16)
  //      .padding(.vertical, 8)
  //      Spacer()
  //    }
  //    .background(Color("brand/aqua"))
  //    .cornerRadius(cornerRadius)
  //    .padding(.horizontal, 8)
  //    .shadow(radius: 2)
  //  }
}

#Preview {
  ActivityItemView(activity: Activity.sampleData)
}
