//
//  NavigationView.swift
//  UWEMaps
//
//  Created by Tom Clifford on 24/04/2021.
//

import SwiftUI
import CoreLocation

struct MapNavigationView: View {
    
    @StateObject var locationManager = LocationManager()
    let Map = MapViewUIRepresentable()
    @Binding var CurrentTour: Tour
    @State var InstructionCompleted: Bool = false
    @State var RemainingDistance: Double = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack
            {
                Map.edgesIgnoringSafeArea(.all)
                    .onChange(of: locationManager.atInstruction) { newValue in
                        nextInstruction()
                    }
                VStack
                {
                    InstructionView(instruction: CurrentTour.CurrentInstruction, height: geometry.size.height)
                        .padding(.top)
                    Spacer()
                    Button( action: {
                        Map.drawRouteOnMap(route: CurrentTour.CurrentRoute)
                        Map.resetUserTracking()
                        //Improvement, work out how to not force unwrap
                        //Map.centreAndZoomOnPoint(CurrentTour.CurrentRoute.Coordinates.coordinates.first!)
                        locationManager.setDestination(destination: CurrentTour.CurrentDestination)
                        locationManager.setInstruction(destination: CLLocation(latitude: CurrentTour.CurrentInstruction.EndPoint.latitude, longitude: CurrentTour.CurrentInstruction.EndPoint.longitude))
                        locationManager.startLocationServices()
                    }) {
                        DistanceToDestBar(height: geometry.size.height, distance: CurrentTour.DistanceToDest, time: CurrentTour.TimeToDest, arrivalTime: CurrentTour.ArrivalTime)
                            .padding(.bottom)
                    }
                    
                }
                VStack
                {
                    Spacer()
                    HStack
                    {
                        Button( action: {
                            CurrentTour.nextRoute()
                            locationManager.setDestination(destination: CurrentTour.CurrentDestination)
                            locationManager.setInstruction(destination: CLLocation(latitude: CurrentTour.CurrentInstruction.EndPoint.latitude, longitude: CurrentTour.CurrentInstruction.EndPoint.longitude))
                            Map.drawRouteOnMap(route: CurrentTour.CurrentRoute)

                        }) {
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 50, height: 50, alignment: .leading)
                        }
                        .padding()
                        Spacer()
                    }
                    Spacer()
                }
            }
            .sheet(isPresented: $locationManager.atDestination, onDismiss: {
                CurrentTour.nextRoute()
                Map.drawRouteOnMap(route: CurrentTour.CurrentRoute)
                locationManager.setInstruction(destination: CLLocation(latitude: CurrentTour.CurrentInstruction.EndPoint.latitude, longitude: CurrentTour.CurrentInstruction.EndPoint.longitude))
                locationManager.setDestination(destination: CurrentTour.CurrentDestination)

            } ) {
                LandmarkDetailView(landmark: CurrentTour.CurrentDestination)
            }
        }
    }
    
    func nextInstruction()
    {
        CurrentTour.nextInstruction()
        locationManager.setDestination(destination: CurrentTour.CurrentDestination)
        locationManager.currentInstruction = CLLocation(latitude: CurrentTour.CurrentInstruction.EndPoint.latitude, longitude: CurrentTour.CurrentInstruction.EndPoint.longitude)
        Map.drawRouteOnMap(route: CurrentTour.CurrentRoute)
    }
}

struct DistanceToDestBar: View {
    let Height: CGFloat
    let dateFormatter = DateFormatter()
    var Distance: Double
    var Time: Int
    var ArrivalTime: Date
//    @State var Time: Int
//    @State var ArrivalTime: Date
    
    init(height: CGFloat, distance: Double, time: Int, arrivalTime: Date)
    {
        Height = height
        Distance = distance//.init(initialValue: distance)
        Time = time
        ArrivalTime = arrivalTime
//        let secondsToDest = distance * 1.4
//        //_Time = .init(initialValue: Int((secondsToDest).rounded()))
//        var date = Date()
//        date.addTimeInterval(TimeInterval(secondsToDest))
//        //_ArrivalTime = .init(initialValue: date)
        dateFormatter.dateFormat = "hh:mm"
    }
    
    var body: some View {
        ZStack
        {
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(Color("NavViewInstructionBackgroundColour"))
                .frame(height: Height * 0.15)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 5)
                .padding()
            HStack
            {
                VStack
                {
                    Text(dateFormatter.string(from: ArrivalTime))
                    Text("Arrival")
                }
                Spacer()
                VStack
                {
                    Text("\(Int(Distance))")
                    Text("Metres")
                }
                Spacer()
                VStack
                {
                    Text("\(String(format: "%02d", arguments: [Time/60])):\(String(format: "%02d", arguments: [Time%60]))")
                    Text("Minutes")
                }
            }
            .padding(.horizontal, 40)
            .foregroundColor(Color("NavViewInstructionTextColour"))
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        //let tour = Tour()
        //NavigationView(currentTour: .constant(Tour()))
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
            ContentView()
                .previewDevice("iPhone SE (2nd generation)")
                
        }
    }
}
