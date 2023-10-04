//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct SessionBannerView: View {
  @Environment(UserManager.self) private var userManager
  
  var body: some View {
    VStack {
      HStack {
        Text("Welcome, \(userManager.currentSession?.name ?? "guest")")
          .padding(.leading, 25)
        Spacer()
        Image(systemName: "person.wave.2")
          .padding(.trailing, 25)
      }
      .padding(.bottom, 15
      )
      .background(Color("brand/brown"))
      .foregroundColor(.white)
      .bold()
      Spacer()
    }
  }
}


struct SessionBannerView_Previews: PreviewProvider {
  static var previews: some View {
    SessionBannerView()
  }
}
