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
        Text("Account Activity")
          .foregroundStyle(Color("brand/brown"))
          .padding(.top, 20)
          .font(.title2).bold()
        List(rewards) { reward in
          NavigationLink {
            DocumentView(document: reward.document!)
          } label: {
            VStack(alignment: .leading) {
              Text("\(reward.hotelName ?? "Property Name")")
                .bold()
              Text("Stay: \(reward.checkIn ?? "Arrival Date") to \(reward.checkOut ?? "Departure Date")")
                .font(.caption)
            }
          }
        }
        .toolbar(.hidden)
        .overlay {
          if rewards.count == 0 {
            ContentUnavailableView {
              Label("No recent activity", systemImage: "person.and.background.dotted")
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
