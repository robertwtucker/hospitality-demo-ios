//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckOutConfirmView: View {
  @Environment(\.dismiss) private var dismiss
  
    var body: some View {
    VStack(spacing: 16) {
      Spacer()
      Text("checkout.complete",
        comment: "Message confirming the check out process is complete.")
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
    CheckOutConfirmView()
}
