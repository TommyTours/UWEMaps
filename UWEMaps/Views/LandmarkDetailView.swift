//
//  LandmarkDetailView.swift
//  UWEMaps
//
//  Created by Tom Clifford on 24/03/2021.
//

import SwiftUI
import CoreLocation
import MapKit

struct LandmarkDetailView: View
{
    //let landmark: Landmark
    @State var landmark: Landmark
    let currentlyOnTour: Bool
    
    var body: some View
    {
        GeometryReader { geometry in
        ZStack
        {
                        VStack
                        {
                            Image(landmark.ImageKey ?? "missingImage")
                                .resizable()
                                .scaledToFit()
                                .edgesIgnoringSafeArea(.all)
                            ScrollView
                            {
                                Text(landmark.Name ?? "Missing Name")
                                    .font(.largeTitle)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom)
                                Text(landmark.Description ?? "Missing Description")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                                    .padding(.bottom, 120)
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
            VStack
            {
                Spacer()
                BottomButtonsView(currentlyOnTour: currentlyOnTour, height: geometry.size.height)
                    .padding()
            }
        }
        }
    }
}

struct BottomButtonsView: View
{
    let currentlyOnTour: Bool
    let height: CGFloat
    var body: some View
    {
        
            if currentlyOnTour
            {
                HStack
                {
                    Link(destination: URL(string: "https://www.hackingwithswift.com/")!) {
                        BigGreenButton(buttonText: "More information", buttonHeight: height * 0.15)
                    }
                    Spacer()
                    BigGreenButton(buttonText: "Continue Tour",  buttonHeight: height * 0.15)
                }
            }
            else
            {
                Link(destination: URL(string: "https://www.hackingwithswift.com/")!) {
                    BigGreenButton(buttonText: "More information",  buttonHeight: height * 0.15)
                }
                
            }
        
    }
}

struct LandmarkDetailView_Previews: PreviewProvider
{
    static var previews: some View
    {
        let xBlockLocation = CLLocation(latitude: 51.500757, longitude: -2.54974)
        let xBlock = Landmark(name: "Bristol Business School", description: "Located in the heart of Frenchay Campus, the Bristol Business School building was opened in 2017 and offers an innovative way of studying and working – with new social and learning spaces to allow students, staff and business people to work more closely together, and make valuable new connections.\n\nFrom our £55 million investment we have a 17,200m2 space serving 5,500 students and containing 148 offices over seven floors.", coordinate: xBlockLocation.coordinate, imageKey: "BusinessSchool")
        GeometryReader { geometry in
        LandmarkDetailView(landmark: xBlock, currentlyOnTour: true)
            //BottomButtonsView(currentlyOnTour: false, height: geometry.size.height, width: geometry.size.width)
        }
    }
}
