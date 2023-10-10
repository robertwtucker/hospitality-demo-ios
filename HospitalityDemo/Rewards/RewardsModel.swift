//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import Foundation
import os

@Observable class RewardsModel: LoadableModel {
  typealias Output = Rewards
  
  private(set) var state: LoadingState<Output> = .idle
  
  private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: RewardsModel.self))
  
  @MainActor
  func load() async {
    do {
      var documents = try await fetchRemoteDocuments()
      logger.debug("Fetch returned \(documents.count) documents (rewards)")
      documents = filterRewardActivity(from: documents)
      state = .loaded(documents.map { document in
        Reward(from: document)
      })
    } catch {
      logger.error("Error loading remote documents: \(error.localizedDescription)")
      state = .failed(error)
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
  
  private func filterRewardActivity(from documents: [DocumentInfo]) -> [DocumentInfo] {
    return documents.filter { document in
      guard let metadata = document.metadata else { return false }
      guard let metatype = metadata.first(where: { meta in
        meta.name == "type"
      }) else {
        return false
      }
      return metatype.value == "reward_activity"
    }
  }
  
  private var documentService: DocumentService {
    return AdvantageSDK.sharedInstance().documentService
  }
}

