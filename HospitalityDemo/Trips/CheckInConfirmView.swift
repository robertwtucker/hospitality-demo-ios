//
//  SPDX-FileCopyright-Text: 2023 Quadient Group AG
//  SPDX-License-Identifier: MIT
//

import SwiftUI

struct CheckInConfirmView: View {
  @Environment(\.dismiss) private var dismiss
  
  var body: some View {
    Group {
      VStack {
        Image("hotel/background")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(maxWidth: .infinity)
        VStack {
          VStack(alignment: .center, spacing: 8) {
            Text("All Checked In!")
              .font(.title)
              .foregroundStyle(Color("brand/brown"))
            Text("Hotel Name")
              .font(.headline)
              .foregroundStyle(Color("brand/turquoise"))
              .bold()
            Text("Room 42")
              .font(.subheadline)
              .foregroundStyle(Color("brand/turquoise"))
              .bold()
          }
          .padding(20)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, -8)
      }
      .background(Color("brand/beige").opacity(0.4))
      .ignoresSafeArea()
      
      Form {
        Section(header: Text("ACTIONS")) {
          Button(action: {}) {
            HStack {
              Image(systemName: "ellipsis.bubble")
                .foregroundColor(Color("brand/aqua"))
                .padding(.trailing, 8)
                .font(.title2)
              Text("Chat With Us")
            }
          }
          .foregroundColor(Color("brand/brown"))
          .padding(.vertical, 8)
          Button(action: {}) {
            HStack {
              Image(systemName: "bell")
                .foregroundColor(Color("brand/aqua"))
                .padding(.trailing, 8)
                .font(.title2)
              Text("Service Requests")
            }
          }
          .foregroundColor(Color("brand/brown"))
          .padding(.vertical, 8)
          Button(action: {}) {
            HStack {
              Image(systemName: "fork.knife")
                .foregroundColor(Color("brand/aqua"))
                .padding(.trailing, 8)
                .font(.title2)
              Text("Browse & Order Food")
            }
          }
          .foregroundColor(Color("brand/brown"))
          .padding(.vertical, 8)
        }
        
        
        
        //        Text("checkin.complete",
        //             comment: "Message confirming the check in process is complete.")
        //        Button {
        //          dismiss()
        //        } label: {
        //          Text("button.ok")
        //        }
      }
      .padding(.top, -65)
    }
  }
    
}

#Preview {
  CheckInConfirmView()
}
