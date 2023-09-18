//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

class ReservationsModel: ObservableObject {
//  private let service: ReservationService()
  
  @Published var reservations: [Reservation] = []
  
  @MainActor
  func loadAsync() async {
    reservations = [Reservation.sample]
  }
}
