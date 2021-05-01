//
//  LandmarkListView.swift
//  UWEMaps
//
//  Created by Tom Clifford on 01/05/2021.
//

import SwiftUI

struct LandmarkListView: DynamicViewContent {
    
    let data: [Landmark]
    
    var body: some View
    {
        NavigationView
        {
            List
            {
                ForEach(data, id: \.Name) { landmark in
                    if landmark.Name != "Parking Machine"
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
                Text(landmark.Name!)
                Spacer()
                Image(landmark.ImageKey ?? "missingImage")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 100, minHeight: 100)
            }
        }
    }
}

struct LandmarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkListView(data: Tour().AllDestinations)
    }
}

