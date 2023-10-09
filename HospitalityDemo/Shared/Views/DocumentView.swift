//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct DocumentView: View {
  var document: DocumentInfo
  
  var body: some View {
    AdvantageSdkDocumentView(document: document)
  }
}

struct AdvantageSdkDocumentView: UIViewControllerRepresentable {
  var document: DocumentInfo
  
  func makeUIViewController(context: Context) -> DCViewController {
    return DCViewController()
  }
  
  func updateUIViewController(_ controller: DCViewController, context: Context) {
    controller.document = document
  }
}

