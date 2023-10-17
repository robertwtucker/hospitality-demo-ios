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
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: CheckOutView.self))
  
  var body: some View {
    VStack(spacing: 16) {
      Spacer()
      Text("checkout.temp.viewname")
        .font(.title)
      Toggle("checkout.sendEmail", isOn: $sendEmail)
        .padding(.horizontal, 32)
        .padding(.vertical, 24)
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
      Spacer()
    }
    .sheet(isPresented: $showConfirm) {
      CheckOutConfirmView()
    }
  }
}

#Preview {
  CheckOutView()
    .environment(StayManager.shared)
}
