//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

enum LoadingState<Value> {
  case idle
  case loading
  case failed(Error)
  case loaded(Value)
}

protocol LoadableModel: Observable {
  associatedtype Output
  var state: LoadingState<Output> { get }
  func load() async
}

struct AsyncContentView<Source: LoadableModel, Content: View>: View {
  @SwiftUI.State var source: Source
  var content: (Source.Output) -> Content
  
  init(source: Source,
       @ViewBuilder content: @escaping (Source.Output) -> Content) {
    _source = SwiftUI.State(initialValue: source)
    self.content = content
  }
  
  var body: some View {
    switch source.state {
    case .idle:
      Color.clear.onAppear {
        Task {
          await source.load()
        }
      }
    case .loading:
      LoadingView()
    case .failed(let error):
      ErrorView(error: error.localizedDescription, retry: {
        Task {
          await source.load()
        }
      })
    case .loaded(let output):
      content(output)
    }
  }
}
