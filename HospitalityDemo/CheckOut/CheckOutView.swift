//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import os

struct CheckOutView: View {
  @Environment(UserManager.self) private var user
  @Environment(StayManager.self) private var stay
  
  @SwiftUI.State private var isProcessing: Bool = false
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: CheckOutView.self))
  
  var body: some View {
    VStack(spacing: 16) {
      Spacer()
      Text("Check Out View")
      Button {
        Task {
          isProcessing = true
          await stay.checkOut()
          isProcessing = false
        }
      } label: {
        HStack {
          Spacer()
          if isProcessing {
            ProgressView()
          } else {
            Text("Check Out")
          }
          Spacer()
        }
      }
      Spacer()
    }
  }
}

#Preview {
  CheckOutView()
}
