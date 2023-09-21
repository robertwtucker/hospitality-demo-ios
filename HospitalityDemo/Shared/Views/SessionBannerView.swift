//
//  Banner.swift
//  HospitalityDemo
//
//  Created by j.stobie on 9/18/23.
//

import SwiftUI

struct SessionBannerView: View {
  var body: some View {
    VStack {
      HStack {
        Text("Welcome Mr. John Doe")
          .padding(.leading, 25)
        Spacer()
        Image(systemName: "person.wave.2")
          .padding(.trailing, 25)
      }
      .padding(.bottom, 15
      )
      .background(Color("brand/brown"))
      .foregroundColor(.white)
      .bold()
      Spacer()
    }
  }
}


struct SessionBannerView_Previews: PreviewProvider {
  static var previews: some View {
    SessionBannerView()
  }
}
