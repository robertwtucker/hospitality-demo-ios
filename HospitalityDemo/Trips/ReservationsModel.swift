//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

@Observable class ReservationsModel: LoadableModel {
  typealias Output = Reservations
  
  private(set) var state: LoadingState<Output> = .idle
  var reservations: Reservations = []
  var currentReservation = Reservation.empty
  
  @MainActor
  func load() async {
    let result = Bundle.main.decode(Reservations.self, from: "reservations.json")
    state = .loaded(result)
    
    switch state {
    case .loaded(let reservations):
      self.reservations = reservations
      if reservations.count > 0 {
        self.currentReservation = reservations[0]
      }
    default:
      break
    }
  }
}
