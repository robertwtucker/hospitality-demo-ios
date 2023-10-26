//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import os

struct ActivityListView: View {
  @SwiftUI.State var model = ActivityModel()
  
  var body: some View {
    NavigationStack {
      AsyncContentView(source: model) { activities in
        Text("activity.list.title")
          .foregroundStyle(Color("brand/brown"))
          .padding(.top, 20)
          .font(.title2)
          .bold()
        List {
          ForEach(activities) { activity in
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
              await delete(activities, at: indexSet)
            }
          })
        }
        .padding(.horizontal, 0)
        .scrollContentBackground(.hidden)
        .listStyle(PlainListStyle())
      }
      .toolbar(.hidden)
      .overlay {
        if model.isEmpty {
          ContentUnavailableView {
            Label("activity.list.empty.title", systemImage: "person.and.background.dotted")
          } description: {
            Text("activity.list.empty.message")
          }
        }
      }
      .refreshable {
        await model.load()
      }
    }
    .padding(.horizontal, 0)
  }
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: ActivityListView.self))
  
  private func delete(_ activities: Activities, at offsets: IndexSet) async {
    let idsToDelete = offsets.map { activities[$0].document!.documentID }
    
    for id in idsToDelete {
      do {
        try await AdvantageSDK.sharedInstance()
          .documentService.removeDocument(withDocumentId: id)
      } catch {
        logger.error("Error deleting document: \(error)")
      }
    }
  }
}

#Preview {
  ActivityListView()
}
