//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import os

struct CheckOutView: View {
  @Environment(StayModel.self) private var stayModel
  
  @SwiftUI.State private var isProcessing = false
  @SwiftUI.State private var sendEmail = false
  @SwiftUI.State private var showConfirm = false
  @SwiftUI.State private var feedback = ""
  let maxCharacters = 255
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: CheckOutView.self))
  
  var body: some View {
    checkOutView
  }
  
  @ViewBuilder
  private var checkOutView: some View {
    if let stay = stayModel.currentStay {
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
            Text(stay.reservation.hotel.name)
              .font(.caption)
              .padding(.vertical, 10)
              .bold()
            Spacer()
            RatingView(rating: stay.reservation.hotel.rating).padding(.horizontal, 20)
          }
          .background(Color(UIColor.secondarySystemBackground))
          .shadow(radius: 10, x: 0, y: 0)
        }
        VStack(spacing: 32) {
          Text("checkout.temp.viewname")
            .font(.title)
            .padding(.top, 32)
            .foregroundColor(Color("brand/brown"))
          
          VStack(alignment: .leading) {
            Text("checkout.feedback", comment: "Prompt to leave feedback for hotel")
              .font(.footnote)
            ZStack {
              RoundedRectangle(cornerRadius: 10)
                .fill(Color("brand/brown").opacity(0.25))
                .stroke(Color("brand/brown"))
                .frame(height: 100)
              TextEditor(text: $feedback)
                .padding(5)
                .scrollContentBackground(.hidden)
                .foregroundColor(Color(UIColor.secondaryLabel))
                .frame(height: 100)
                .font(.caption)
            }
            Text("\(maxCharacters-feedback.count)")
              .font(.caption)
              .foregroundColor(feedback.count <= maxCharacters ? .gray : .red)
              .frame(maxWidth: .infinity, alignment: .trailing)
          }
          Toggle(String(localized: "checkout.sendEmail", comment: "Prompt to send document in email"), isOn: $sendEmail)
          Button {
            Task {
              isProcessing.toggle()
              stayModel.currentStay?.sendEmail = sendEmail
              stayModel.currentStay?.feedback = feedback
              await stayModel.checkOut()
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
    } else {
      EmptyView()
    }
  }
}

#Preview {
  CheckOutView()
    .environment(StayModel())
}
