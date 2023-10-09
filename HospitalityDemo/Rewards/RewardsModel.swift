//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation
import os

@Observable class RewardsModel: LoadableModel {
  typealias Output = Rewards
  
  private(set) var state: LoadingState<Output> = .idle
  var rewards: Rewards = []
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: RewardsModel.self))
  
  @MainActor
  func load() async {
    do {
      let documents = try await fetchRemoteDocuments()
      state = .loaded(documents.map { document in
        Reward(from: document)
      })
    } catch {
      logger.error("Error loading remote documents: \(error.localizedDescription)")
      state = .failed(error)
    }
    
    switch state {
    case .loaded(let rewards):
      self.rewards = rewards
    default:
      break
    }
  }
  
  private func fetchRemoteDocuments() async throws -> [DocumentInfo] {
    return try await withCheckedThrowingContinuation { continuation in
      documentService.listDocuments { documents, error in
        if let error = error {
          continuation.resume(throwing: error)
          return
        }
        if let documents = documents {
          continuation.resume(returning: documents)
        }
      }
    }
  }
  
  private var documentService: DocumentService {
    return AdvantageSDK.sharedInstance().documentService
  }
}

