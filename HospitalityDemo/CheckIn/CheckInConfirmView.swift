//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckInConfirmView: View {
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    VStack(spacing: 16) {
      Spacer()
      Text("You have been checked in...")
      Button {
        dismiss()
      } label: {
        Text("OK")
      }
      Spacer()
    }
  }
}

#Preview {
  CheckInConfirmView()
}
