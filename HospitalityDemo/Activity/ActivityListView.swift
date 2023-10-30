//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import os

struct ActivityListView: View {
  @Environment(AdvantageSdkModel.self) private var sdkModel
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: ActivityListView.self))
  
  var body: some View {
    NavigationStack {
      Text("activity.list.title")
        .foregroundStyle(Color("brand/brown"))
        .padding(.top, 20)
        .font(.title2)
        .bold()
      List {
        ForEach(sdkModel.activities) { activity in
          ZStack {
            NavigationLink {
              DocumentView(document: activity.document!)
            } label: {
              EmptyView()
            }
            .opacity(0)
            ActivityItemView(activity: activity)
          }
          .listRowSeparator(.hidden)
          .buttonStyle(.plain)
        }
        .onDelete(perform: { indexSet in
          Task {
            await sdkModel.deleteActivities(at: indexSet)
          }
        })
      }
      .padding(.horizontal, 0)
      .scrollContentBackground(.hidden)
      .listStyle(PlainListStyle())
    }
    .toolbar(.hidden)
    .overlay {
      if sdkModel.activities.isEmpty {
        ContentUnavailableView {
          Label("activity.list.empty.title", systemImage: "person.and.background.dotted")
        } description: {
          Text("activity.list.empty.message")
        }
      }
    }
    .onAppear {
      Task {
        await sdkModel.loadDocuments()
      }
    }
    .refreshable {
      await sdkModel.loadDocuments()
    }
    .padding(.horizontal, 0)
  }
  
}

#Preview {
  ActivityListView()
    .environment(AdvantageSdkModel())
}
