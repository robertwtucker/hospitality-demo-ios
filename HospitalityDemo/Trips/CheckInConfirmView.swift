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
      Text("checkin.complete",
        comment: "Message confirming the check in process is complete.")
      Button {
        dismiss()
      } label: {
        Text("button.ok")
      }
      Spacer()
    }
  }
}

#Preview {
  CheckInConfirmView()
}
