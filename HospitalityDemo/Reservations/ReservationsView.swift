//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationsView: View {
  @StateObject var model = ReservationsModel()
  @SwiftUI.State var isLoading = false
  
  var body: some View {
    VStack {
      Image("hotel/background")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
      ZStack(alignment: .top) {
        ReservationDetailsView()
          .padding(.top, 60)
          .padding(.bottom, 20)
          .padding(.horizontal, 20)
          .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
          .background(Color("brand/beige").opacity(0.4))
          .cornerRadius(15)
        ReservationBannerView()
      }
      .padding(.vertical, -10)
      .padding(.bottom, 20)
      //        // LEAVING THIS CHECKED OUT FOR THE TIME BEING, NOT SURE I WANT IT HERE
      //      Button(action:{
      //        // NEED TO APPLY A CHECK IN ACTION HERE
      //      }) {
      //        VStack{
      //          Image(systemName: "door.left.hand.open")
      //            .padding(.bottom, 5)
      //            .imageScale(.large)
      //          Text("Check In")
      //            .font(.subheadline)
      //            .bold()
      //        }
      //
      //      }
      //      .background(Color("brand/turquoise"))
      //      .foregroundColor(.white)
      //      .buttonStyle(.bordered)
      //      .controlSize(.large)
      //      .cornerRadius(10)
      Spacer()
    }
    .overlay {
      if isLoading {
        LoadingView()
      }
    }
    .onAppear {
      Task {
        isLoading.toggle()
        await model.loadAsync()
        isLoading.toggle()
      }
    }
  }
}

struct ReservationsView_Previews: PreviewProvider {
  static var previews: some View {
    ReservationsView()
  }
}
