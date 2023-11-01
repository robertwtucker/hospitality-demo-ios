//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckOutView: View {
  @Environment(StayModel.self) private var stayModel
  
  @SwiftUI.State private var isProcessing = false
  @SwiftUI.State private var sendEmail = false
  @SwiftUI.State private var showConfirm = false
  @SwiftUI.State private var feedback = ""
  
  @FocusState private var feedbackIsFocused: Bool
  
  let maxCharacters = 255
  
  var body: some View {
    ScrollView {
      VStack {
        VStack {
          Image(K.Images.General.checkOut)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
          HotelBannerView(
            reservation: stayModel.currentStay?.reservation ?? Reservation.empty)
        }
        VStack(spacing: 32) {
          Text("checkout.title",
               comment: "Checkout view title")
          .font(.title)
          .padding(.top, 32)
          .foregroundColor(Color(K.Colors.brown))
          VStack(alignment: .leading) {
            Text("checkout.feedback",
                 comment: "Prompt to leave feedback for hotel")
            .font(.footnote)
            ZStack {
              RoundedRectangle(cornerRadius: 10)
                .fill(Color(K.Colors.brown).opacity(0.25))
                .stroke(Color(K.Colors.brown))
                .frame(height: 100)
              TextEditor(text: $feedback)
                .focused($feedbackIsFocused)
                .onChange(of: feedback) {
                  guard let newValueLastChar = feedback.last else { return }
                  if newValueLastChar == "\n" {
                    feedback.removeLast()
                    feedbackIsFocused = false
                  }
                }
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
          Toggle(String(localized: "checkout.sendEmail",
                        comment: "Prompt to send document in email"),
                 isOn: $sendEmail)
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
          .background(Color(K.Colors.turquoise))
          .foregroundColor(.white)
          .buttonStyle(.bordered)
          .controlSize(.large)
          .cornerRadius(10)
          Spacer()
        }
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
    .environment(StayModel())
}
