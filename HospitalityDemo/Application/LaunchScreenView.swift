//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import WebKit
import AVKit

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
  
  private var launchScreenState: Binding<LaunchScreenState> {
    Binding {
      launchScreen.state
    } set: { newValue in
      launchScreen.state = newValue
    }
  }
  
  private var avPlayer: AVPlayer {
    let player = AVPlayer(url:  Bundle.main.url(forResource: "splashVideo", withExtension: "mp4")!)
    player.play()
    return player
  }
  
  var complete = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
  
  var body: some View {
    ZStack {
      GeometryReader { proxy in
        VideoPlayer(player: avPlayer)
          .ignoresSafeArea()
          .frame(width: proxy.size.height * 16 / 9, height: proxy.size.height)
          .position(x: proxy.size.width / 2, y: proxy.size.height / 2)
          .onReceive(complete) { (output) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
              launchScreen.dismiss()
            }
          }
      }
      
    }
    .ignoresSafeArea()
  }
}
