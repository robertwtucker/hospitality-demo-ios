//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckInView: View {
  @Environment(AppState.self) private var appState
  @Environment(UserManager.self) private var user
  @Environment(StayManager.self) private var stay
  
  @SwiftUI.State var reservation: Reservation
  @SwiftUI.State private var arrivalTime = Date.now
    @SwiftUI.State private var showConfirm = false
  
  var body: some View {
    Group {
    VStack {
      Image("general/checkIn")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
      ZStack(alignment: .top) {
        ReservationDetailsView(reservation: reservation)
          .padding(.top, 60)
          .padding(.bottom, 20)
          .padding(.horizontal, 20)
          .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
          .background(Color("brand/beige").opacity(0.4))
          .cornerRadius(15)
        ReservationBannerView(reservation: reservation)
      }
      .padding(.top, -10)
      .padding(.bottom, 20)
      DatePicker(
        selection: $arrivalTime,
        in: ...Date.now,
        displayedComponents: .hourAndMinute
      ) {
        Text("Arrival Time")
      }
      .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
      Button(action: {
        stay.checkIn(reservation: reservation)
        appState.selectedTab = .reservations
                showConfirm.toggle()
      }, label: {
        HStack {
          Spacer()
          Text("Check In")
          Spacer()
        }
      })
      .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
      .background(Color("brand/turquoise"))
      .foregroundColor(.white)
      .buttonStyle(.bordered)
      .controlSize(.large)
      .cornerRadius(10)
      .padding(.vertical, 20)
    }
    Spacer()
  }
    .sheet(isPresented: $showConfirm) {
      CheckInConfirmView()
    }
  }
}

#Preview {
  CheckInView(reservation: Reservation.sample)
}
