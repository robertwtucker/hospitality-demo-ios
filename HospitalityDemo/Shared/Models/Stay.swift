//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

public struct Stay: Codable {
  var reservation: Reservation
  var sendEmail: Bool
  
  init(reservation: Reservation, sendEmail: Bool = false) {
    self.reservation = reservation
    self.sendEmail = sendEmail
  }
}
