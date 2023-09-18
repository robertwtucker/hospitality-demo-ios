//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationsView: View {
  @StateObject var model = ReservationsModel()
  @State var isLoading = false
  
  var body: some View {
    NavigationStack {
      Text("Reservations View")
    }
    .overlay {
      if isLoading {
        LoadingView()
      }
    }
    .onAppear {
      Task {
        isLoading.toggle()
        await model.loadAsync()
        isLoading.toggle()
      }
    }
  }
}

struct ReservationsView_Previews: PreviewProvider {
  static var previews: some View {
    ReservationsView()
  }
}
