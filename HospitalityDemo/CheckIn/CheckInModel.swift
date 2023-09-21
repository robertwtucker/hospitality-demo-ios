//
//  CheckInModel.swift
//  HospitalityDemo
//
//  Created by j.stobie on 9/20/23.
//

import Foundation

class CheckInModel: ObservableObject {
  
  @Published var checkins: [CheckIn] = []
  
  @MainActor
  func loadAsync() async {
    checkins = [CheckIn.sample]
  }
}
