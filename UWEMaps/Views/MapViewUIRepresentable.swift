//
//  MapViewUIRepresentable.swift
//  UWEMaps
//
//  Created by Tom Clifford on 24/04/2021.
//

import Foundation
import MapKit
import SwiftUI

struct MapViewUIRepresentable: UIViewRepresentable
{
    var mapViewInstance = MKMapView()
    
    func makeUIView(context: Context) -> some MKMapView
    {
        return mapViewInstance
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate
    {
        var parent: MapViewUIRepresentable
        
        init(_ parent: MapViewUIRepresentable) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
        {
            if overlay is MKPolyline
            {
                let lineView = MKPolylineRenderer(overlay: overlay)
                lineView.strokeColor = .blue
                return lineView
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
