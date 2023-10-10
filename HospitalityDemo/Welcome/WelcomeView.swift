//
//  WelcomeView.swift
//  HospitalityDemo
//
//  Created by j.stobie on 10/10/23.
//

import SwiftUI

struct WelcomeView: View {
  @Environment(AppState.self) private var appState
  @Environment(UserManager.self) private var user
  @Environment(ReservationsModel.self) private var model
  
    var body: some View {
      AsyncContentView(source: model) { reservations in
        Text("Hello, \(reservations.count)")
      }
    }
}

#Preview {
    WelcomeView()
}
