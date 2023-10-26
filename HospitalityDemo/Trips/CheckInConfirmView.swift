//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckInConfirmView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(StayManager.self) private var stay
  
  var body: some View {
    VStack {
      Image("\(stay.currentStay?.reservation.hotel.imageName ?? "hotel/background")")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
      VStack {
        VStack(alignment: .center, spacing: 8) {
          Text("checkin.confirm.checkedin", comment: "All Checked In!")
            .font(.title)
            .foregroundStyle(Color(UIColor.secondaryLabel))
          Text("\(stay.currentStay?.reservation.hotel.name ?? "Hotel Name")")
            .font(.headline)
            .foregroundStyle(Color("brand/aqua"))
            .bold()
          Text("checkin.confirm.room42")
            .font(.subheadline)
            .foregroundStyle(Color("brand/aqua"))
            .bold()
        }
        .padding(.bottom, 10)
      }
      .frame(maxWidth: .infinity)
    }
    .background(Color("brand/beige").opacity(0.4))
    .ignoresSafeArea()
    Form {
      Section(header: Text("checkin.confirm.actions")) {
        Button(action: {}) {
          HStack {
            Image(systemName: "ellipsis.bubble")
              .foregroundColor(Color("brand/turquoise"))
              .padding(.trailing, 8)
              .font(.title2)
            Text("checkin.confirm.actions.chat", comment: "Chat With Us")
          }
        }
        .foregroundColor(Color("brand/turquoise"))
        .padding(.vertical, 8)
        Button(action: {}) {
          HStack {
            Image(systemName: "bell")
              .foregroundColor(Color("brand/turquoise"))
              .padding(.trailing, 8)
              .font(.title2)
            Text("checkin.confirm.actions.requests", comment: "Service Requests")
          }
        }
        .foregroundColor(Color("brand/turquoise"))
        .padding(.vertical, 8)
        Button(action: {}) {
          HStack {
            Image(systemName: "fork.knife")
              .foregroundColor(Color("brand/turquoise"))
              .padding(.trailing, 8)
              .font(.title2)
            Text("checkin.confirm.actions.order", comment: "Browse & Order Food")
          }
        }
        .foregroundColor(Color("brand/turquoise"))
        .padding(.vertical, 8)
      }
      Button {
        dismiss()
      } label: {
        HStack {
          Spacer()
          Text("button.ok")
          Spacer()
        }
      }
    }
    .padding(.top, -10)
  }
}

#Preview {
  CheckInConfirmView()
    .environment(StayManager.shared)
}
