//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct HomeView: View {
  @Environment(StayManager.self) private var stay
  @SwiftUI.State private var search = ""
  
  var body: some View {
    if stay.checkedIn {
      checkedInHome
    }
    else {
      checkedOutHome
    }
  }
  
  private var checkedInHome: some View {
    VStack {
      Image("hotel/logo")
        .padding(.top, 30)
      Spacer()
      Text("You are checked in")
      Spacer()
      Image("general/travel")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: UIScreen.main.bounds.size.width - 100)
      Spacer()
    }
  }
  
  private var checkedOutHome: some View {
    VStack {
      Image("hotel/logo")
        .padding(.top, 30)
      Spacer()
      HStack {
        Spacer(minLength: 30)
        HStack (alignment: .center, spacing: 10) {
          Image(systemName: "magnifyingglass")
            .resizable()
            .frame(width: 15, height: 15, alignment: .center)
            .frame(minWidth: 0, maxWidth: 15)
            .frame(minHeight: 0, maxHeight: 15)
            .foregroundColor(Color("brand/brown"))
          TextField ("Where can we take you?", text: $search, prompt: Text("Where can we take you?"))
            .font(.footnote)
            .foregroundColor(Color("brand/brown"))
        }
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 10.0)
            .strokeBorder(Color("brand/brown"), style: StrokeStyle(lineWidth: 1.0)))
        .padding()
        Spacer(minLength: 20)
      }
      Spacer()
      Image("general/travel")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: UIScreen.main.bounds.size.width - 100)
      Spacer()
    }
  }
}



#Preview {
  HomeView()
    .environment(StayManager.shared)
}
