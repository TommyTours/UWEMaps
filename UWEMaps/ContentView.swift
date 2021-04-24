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
    
    @State var tourData = Tour()
    
    var body: some View {
        TabView {
            MapNavigationView(CurrentTour: $tourData)
            //DistanceToDestBar()
            //Text("sdfasdf")
                .tabItem {
                    Image(systemName: "map")
                    Text("Tour")
                }//
            Text("Browse Landmarks Goes Here")
                .tabItem {
                    Image(systemName: "building")
                    Text("Landmarks")
                }
        }.onAppear {
            tourData = Tour()
        }
            
            //        let xBlockLocation = CLLocation(latitude: 51.500757, longitude: -2.54974)
            //        let xBlock = Landmark(name: "Bristol Business School", description: "Located in the heart of Frenchay Campus, the Bristol Business School building was opened in 2017 and offers an innovative way of studying and working – with new social and learning spaces to allow students, staff and business people to work more closely together, and make valuable new connections.\n\nFrom our £55 million investment we have a 17,200m2 space serving 5,500 students and containing 148 offices over seven floors.", coordinate: xBlockLocation.coordinate, imageKey: "BusinessSchool")
            //
            //        LandmarkDetailView(landmark: xBlock)
            /*List {
             ForEach(items) { item in
             Text("Item at \(item.timestamp!, formatter: itemFormatter)")
             }
             .onDelete(perform: deleteItems)
             }
             .toolbar {
             #if os(iOS)
             EditButton()
             #endif
             
             Button(action: addItem) {
             Label("Add Item", systemImage: "plus")
             }
             }*/
 //
            /*private func addItem() {
             withAnimation {
             //let newItem = Item(context: viewContext)
             //newItem.timestamp = Date()
             
             do {
             try viewContext.save()
             } catch {
             // Replace this implementation with code to handle the error appropriately.
             // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             let nsError = error as NSError
             fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
             }
             }
             }*/
//
            /*private func deleteItems(offsets: IndexSet) {
             withAnimation {
             offsets.map { items[$0] }.forEach(viewContext.delete)
             
             do {
             try viewContext.save()
             } catch {
             // Replace this implementation with code to handle the error appropriately.
             // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             let nsError = error as NSError
             fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
             }
             }
             }*/
        
    }
    private let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()//tourData: .constant(Tour()))//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            ContentView()
                .previewDevice("iPhone SE (2nd generation)")
                .previewDisplayName("iPhone SE (2nd generation)")
        }
    }
}

