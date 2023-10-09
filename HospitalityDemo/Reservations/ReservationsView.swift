//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct ReservationsView: View {
  @Environment(ReservationsModel.self) private var model
  
  var body: some View {
    AsyncContentView(source: model) { reservations in
      VStack {
        Image("hotel/background")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity)
        ZStack(alignment: .top) {
          ReservationDetailsView(reservation: reservations[0])
            .padding(.top, 60)
            .padding(.bottom, 20)
            .padding(.horizontal, 20)
            .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
            .background(Color("brand/beige").opacity(0.4))
            .cornerRadius(15)
          ReservationBannerView(reservations: reservations)
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
    }
  }
}

#Preview {
  ReservationsView()
}
