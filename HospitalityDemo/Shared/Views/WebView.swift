//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
  let url: URL
  
  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    let request = URLRequest(url: url)
    webView.load(request)
    return webView
  }
  
  func updateUIView(_ webView: WKWebView, context: Context) {
  }
}

struct WebView_Previews: PreviewProvider {
  static var previews: some View {
    let url = URL(string: "https://quadient.com")
    WebView(url: url!)
  }
}
