//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ConciergeView: View {
  @Environment(ReservationsModel.self) private var model
  
  var body: some View {
    WebView(url: URL(string: model.currentReservation.hotel.conciergeUrl)!)
  }
}

struct ConciergeView_Previews: PreviewProvider {
  static var previews: some View {
    ConciergeView()
  }
}
