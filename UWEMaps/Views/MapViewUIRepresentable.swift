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
        mapViewInstance.isRotateEnabled = false
        mapViewInstance.delegate = context.coordinator
        mapViewInstance.showsUserLocation = true
        mapViewInstance.cameraZoomRange = MKMapView.CameraZoomRange(
            maxCenterCoordinateDistance: 2000)
        mapViewInstance.userTrackingMode = .followWithHeading
        return mapViewInstance
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        mapViewInstance.setUserTrackingMode(.followWithHeading, animated: true)
    }
    
    func resetUserTracking()
    {
        print("\(mapViewInstance.cameraZoomRange.debugDescription)")
        mapViewInstance.setUserTrackingMode(.followWithHeading, animated: true)
    }
    
    func drawRouteOnMap(route: Route)
    {
        if mapViewInstance.overlays.count > 0
        {
            for overlay in mapViewInstance.overlays
            {
                mapViewInstance.removeOverlay(overlay)
            }
        }
        mapViewInstance.addOverlay(route.Coordinates)
    }
    
    func centreAndZoomOnPoint(_ point: CLLocationCoordinate2D)
    {
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: point, span: span)
        mapViewInstance.setRegion(region, animated: true)
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
                lineView.strokeColor = UIColor(Color("RouteLineColour"))
                lineView.lineWidth = 8.0
                return lineView
            }
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
