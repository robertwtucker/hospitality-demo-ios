//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import WebKit

enum LaunchScreenState {
  case loading, playing, finished
}

@Observable final class LaunchScreenManager: NSObject {
  var state: LaunchScreenState = .loading
  
  func dismiss() {
    print("Launch screen dismissed")
    state = .finished
  }
}

struct LaunchScreenView: View {
  @Environment(LaunchScreenManager.self) private var launchScreen
  
  @SwiftUI.State private var showSplashGif = false
  @SwiftUI.State private var ticks = 0
  
  private let animationTimer = Timer
    .publish(every: 0.5, on: .main, in: .common)
    .autoconnect()
  
  private var launchScreenState: Binding<LaunchScreenState> {
    Binding {
      launchScreen.state
    } set: { newValue in
      launchScreen.state = newValue
    }
  }
  
  var body: some View {
    GifImage(name: "splash", launchScreenState: launchScreenState)
      .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
      .onReceive(animationTimer) { date in
        updateAnimation()
      }
      .opacity(showSplashGif ? 0 : 1)
  }
  
  @MainActor
  private func updateAnimation() {
    switch launchScreen.state {
    case .loading:
      break
    case .playing:
      if ticks > 7 {
        animationTimer.upstream.connect().cancel()
        showSplashGif.toggle()
        launchScreen.dismiss()
      } else {
        ticks += 1
      }
    case .finished:
      break
    }
  }
}
