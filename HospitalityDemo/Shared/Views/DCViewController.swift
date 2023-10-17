//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import UIKit
import os

class DCViewController: UIViewController {
  var document: DocumentInfo?
  var documentViewStateDelegate: AdvantageSdkDocumentViewStateTracking?
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: AppDelegate.self))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // TODO: Add delegates for DC support
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    guard let document = document else {
      documentViewStateDelegate?.documentViewState = .error("Could not open document: value not set")
      return
    }
    
    switch documentViewStateDelegate?.documentViewState {
    case .loading:
      Task {
        await loadDocumentView(for: document)
      }
    default:
      return
    }
  }
  
  private func loadDocumentView(for document: DocumentInfo) async {
    var viewHolder: DocumentViewHolder?
    
    switch documentService.convertContentType(document.contentType) {
    case .documentTypePDF:
      viewHolder = await pdfViewHolder(for: document)
    default:
      viewHolder = await dcViewHolder(for: document)
    }
    
    guard let viewHolder = viewHolder else {
      documentViewStateDelegate?.documentViewState = .error("Could not open document: no view holder")
      return
    }
    
    // TODO: Add delegates with DC support
    // viewHolder.setRedirectDelegate(self)
    // viewHolder.setInitializationDelegate(self.documentInitListener)
    let documentView: UIView = viewHolder.documentView()
    
    documentViewStateDelegate?.documentViewState = .loaded
    
    await MainActor.run {
      self.view.addSubview(documentView)
      
      documentView.translatesAutoresizingMaskIntoConstraints = false
      documentView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
      documentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
      documentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
      documentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
    }
  }
  
  private func pdfViewHolder(for document: DocumentInfo) async -> DocumentViewHolder? {
    do {
      return try await viewService.pdfViewHolder(withDocumentId: document.documentID)
    } catch {
      logger.error("Error getting PDF view holder: \(error)")
      return nil
    }
  }
  
  private func dcViewHolder(for document: DocumentInfo) async -> DocumentViewHolder? {
    do {
      return try await viewService.documentViewHolder(withDocumentId: document.documentID)
    } catch {
      logger.error("Error getting DC view holder: \(error)")
      return nil
    }
  }
  
  private var documentService: DocumentService {
    AdvantageSDK.sharedInstance().documentService
  }
  
  private var viewService: ViewService {
    AdvantageSDK.sharedInstance().viewService
  }
}
