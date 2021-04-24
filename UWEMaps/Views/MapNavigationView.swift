//
//  NavigationView.swift
//  UWEMaps
//
//  Created by Tom Clifford on 24/04/2021.
//

import SwiftUI

struct MapNavigationView: View {
    
    @StateObject var locationManager = LocationManager()
    let Map = MapViewUIRepresentable()
    @Binding var CurrentTour: Tour
    
    var body: some View {
        GeometryReader { geometry in
            ZStack
            {
                Map.edgesIgnoringSafeArea(.all)
                VStack
                {
                    InstructionView(instruction: CurrentTour.CurrentInstruction, height: geometry.size.height)
                    Spacer()
                    DistanceToDestBar(height: geometry.size.height)
                        .padding(.bottom)
                }
            }
            .sheet(isPresented: $locationManager.atDestination, onDismiss: {
                CurrentTour.nextRoute()
                
            } ) {
                LandmarkDetailView(landmark: CurrentTour.CurrentDestination)
            }
        }
    }
}

struct DistanceToDestBar: View {
    let height: CGFloat
    var body: some View {
        ZStack
        {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(height: height * 0.15)
                .foregroundColor(.white)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 5)
                .padding()
            Text("Hey Oh")
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        //let tour = Tour()
        //NavigationView(currentTour: .constant(Tour()))
        ContentView()
        Text("Nah")
    }
}
