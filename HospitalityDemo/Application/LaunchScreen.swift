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

@MainActor
@Observable final class LaunchScreenManager: NSObject {
  private(set) var state: LaunchScreenState = .loading
  
  func dismiss() {
    state = .finished
  }
}

struct LaunchScreen: View {
  @Environment(LaunchScreenManager.self) private var launchScreen
  
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
          .onReceive(complete) { _ in
            Task {
              await MainActor.run {
                launchScreen.dismiss()
              }
            }
          }
      }
    }
    .ignoresSafeArea()
  }
}
