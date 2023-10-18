//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct HomeView: View {
  @Environment(StayManager.self) private var stay
  
  @SwiftUI.State private var searchText = ""
  
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
      Text("home.checkedin.message")
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
          TextField ("home.search.prompt", text: $searchText, prompt: Text("home.search.prompt"))
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
