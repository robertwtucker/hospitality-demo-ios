//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
  let name: String
  @Binding var launchScreenState: LaunchScreenState
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
  
  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.navigationDelegate = context.coordinator
    webView.scrollView.isScrollEnabled = false
    
    let url = Bundle.main.url(forResource: name, withExtension: "gif")!
    let data = try! Data(contentsOf: url)
    webView.load(
      data,
      mimeType: "image/gif",
      characterEncodingName: "UTF-8",
      baseURL: url.deletingLastPathComponent())
    return webView
  }
  
  func updateUIView(_ uiView: UIViewType, context: Context) { }
  
  class Coordinator: NSObject, WKNavigationDelegate {
    var parent: GifImage
    
    init(_ parent: GifImage) {
      self.parent = parent
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
      print("WebView started loading GIF")
      parent.launchScreenState = .loading
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
      print("WebView finished loading GIF")
      parent.launchScreenState = .playing
    }
  }
}
