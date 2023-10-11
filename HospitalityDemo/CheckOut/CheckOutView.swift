//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI
import os

struct CheckOutView: View {
  @Environment(UserManager.self) private var user
  @Environment(ReservationsModel.self) private var model
  
  @SwiftUI.State private var isGenerating: Bool = false
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: CheckOutView.self))
  
  var body: some View {
    VStack(spacing: 16) {
      Spacer()
      Text("Check Out View")
      Button {
        Task {
          isGenerating = true
          await generateInvoice()
          isGenerating = false
        }
      } label: {
        HStack {
          Spacer()
          if isGenerating {
            ProgressView()
          } else {
            Text("Generate")
          }
          Spacer()
        }
      }
      Spacer()
    }
  }
  
  private func generateInvoice() async {
    model.currentReservation.guestName = user.name
    model.currentReservation.guestEmail = user.email
    model.currentReservation.guestClientId = user.clientId
    do {
      let reservation = try stringifyReservation(model.currentReservation)
      let payload = "{\"Clients\":[{\"ClientID\":\"ID123\", \(reservation)}]}"
      
      let config = Bundle.main.decode(CloudConfig.self, from: "quadientcloud.json")
      let url = config.cloudUrl.replacingOccurrences(of: "<company>", with: config.companyName)
      let client = GenerateClient(baseUrl: URL(string: url)!, apiKey: config.generate.apiKey)
      
      _ = await client.send(.onDemandCustomData(
        pipeline: config.generate.checkOutPipeline, payload: payload))
    } catch {
      logger.error("Caught error encoding reservation: \(error.localizedDescription)")
    }
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

#Preview {
  CheckOutView()
}
