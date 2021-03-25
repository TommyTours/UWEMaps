//
//  LandmarkDetailView.swift
//  UWEMaps
//
//  Created by Tom Clifford on 24/03/2021.
//

import SwiftUI

struct LandmarkDetailView: View
{
    let informationText: String
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                Image("BusinessSchool")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                ScrollView
                {
                Text(informationText)
                    .font(.largeTitle)
                    .padding(.bottom, 120)
                }
                Spacer()
            }
            BottomButtonsView()
                .padding(.top, 750)
        }
    }
}

struct BottomButtonsView: View
{
    var body: some View
    {
        
        HStack
        {
            BigGreenButton(buttonText: "More information", buttonWidth: Constants.General.landmarkButtonWidth, buttonHeight: Constants.General.landmarkButtonHeight)
            Spacer()
            BigGreenButton(buttonText: "Continue Tour", buttonWidth: Constants.General.landmarkButtonWidth, buttonHeight: Constants.General.landmarkButtonHeight)
        }
        .padding()
    }
}

struct LandmarkDetailView_Previews: PreviewProvider
{
    static var previews: some View
    {
        LandmarkDetailView(informationText: "Located in the heart of Frenchay Campus, the Bristol Business School building was opened in 2017 and offers an innovative way of studying and working – with new social and learning spaces to allow students, staff and business people to work more closely together, and make valuable new connections.\n\nFrom our £55 million investment we have a 17,200m2 space serving 5,500 students and containing 148 offices over seven floors.")
        BottomButtonsView()
    }
}
