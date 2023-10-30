//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation

public struct Stay: Codable {
  var reservation: Reservation
  var sendEmail: Bool
  var feedback: String
  
  init(reservation: Reservation, sendEmail: Bool = false, feedback: String = "") {
    self.reservation = reservation
    self.sendEmail = sendEmail
    self.feedback = feedback
  }
}
