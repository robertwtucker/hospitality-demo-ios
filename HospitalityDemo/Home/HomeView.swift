//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct HomeView: View {
  @Environment(StayModel.self) private var stayModel
  
  @SwiftUI.State private var searchText = ""
  
  var body: some View {
    if stayModel.checkedIn {
      checkedInHome
    }
    else {
      checkedOutHome
    }
  }
  
  @ViewBuilder
  private var checkedInHome: some View {
    let hotelName = stayModel.currentStay!.reservation.hotel.name
    
    VStack {
      LogoCircle()
      Spacer()
      VStack(spacing: 8) {
        Text("home.welcome", comment: "Welcome to hotel intro")
          .font(.headline)
        Text(hotelName)
          .font(.title)
          .bold()
      }
      .foregroundColor(Color(K.Colors.turquoise))
      Spacer()
      HStack {
        Spacer()
        MenuButton(title: String(localized: "home.button.open",
                                 comment: "'Open Door' menu button label"),
                   icon: Image(systemName: "lock.open.rotation"))
        Spacer()
        MenuButton(title: String(localized: "home.button.dining", 
                                 comment: "'Dining' menu button label"),
                   icon: Image(systemName: "fork.knife"))
        Spacer()
        MenuButton(title: String(localized: "home.button.staff", 
                                 comment: "'Staff' menu button label"),
                   icon: Image(systemName: "person.wave.2.fill"))
        Spacer()
      }
      Spacer()
      Image(K.Images.General.dayOff)
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
            .foregroundColor(Color(K.Colors.brown))
          TextField("home.search.prompt", text: $searchText, prompt: Text("home.search.prompt").foregroundColor(Color(UIColor.label)))
            .font(.footnote)
            .foregroundColor(Color(K.Colors.brown))
        }
        .padding()
        .overlay(
          RoundedRectangle(cornerRadius: 10.0)
            .strokeBorder(Color(K.Colors.brown), style: StrokeStyle(lineWidth: 2))
        )
        .padding()
        Spacer(minLength: 20)
      }
      Spacer()
      Image(K.Images.General.travel)
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
          .fill(Color(K.Colors.brown))
          .frame(width: UIScreen.main.bounds.size.width + 200)
          .padding(.top, -(UIScreen.main.bounds.size.width))
          .shadow(color: Color(K.Colors.turquoise).opacity(0.75),
                  radius: 10, x: 0, y: 0)
      }
      VStack {
        Image(K.Images.Hotel.logo_white)
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
      // Not Implemented
    }) {
      ZStack {
        RoundedRectangle(cornerRadius: 10)
          .fill(Color(K.Colors.brown).opacity(0.25))
          .stroke(Color(K.Colors.brown))
        VStack {
          icon
            .resizable()
            .foregroundColor(Color(K.Colors.turquoise))
            .aspectRatio(contentMode: .fit)
            .frame(width: 30, height: 30)
          Text(title)
            .foregroundColor(Color(K.Colors.turquoise))
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
    .environment(StayModel())
}
