//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckInView: View {
  @Environment(StayModel.self) private var stayModel
  @Environment(AdvantageSdkModel.self) private var sdkModel
  
  @SwiftUI.State private var arrivalTime = Date.now
  @SwiftUI.State private var showConfirm = false
  
  let reservation: Reservation
  let dateRange: ClosedRange<Date> = {
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour], from: Date.now)
    let startComponents = DateComponents(
      year: components.year,
      month: components.month,
      day: components.day,
      hour: (components.hour ?? 0) + 1,
      minute: 0)
    let endComponents = DateComponents(
      year: components.year,
      month: components.month,
      day: components.day,
      hour: 23,
      minute: 59)
    return calendar.date(from:startComponents)!
    ...
    calendar.date(from:endComponents)!
  }()
  
  var body: some View {
    VStack {
      Image(K.Images.General.checkIn)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
      ZStack(alignment: .top) {
        ReservationDetailsView(reservation: reservation)
          .padding(.top, 60)
          .padding(.bottom, 20)
          .padding(.horizontal, 20)
          .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
          .background(Color(K.Colors.beige).opacity(0.4))
          .cornerRadius(15)
        HotelBannerView(reservation: reservation)
      }
      .padding(.top, -10)
      .padding(.bottom, 20)
      DatePicker(
        selection: $arrivalTime,
        in: dateRange,
        displayedComponents: .hourAndMinute
      ) {
        Text("checkin.arrival", comment: "Time of arrival")
      }
      .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
      Button(action: {
        var tempRes = reservation
        tempRes.checkedIn = true
        tempRes.guestName = sdkModel.currentUser?.name
        tempRes.guestEmail = sdkModel.currentUser?.email
        tempRes.guestClientId = sdkModel.currentUser?.clientID
        stayModel.checkIn(reservation: tempRes)
        showConfirm.toggle()
      }, label: {
        HStack {
          Spacer()
          Text("button.checkin")
          Spacer()
        }
      })
      .frame(maxWidth: UIScreen.main.bounds.size.width - 50)
      .background(Color(K.Colors.turquoise))
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
