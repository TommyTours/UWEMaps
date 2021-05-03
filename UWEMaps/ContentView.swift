//
//  ContentView.swift
//  UWEMaps
//
//  Created by Tom Clifford on 24/03/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    /*@Environment(\.managedObjectContext) private var viewContext
     
     @FetchRequest(
     sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
     animation: .default)
     private var items: FetchedResults<Item>*/
    
    @State var tourData = Tour("TourLandmarksV4")
    //@State var showingSplash = true
    
    var body: some View {
        //        ZStack{
        TabView {
            MapNavigationView(CurrentTour: $tourData)
                .tabItem {
                    Image(systemName: "map")
                    Text("Tour")
                }
            LandmarkListView(data: $tourData.AllDestinations)
                .tabItem {
                    Image(systemName: "building")
                    Text("Landmarks")
                }
        }
        //For some reason splash screen breaking map zoom when you start location services
        //            SplashScreenView()
        //                .opacity(showingSplash ? 1 : 0)
        //                .onAppear {
        //                  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        //                    withAnimation() {
        //                      self.showingSplash = false
        //                    }
        //                  }
        //              }
        
        //        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()//tourData: .constant(Tour()))//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            ContentView()
                .previewDevice("iPhone SE (2nd generation)")
                .previewDisplayName("iPhone SE (2nd generation)")
        }
    }
}

