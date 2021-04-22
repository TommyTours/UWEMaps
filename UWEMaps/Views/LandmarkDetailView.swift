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
    @State private var landmarks = loadData()
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                Image(landmarks[0].ImageKey!)//landmark.ImageKey!)
                    .resizable() 
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                ScrollView
                {
                    Text(landmarks[0].Name!)//landmark.Name ?? "Missing Name")
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    Text(landmarks[0].Description!)//landmark.Description ?? "Missing Description")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                        .padding(.bottom, 120)
                }
                Spacer()
            }
            BottomButtonsView()
                .padding(.top, 750)
        }//.onAppear(perform: loadData)
    }
}

private func loadData() -> [Landmark]
{
    var localLandmarkArr = [Landmark]()
    guard
        let fileName = Bundle.main.url(forResource: "TourLandmarksV2", withExtension: "geojson"),
        let landmarkData = try? Data(contentsOf: fileName)
    else {
        return []
    }
    
    do {
        let features = try MKGeoJSONDecoder()
            .decode(landmarkData)
            .compactMap { $0 as? MKGeoJSONFeature }
        let validLandmarks = features.compactMap(Landmark.init)
        let validRoutes =
            features.compactMap(Route.init)
        localLandmarkArr.append(contentsOf: validLandmarks)
    } catch {
        print("Unexpected error: \(error)")
    }
    return localLandmarkArr
//    let fileName = Bundle.main.url(forResource: "Resources/TourLandmarks", withExtension: "geojson")
//    let subDir = Bundle.main.resourceURL!.path//.appendingPathComponent("Resources").path
//    let subDirURL = URL(fileURLWithPath: subDir)
//    let GEOJSONURL = URL(fileURLWithPath: "TourLandmarks", relativeTo: subDirURL).appendingPathExtension("geojson")
//    guard let landmarkData = try? Data(contentsOf: GEOJSONURL) else { return [] }
//
//    do {
//        let features = try MKGeoJSONDecoder()
//            .decode(landmarkData)
//            .compactMap { $0 as? MKGeoJSONFeature }
//        let validLandmarks = features.compactMap(Landmark.init)
//        localLandmarkArr.append(contentsOf: validLandmarks)
//    } catch {
//        print("Unexpected Error \(error)")
//    }
    return localLandmarkArr
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
        let xBlockLocation = CLLocation(latitude: 51.500757, longitude: -2.54974)
        let xBlock = Landmark(name: "Bristol Business School", description: "Located in the heart of Frenchay Campus, the Bristol Business School building was opened in 2017 and offers an innovative way of studying and working – with new social and learning spaces to allow students, staff and business people to work more closely together, and make valuable new connections.\n\nFrom our £55 million investment we have a 17,200m2 space serving 5,500 students and containing 148 offices over seven floors.", coordinate: xBlockLocation.coordinate, imageKey: "BusinessSchool")
        
        LandmarkDetailView()//landmark: xBlock)
        BottomButtonsView()
    }
}
