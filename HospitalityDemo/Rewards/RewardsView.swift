//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct RewardsView: View {
  @SwiftUI.State private var model = RewardsModel()
  @SwiftUI.State private var isLoading = false
  
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
      .overlay {
        if isLoading {
          LoadingView()
        }
      }
    }
    .onAppear() {
      isLoading.toggle()
      model.load()
      isLoading.toggle()
    }
  }
}

struct RewardsView_Previews: PreviewProvider {
  static var previews: some View {
    RewardsView()
  }
}
