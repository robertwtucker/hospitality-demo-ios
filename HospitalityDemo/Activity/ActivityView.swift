//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ActivityView: View {
  @SwiftUI.State private var model = ActivityModel()

  var body: some View {
    NavigationStack {
      AsyncContentView(source: model) { activities in
        Text("Account Activity")
          .foregroundStyle(Color("brand/brown"))
          .padding(.top, 20)
          .font(.title2).bold()
        List(activities) { activity in
          NavigationLink {
            DocumentView(document: activity.document!)
          } label: {
            VStack(alignment: .leading) {
              Text("\(activity.hotelName ?? "Property Name")")
                .bold()
              Text("Stay: \(activity.checkIn ?? "Arrival Date") to \(activity.checkOut ?? "Departure Date")")
                .font(.caption)
            }
          }
        }
        .toolbar(.hidden)
        .overlay {
          if activities.count == 0 {
            ContentUnavailableView {
              Label("No recent activity", systemImage: "person.and.background.dotted")
            } description: {
              Text("Statements you receive will appear here.")
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
  ActivityView()
}
