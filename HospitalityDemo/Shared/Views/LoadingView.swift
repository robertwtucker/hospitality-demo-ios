//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    VStack {
      Spacer()
      ProgressView()
        .font(.largeTitle)
      Spacer()
    }
    .padding()
  }
}

struct LoadingView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView()
  }
}
