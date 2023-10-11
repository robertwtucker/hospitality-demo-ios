//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation
import os

struct GenerateClient {
  enum Endpoint {
    case onDemandCustomData(pipeline: String, payload: String)
    // TODO: (if needed)
    // case onDemand:
    // case onDemandDocument:
    // etc...
  }
  
  private let baseUrl: URL
  private let apiKey: String
  
  init(baseUrl: URL, apiKey: String) {
    self.baseUrl = baseUrl
    self.apiKey = apiKey
  }
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: GenerateClient.self))
  
  func send(_ endpoint: Endpoint) async -> GenerateResponse? {
    switch endpoint {
    case .onDemandCustomData(let pipeline, let payload):
      return await onDemandCustomData(pipeline, with: payload)
    }
  }
  
  private func onDemandCustomData(_ pipeline: String, with payload: String) async -> GenerateResponse? {
    var request = getRequest(for: "/production/v4/onDemandCustomData/\(pipeline)")
    do {
      guard let data = payload.data(using: .utf8) else { return nil }
      let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
      request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
      return await sendRequest(request)
    } catch {
      logger.error("Error encoding JSON payload: \(error)")
      return nil
    }
  }
  
  private func getRequest(for endpoint: String) -> URLRequest {
    var request = URLRequest(url: baseUrl.appending(path: endpoint))
    request.httpMethod = "POST"
    request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    return request
  }
  
  private func sendRequest(_ request: URLRequest) async -> GenerateResponse? {
    var response: GenerateResponse?
    
    do {
      logger.debug("\(request.httpMethod!) \(request.url!)")
      let (data, _) = try await URLSession.shared.data(for: request)
      print("Response: \(String(decoding: data, as: UTF8.self))")
      response = try JSONDecoder().decode(GenerateResponse.self, from: data)
      logger.debug("Generate result: \(response!.status), job: \(response?.id ?? "n/a")")
    } catch {
      logger.error("Error calling Generate API: \(error)")
    }
    return response
  }
}

// MARK: - GenerateResponse

class GenerateResponse: Codable {
  let status: String
  let id: String?
  let errors, warnings: [GenerateError]?
  
  init(status: String, id: String? = nil, errors: [GenerateError] = [], warnings: [GenerateError] = []) {
    self.status = status
    self.id = id
    self.errors = errors
    self.warnings = warnings
  }
}

// MARK: - GenerateError

class GenerateError: Codable {
  let errorMessage: String
  
  init(errorMessage: String) {
    self.errorMessage = errorMessage
  }
}
