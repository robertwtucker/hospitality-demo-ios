//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckOutConfirmView: View {
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
      VStack(spacing: 32) {
        Spacer()
        Image(K.Images.General.checkOutConfirm)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity)
        Text("checkout.complete",
             comment: "Message confirming the check out process is complete.")
        Button {
          dismiss()
        } label: {
          Text("button.ok")
        }
        .background(Color(K.Colors.aqua))
        .foregroundColor(.white)
        .buttonStyle(.bordered)
        .controlSize(.large)
        .cornerRadius(10)
        Spacer()
      }
      .presentationDetents([.medium])
      .presentationDragIndicator(.visible)
  }
}

#Preview {
    CheckOutConfirmView()
}
