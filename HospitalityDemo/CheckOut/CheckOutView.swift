//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import os

struct CheckOutView: View {
  @Environment(StayManager.self) private var stay
  
  @SwiftUI.State private var isProcessing = false
  @SwiftUI.State private var sendEmail = false
  @SwiftUI.State private var showConfirm = false
  @SwiftUI.State private var additionalInformation = ""
  let maxCharacters = 255
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: CheckOutView.self))
  
  var body: some View {
    VStack {
      VStack {
        Image("general/checkOut")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity)
        HStack {
          Image("hotel/logo")
            .padding(.leading, 20)
            .frame(height: 25)
            .aspectRatio(contentMode: .fit)
          Text("\(stay.currentStay?.reservation.hotel.name ?? "Hotel Name")")
            .font(.caption)
            .padding(.vertical, 10)
            .bold()
          Spacer()
          RatingView(rating: stay.currentStay?.reservation.hotel.rating ?? 0.0).padding(.horizontal, 20)
        }
        .background(Color(UIColor.systemBackground))
        .shadow(radius: 10, x: 0, y: 0)
      }
      
      VStack(spacing: 32) {
        Text("checkout.temp.viewname")
          .font(.title)
          .padding(.top, 32)
          .foregroundColor(Color("brand/brown"))
        VStack(alignment: .leading) {
          Text("Would you like to leave any feedback?")
            .font(.footnote)
          TextEditor(text: $additionalInformation)
            .foregroundColor(.gray)
            .frame(height: 100)
            .border(Color("brand/brown"))
            .font(.caption)
          Text("\(maxCharacters-additionalInformation.count)")
            .font(.caption)
            .foregroundColor(additionalInformation.count <= maxCharacters ? .gray : .red)
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        
        Toggle("checkout.sendEmail", isOn: $sendEmail)
        Button {
          Task {
            isProcessing.toggle()
            stay.currentStay?.sendEmail = sendEmail
            await stay.checkOut()
            isProcessing.toggle()
            showConfirm.toggle()
          }
        } label: {
          HStack {
            Spacer()
            if isProcessing {
              ProgressView()
            } else {
              Text("button.checkout")
            }
            Spacer()
          }
        }
        .background(Color("brand/turquoise"))
        .foregroundColor(.white)
        .buttonStyle(.bordered)
        .controlSize(.large)
        .cornerRadius(10)
        Spacer()
      }
      .padding(.horizontal, 20)
      .sheet(isPresented: $showConfirm) {
        CheckOutConfirmView()
      }
    }
  }
}

#Preview {
  CheckOutView()
    .environment(StayManager.shared)
}
