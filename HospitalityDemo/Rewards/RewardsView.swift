//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct RewardsView: View {
  @SwiftUI.State private var model = RewardsModel()

  var body: some View {
    NavigationStack {
      AsyncContentView(source: model) { rewards in
        List(rewards) { reward in
          NavigationLink {
            DocumentView(document: reward.document!)
          } label: {
            VStack(alignment: .leading) {
              Text("\(reward.hotelName ?? "Property Name")")
                .bold()
              Text("Check-In: \(reward.checkIn ?? "Check-In Date")")
                .font(.caption)
            }
          }
        }
        .navigationTitle("Account Activity")
        .overlay {
          if rewards.count == 0 {
            ContentUnavailableView {
              Label("No recent activity", systemImage: "trophy.circle")
            } description: {
              Text("Reward statements you receive will appear here.")
            }
          }
        }
        .refreshable {
          await model.load()
        }
      }
    }
  }
}

#Preview {
  RewardsView()
}
