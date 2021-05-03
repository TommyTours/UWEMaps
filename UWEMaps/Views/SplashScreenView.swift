//
//  SplashScreenView.swift
//  UWEMaps
//
//  Created by Tom Clifford on 02/05/2021.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack
        {
            Spacer()
            HStack
                {
                Spacer()
                Image("UWE_Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300, alignment: .center)
                Spacer()
            }
            Spacer()
        }
        .background(Color("uweGreen"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplashScreenView()
            SplashScreenView()
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
