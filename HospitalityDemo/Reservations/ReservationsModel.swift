//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

class ReservationsModel: ObservableObject {
  @Published var reservations: [Reservation] = []
  
  @MainActor
  func load() {
    reservations = Bundle.main.decode(Reservations.self, from: "reservations.json")
  }
}
