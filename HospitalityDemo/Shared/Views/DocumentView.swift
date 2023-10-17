//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct DocumentView: View {
  var document: DocumentInfo
  @SwiftUI.State var viewState: AdvantageSdkDocumentViewState = .loading
  
  var body: some View {
    ZStack {
      AdvantageSdkDocumentView(document: document, viewState: $viewState)
      viewStateOverlay
    }
  }
  
  @ViewBuilder
  private var viewStateOverlay: some View {
    switch viewState {
    case .loading:
      LoadingView()
    case .error(let message):
      ErrorView(error: message)
    default:
      EmptyView()
    }
  }
}

// MARK: - AdvantageSdkDocumentViewState

enum AdvantageSdkDocumentViewState {
  case loading
  case loaded
  case error(String)
}

// MARK: - AdvantageSdkDocumentViewStateTracking

protocol AdvantageSdkDocumentViewStateTracking {
  var documentViewState: AdvantageSdkDocumentViewState { get set }
}

// MARK: - AdvantageSdkDocumentView

struct AdvantageSdkDocumentView: UIViewControllerRepresentable {
  var document: DocumentInfo
  @Binding var viewState: AdvantageSdkDocumentViewState
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  func makeUIViewController(context: Context) -> DCViewController {
    let dcViewController = DCViewController()
    dcViewController.document = document
    dcViewController.documentViewStateDelegate = context.coordinator
    return dcViewController
  }
  
  func updateUIViewController(_ controller: DCViewController, context: Context) { }
  
  class Coordinator: NSObject, AdvantageSdkDocumentViewStateTracking {
    var parent: AdvantageSdkDocumentView
    
    init(_ advantageSdkDocumentView: AdvantageSdkDocumentView) {
      self.parent = advantageSdkDocumentView
    }
    
    var documentViewState: AdvantageSdkDocumentViewState = .loading {
      didSet {
        parent.viewState = documentViewState
      }
    }
  }
}
