//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ConciergeView: View {
  @Environment(StayManager.self) private var stay
  
  var body: some View {
    WebView(url: URL(string: stay.currentStay?.hotel.conciergeUrl ?? "https://www.quadient.com/en/enterprise-industries/service-providers")!)
  }
}

#Preview {
  ConciergeView()
}
