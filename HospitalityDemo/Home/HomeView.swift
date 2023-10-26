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
      LogoCircle()
      Spacer()
      VStack(spacing: 8) {
        Text("Welcome to")
          .font(.headline)
        Text("\(stay.currentStay?.reservation.hotel.name ?? "HOTEL NAME")")
          .font(.title)
          .bold()
      }
      .foregroundColor(Color("brand/turquoise"))
      Spacer()
      HStack {
        Spacer()
        MenuButton(title: "Open Door", icon: Image(systemName: "lock.open.rotation"))
        Spacer()
        MenuButton(title: "Dining", icon: Image(systemName: "fork.knife"))
        Spacer()
        MenuButton(title: "Staff", icon: Image(systemName: "person.wave.2.fill"))
        Spacer()
      }
      Spacer()
      Image("general/dayOff")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: UIScreen.main.bounds.size.width - 100)
    }
  }
  
  private var checkedOutHome: some View {
    VStack {
      LogoCircle()
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
          TextField ("home.search.prompt", text: $searchText, prompt: Text("home.search.prompt").foregroundColor(Color(UIColor.label)))
            .font(.footnote)
            .foregroundColor(Color("brand/brown"))
        }
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 10.0)
            .strokeBorder(Color("brand/brown"), style: StrokeStyle(lineWidth: 2))
        )
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

struct LogoCircle: View {
  
  var body: some View {
    ZStack {
      VStack {
        Circle()
          .trim(from: 0, to: 0.5)
          .fill(Color("brand/brown"))
          .frame(width: UIScreen.main.bounds.size.width + 200)
          .padding(.top, -(UIScreen.main.bounds.size.width))
          .shadow(color: Color("brand/turquoise").opacity(0.75), radius: 10, x: 0, y: 0)
      }
      VStack {
        Image("hotel/logo_white")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .padding(.top, -30)
          .frame(maxWidth: 100)
        Text("QUADY HOTEL")
          .bold()
          .font(.title3)
          .foregroundColor(.white)
      }
    }
  }
}

struct MenuButton: View {
  let title: String
  let icon: Image
  
  var body: some View {
    Button(action: {
      print(#function)
    }) {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color("brand/brown").opacity(0.25))
          .stroke(Color("brand/brown"))
        VStack {
          icon
            .resizable()
            .foregroundColor(Color("brand/turquoise"))
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
          Text(title)
            .foregroundColor(Color("brand/turquoise"))
            .multilineTextAlignment(.center)
            .padding(.top, 5)
            .font(.footnote)
            .bold()
        }
      }
    }
    .frame(width: 100, height: 100)
  }
}

#Preview {
  HomeView()
    .environment(StayManager.shared)
}
