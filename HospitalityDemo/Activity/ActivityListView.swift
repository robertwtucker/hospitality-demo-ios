//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ActivityListView: View {
  @SwiftUI.State private var model = ActivityModel()
  
  var body: some View {
    NavigationStack {
      AsyncContentView(source: model) { activities in
        Text("Account Activity")
          .foregroundStyle(Color("brand/brown"))
          .padding(.top, 20)
          .font(.title2).bold()
        ScrollView {
          ForEach(activities) { activity in
            NavigationLink {
              DocumentView(document: activity.document!)
            } label: {
              ActivityItemView(activity: activity)
                .padding(.horizontal, 8)
            }
          }
        }
        .buttonStyle(.plain)
        .toolbar(.hidden)
      }
      //      .overlay {
      //        if model.isEmpty {
      //          ContentUnavailableView {
      //            Label("No recent activity", systemImage: "person.and.background.dotted")
      //          } description: {
      //            Text("Statements you receive will appear here.")
      //          }
      //        }
      //      }
      .toolbar(.hidden)
      .refreshable {
        await model.load()
      }
    }
  }
}

#Preview {
  ActivityListView()
}
