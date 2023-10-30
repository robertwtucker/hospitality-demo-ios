//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation
import os

@Observable public class StayModel {
  public var currentStay: Stay?
  private(set) var reservations: Reservations = []
  private var cloudConfig = CloudConfigSettings.shared.cloudConfig
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: CheckOutView.self))
  
  public init() { }
  
  public var checkedIn: Bool {
    currentStay != nil ? true : false
  }
  
  public func checkIn(reservation: Reservation) {
    currentStay = Stay(reservation: reservation)
  }
  
  public func checkOut() async {
    guard let stay = currentStay else {
      logger.warning("Attemping to log out when there is no current stay!")
      return
    }
    
    do {
      let reservation = try String(data: JSONEncoder().encode(stay.reservation), encoding: .utf8) ?? "{}"
      let payload = "{\"Clients\":[{\"ClientID\":\"ID123\",\"Reservation\":\(reservation),\"sendEmail\":\(stay.sendEmail),\"feedback\":\"\(stay.feedback)\"}]}"
      logger.debug("Generate request body: \(payload)")
      
      let url = cloudConfig.cloudUrl.replacingOccurrences(of: "<company>", with: cloudConfig.companyName)
      let client = GenerateClient(baseUrl: URL(string: url)!, apiKey: cloudConfig.generate.apiKey)
      _ = await client.send(.onDemandCustomData(
        pipeline: cloudConfig.generate.checkOutPipeline, payload: payload))
      
      currentStay = nil
    } catch {
      logger.error("Caught error encoding reservation: \(error)")
    }
  }
  
  @MainActor
  func loadReservations() async {
    reservations = Bundle.main.decode(Reservations.self, from: "reservations.json")
  }
}
