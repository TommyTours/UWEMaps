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
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    var body: some View
    {
        Text(buttonText)
            .foregroundColor(Color("whiteTextColour"))
            .bold()
            .padding()
            .frame(width: buttonWidth, height: buttonHeight)
            .background(
                RoundedRectangle(cornerRadius: Constants.General.ButtonCornerRadius)
                            .foregroundColor(Color("uweGreen"))
            )
    }
}

struct ButtonViews_Previews: PreviewProvider
{
    static var previews: some View
    {
        VStack
        {
            BigGreenButton(buttonText: "Test Button Text", buttonWidth: Constants.General.landmarkButtonWidth, buttonHeight: Constants.General.landmarkButtonHeight)
        }
    }
}
