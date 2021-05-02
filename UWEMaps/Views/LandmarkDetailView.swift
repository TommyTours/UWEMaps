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
                            if landmark.ImageKey != nil
                            {
                                ImageFromImageKeyView(imageKey: landmark.ImageKey!)
                                .scaledToFit()
                                .edgesIgnoringSafeArea(.all)
                            }
                            else if landmark.ImageURL != nil
                            {
                                ImageFromURLView(landmark.ImageURL!)
                                    .clipped()
                                    .scaledToFill()
                                    .frame(maxWidth: geometry.size.width, minHeight: (geometry.size.height * 0.3), maxHeight: (geometry.size.height * 0.4))
                                    //.edgesIgnoringSafeArea(.top)
                            }
                            else
                            {
                                ImageFromImageKeyView(imageKey: "missingImage")
                                    .scaledToFit()
                                    .edgesIgnoringSafeArea(.all)
                            }
                            ScrollView
                            {
                                Text(landmark.Name ?? "Missing Name")
                                    .font(.largeTitle)
                                    .bold()
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom)
                                Text(landmark.Description ?? "Missing Description")
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                    .padding(.horizontal)
                                    .padding(.bottom, 120)
                            }
                            .padding(.horizontal)
                            Spacer()
                        }.edgesIgnoringSafeArea(.all)
            VStack
            {
                Spacer()
                BottomButtonsView(currentlyOnTour: currentlyOnTour, height: geometry.size.height, moreDetailsURL: landmark.MoreDetailsURL ?? "https://www.uwe.ac.uk")
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
    let moreDetailsURL: String
    
    var body: some View
    {
        
            if currentlyOnTour
            {
                HStack
                {
                    Link(destination: URL(string: moreDetailsURL)!) {
                        BigGreenButton(buttonText: "More information", buttonHeight: height * 0.15)
                    }
                    Spacer()
                    BigGreenButton(buttonText: "Continue Tour",  buttonHeight: height * 0.15)
                }
            }
            else
            {
                Link(destination: URL(string: moreDetailsURL)!) {
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
        let xBlock = Landmark(name: "Bristol Business School", description: "Located in the heart of Frenchay Campus, the Bristol Business School building was opened in 2017 and offers an innovative way of studying and working – with new social and learning spaces to allow students, staff and business people to work more closely together, and make valuable new connections.\n\nFrom our £55 million investment we have a 17,200m2 space serving 5,500 students and containing 148 offices over seven floors.", coordinate: xBlockLocation.coordinate, imageKey: /*"BusinessSchool"*/nil, imageURL: "https://www.uwe.ac.uk/-/media/uwe/images/life/bristol-business-school-410x230.jpg", moreDetailsURL: "https://www.uwe.ac.uk/about/faculties-and-departments/business-and-law/bristol-business-school")
        let SU = Landmark(name: "Student's Union Building", description: "Completed in 2015, the Students' Union building houses all of the SU services as well as the SU shop and Cafe/Bar with indoor and outdoor seating.", coordinate: CLLocationCoordinate2D(latitude: 51.500712, longitude: -2.550384), imageKey: nil, imageURL: "https://www1.uwe.ac.uk/images/student-union-campus-dev.jpg", moreDetailsURL: "https://www.uwe.ac.uk/life/campus-and-facilities/students-union-building")
        let testLandmark = Landmark(name: "Heading Text", description: "Body Text Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", coordinate: xBlockLocation.coordinate, imageKey: "redSquare", imageURL: nil, moreDetailsURL: nil)
        Group {
            GeometryReader { geometry in
            LandmarkDetailView(landmark: SU, currentlyOnTour: true)
                //BottomButtonsView(currentlyOnTour: false, height: geometry.size.height, width: geometry.size.width)
            }
            GeometryReader { geometry in
                LandmarkDetailView(landmark: SU, currentlyOnTour: true)
                //BottomButtonsView(currentlyOnTour: false, height: geometry.size.height, width: geometry.size.width)
            }
            .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
