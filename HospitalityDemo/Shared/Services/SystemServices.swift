//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct SystemServices: ViewModifier {
  
  static var appState = AppState()
  
  func body(content: Content) -> some View {
    content
      .environmentObject(Self.appState)
  }
}
