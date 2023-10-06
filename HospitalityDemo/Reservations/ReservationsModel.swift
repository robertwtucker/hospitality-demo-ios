//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

@Observable class ReservationsModel {
  var reservations: [Reservation] = []
  var currentReservation = Reservation.empty
  
  @MainActor
  func load() {
    let result  = Bundle.main.decode(Reservations.self, from: "reservations.json")
    if result.count > 0 {
      reservations = result
      currentReservation = result[0]
    }
  }
}
