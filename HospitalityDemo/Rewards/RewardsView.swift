//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct RewardsView: View {
  @SwiftUI.StateObject var model = RewardsModel()
  
  var body: some View {
    NavigationStack {
      List(model.rewards) { reward in
        NavigationLink {
          Text(reward.hotelName)
        } label: {
            Text("\(reward.hotelName)\n").bold() +
            Text("Check-In: \(reward.checkIn)").font(.caption)
        }
        .navigationTitle("Account Activity")
      }
    }
    .onAppear() {
      model.load()
    }
  }
}

struct RewardsView_Previews: PreviewProvider {
  static var previews: some View {
    RewardsView()
  }
}
