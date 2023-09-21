//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ConciergeView: View {
  let url = URL(string: "https://www.tripadvisor.com/Tourism-g189433-Santorini_Cyclades_South_Aegean-Vacations.html")
  
  var body: some View {
    WebView(url: url!)
  }
}

struct ConciergeView_Previews: PreviewProvider {
  static var previews: some View {
    ConciergeView()
  }
}
