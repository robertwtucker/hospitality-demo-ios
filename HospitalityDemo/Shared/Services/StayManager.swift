//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation
import os

@Observable public class StayManager {
  public var currentStay: Reservation?
  private var cloudConfig: CloudConfig
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: CheckOutView.self))
  
  public static var shared = StayManager()
  
  init() {
    cloudConfig = Bundle.main.decode(CloudConfig.self, from: "quadientcloud.json")
  }
  
  public func checkIn(reservation: Reservation) {
    currentStay = reservation
    currentStay?.checkedIn = true
    currentStay?.guestName = UserManager.shared.name
    currentStay?.guestEmail = UserManager.shared.email
    currentStay?.guestClientId = UserManager.shared.clientId
  }
  
  public func checkOut() async {
    guard let stay = currentStay else {
      logger.warning("Attemping to log out when there is no current stay!")
      return
    }
    
    do {
      let reservation = try stringifyReservation(stay)
      let payload = "{\"Clients\":[{\"ClientID\":\"ID123\", \(reservation)}]}"
      
      let url = cloudConfig.cloudUrl.replacingOccurrences(of: "<company>", with: cloudConfig.companyName)
      let client = GenerateClient(baseUrl: URL(string: url)!, apiKey: cloudConfig.generate.apiKey)
      
      _ = await client.send(.onDemandCustomData(
        pipeline: cloudConfig.generate.checkOutPipeline, payload: payload))
    } catch {
      logger.error("Caught error encoding reservation: \(error)")
    }
    
    currentStay = nil
  }
  
  private func stringifyReservation(_ reservation: Reservation) throws -> String {
    let encoder = JSONEncoder()
    encoder.outputFormatting = .withoutEscapingSlashes
    guard var stringified = try String(data: encoder.encode(reservation), encoding: .utf8) else { return "" }
    stringified.removeFirst()
    stringified.removeLast()
    return stringified
  }
}
