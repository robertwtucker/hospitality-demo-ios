//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import UIKit

class DCViewController: UIViewController {
  var document: DocumentInfo?
  
  private var loaded = false

  
  override func viewDidLoad() {
    super.viewDidLoad()
    // TODO: Add delegates with DC support
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    openDocument()
  }
  
  func openDocument() {
    if document == nil {
      showAlertView(title: "Error", message: "Could not open document: was not set (is nil)")
      return
    }
    showDocumentView()
  }
  
  func showDocumentView() {
    if (self.loaded) {
      return
    }
    
    loadDocumentContent { (viewHolder, error) in
      if (error == nil) {
        // TODO: Add delegates with DC support
        // viewHolder?.setRedirectDelegate(self)
        // viewHolder?.setInitializationDelegate(self.documentInitListener)
        
        let documentView: UIView = viewHolder!.documentView()
        
        self.loaded = true
        
        DispatchQueue.main.async() {
          self.view.addSubview(documentView)
          
          documentView.translatesAutoresizingMaskIntoConstraints = false
          documentView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
          documentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
          documentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
          documentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        }
      } else {
          self.showAlertView(title: "Error", message: "Unable to display document: \(error?.localizedDescription ?? "unspecified error")")
      }
    }
  }
  
  func loadDocumentContent(completion: @escaping (_ documentView: DocumentViewHolder?, _ error: Error?)->()) {
    guard let document = self.document else {
      return
    }
    let contentType = documentService.convertContentType(document.contentType)
    switch contentType {
    case .documentTypePDF:
      viewService.getPdfViewHolder(withDocumentId: document.documentID, completion: completion)
    case .documentTypeDC:
      // TODO: Add support for DC
      // self.getDocumentViewHolder(completion: completion)
      break
    default:
      // self.getDocumentViewHolder(completion: completion)
      break
    }
    
  }
  
  private func showAlertView(title: String, message: String) {
    DispatchQueue.main.async() {
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
      self.present(alert, animated: true)
    }
  }
  
  private var documentService: DocumentService {
    AdvantageSDK.sharedInstance().documentService
  }
  
  private var viewService: ViewService {
    AdvantageSDK.sharedInstance().viewService
  }
}
