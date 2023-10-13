//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct RatingView: View {
  let rating: Double
  
  var body: some View {
    HStack {
      // Loop through all the full star for each whole number rating
      ForEach(0..<Int(rating), id: \.self) { _ in
        buildStar(starType: "star.fill")
      }
      // Determine if a half star is needed next
      if (rating != floor(rating)) {
        buildStar(starType: "star.leadinghalf.fill")
      }
      // Complete with remaining empty stars if needed
      ForEach(0..<Int(5 - rating), id: \.self) { _ in
        buildStar(starType: "star")
      }
    }
    .foregroundColor(.yellow)
    .font(.caption2)
  }
  
  private func buildStar(starType: String) -> some View {
    return Image(systemName: starType)
      .padding(.horizontal, -3)
  }
  
}

#Preview {
  RatingView(rating: 2.5)
}
