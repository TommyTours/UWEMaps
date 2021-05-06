//
//  LandmarkListView.swift
//  UWEMaps
//
//  Created by Tom Clifford on 01/05/2021.
//

import SwiftUI

struct LandmarkListView: DynamicViewContent {
    
    @Binding var data: [Landmark]
    
    var body: some View
    {
        NavigationView
        {
            List
            {
                ForEach(data, id: \.Name) { landmark in
                    if landmark.Name != "Parking Machine" && landmark.Name != "End of Tour"
                    {
                        LandmarkListRow(landmark: landmark)
                    }
                }
            }
        }
    }
}

struct LandmarkListRow: View {
    let landmark: Landmark
    
    var body: some View
    {
        NavigationLink(destination: LandmarkDetailView(landmark: landmark, currentlyOnTour: false))
        {
            HStack
            {
                Image(landmark.ImageKey ?? "missingImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(12)
                Text(landmark.Name ?? "Missing Name")
                Spacer()
            }
        }
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView(data: .constant(Tour("localTour").AllDestinations))
    }
}

