//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckInView: View {
  @Environment(StayModel.self) private var stayModel
  @Environment(AdvantageSdkModel.self) private var sdkModel
  
  @SwiftUI.State var reservation: Reservation
  @SwiftUI.State private var arrivalTime = Date.now
  @SwiftUI.State private var showConfirm = false
  
  var body: some View {
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
        HotelBannerView(reservation: reservation)
      }
      .padding(.top, -10)
      .padding(.bottom, 20)
      DatePicker(
        selection: $arrivalTime,
        in: ...Date.now,
        displayedComponents: .hourAndMinute
      ) {
        Text("checkin.arrival", comment: "Time of arrival")
      }
      .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
      Button(action: {
        reservation.checkedIn = true
        reservation.guestName = sdkModel.currentUser?.name
        reservation.guestEmail = sdkModel.currentUser?.email
        reservation.guestClientId = sdkModel.currentUser?.clientID
        stayModel.checkIn(reservation: reservation)
        showConfirm.toggle()
      }, label: {
        HStack {
          Spacer()
          Text("button.checkin")
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
      Spacer()
    }
    .sheet(isPresented: $showConfirm) {
      CheckInConfirmView(reservation: reservation)
    }
  }
}

#Preview {
  CheckInView(reservation: Reservation.sampleData)
    .environment(StayModel())
    .environment(AdvantageSdkModel())
}
