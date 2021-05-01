//
//  ButtonViews.swift
//  UWEMaps
//
//  Created by Tom Clifford on 24/03/2021.
//

import SwiftUI

struct BigGreenButton: View
{
    let buttonText: String
    let buttonHeight: CGFloat
    
    var body: some View
    {
        HStack
        {
            Spacer()
            Text(buttonText)
                .foregroundColor(Color("whiteTextColour"))
                .bold()
                .frame(height: buttonHeight)
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: Constants.General.ButtonCornerRadius)
                .foregroundColor(Color("uweGreen"))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 5)
        )
    }
}

struct ButtonViews_Previews: PreviewProvider
{
    static var previews: some View
    {
        VStack
        {
            BigGreenButton(buttonText: "Test Button Text", buttonHeight: Constants.General.landmarkButtonHeight)
        }
    }
}
