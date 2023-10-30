//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ConciergeView: View {
  @Environment(StayModel.self) private var stayModel
  
  var body: some View {
    WebView(url: URL(string: stayModel.currentStay?.reservation.hotel.conciergeUrl ?? "https://www.quadient.com/en/enterprise-industries/service-providers")!)
  }
}

#Preview {
  ConciergeView()
    .environment(StayModel())
}
