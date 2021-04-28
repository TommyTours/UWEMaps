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
//    private let itemFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .medium
//        return formatter
//    }()
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()//tourData: .constant(Tour()))//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            ContentView()
                .previewDevice("iPhone SE (2nd generation)")
                .previewDisplayName("iPhone SE (2nd generation)")
        }
    }
}

