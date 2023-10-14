//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ErrorView: View {
  @Environment(\.dismiss) private var dismiss
  
  let error: String
  var retry: (() -> Void)? = nil
  
  var body: some View {
    VStack(spacing: 20) {
      Text(error)
        .foregroundColor(.white)
        .padding()
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 10)
            .fill(Color.red)
        )
      
      if let retry = retry {
        Button("button.retry") {
          retry()
        }
      }
      
      Button("button.dismiss") {
        dismiss()
      }
      
      Spacer()
    }
    .padding()
  }
  
}

#Preview {
  ErrorView(error: "Something went wrong")
}
