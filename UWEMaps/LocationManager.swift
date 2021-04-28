//
//  LocationManager.swift
//  UWEMaps
//
//  Created by Tom Clifford on 23/04/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject
{
    @Published var atDestination = false
    @Published var atInstruction = 0
    var locationManagerInstance = CLLocationManager()
    var currentDestination: CLLocation?
    var currentInstruction: CLLocation?
    
    override init()
    {
        super.init()
        locationManagerInstance.delegate = self
        locationManagerInstance.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    static func calculateHeading(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) -> Double
    {
        let lat1 = start.latitude
        let lon1 = start.longitude
        let lat2 = end.latitude
        let lon2 = end.longitude
        let y = sin(lon2-lon1) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1)
        let calc = atan2(y, x)
        let bearing = (calc*180/Double.pi + 360).truncatingRemainder(dividingBy: 360)
        return(bearing)
    }
    
    /// Takes a bearing and normalises it into one of the cardinal directions
    static func GetRoughCardinalDirection(bearing: Double) -> Route.CompassDirections
    {
        if bearing > 315 || bearing < 45
        {
            return Route.CompassDirections.North
        }
        else if bearing >= 45  && bearing < 135
        {
            return Route.CompassDirections.East
        }
        else if bearing >= 135 && bearing < 225
        {
            return Route.CompassDirections.South
        }
        else
        {
            return Route.CompassDirections.West
        }
    }
    
    func startLocationServices()
    {
        if locationManagerInstance.authorizationStatus == .authorizedAlways || locationManagerInstance.authorizationStatus == .authorizedWhenInUse
        {
            locationManagerInstance.startUpdatingLocation()
        }
        else
        {
            locationManagerInstance.requestWhenInUseAuthorization()
        }
    }
    
    func setDestination(destination: Landmark)
    {
        currentDestination = CLLocation(latitude: destination.Coordinate.latitude, longitude: destination.Coordinate.longitude)
    }
    
    func setInstruction(destination: CLLocation)
    {
        currentInstruction = destination
    }
}

extension LocationManager: CLLocationManagerDelegate
{
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if locationManagerInstance.authorizationStatus == .authorizedAlways || locationManagerInstance.authorizationStatus == .authorizedWhenInUse
        {
            locationManagerInstance.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastestLoc = locations.first else { return }
        guard let destination = currentDestination else { return }
        guard let instruction = currentInstruction else { return }
        let distanceFromDest = lastestLoc.distance(from: destination)
        let distanceFromInstruction = lastestLoc.distance(from: instruction)
        if distanceFromDest <= 3
        {
            atDestination = true
            return
        }
        else if distanceFromInstruction <= 2
        {
            atInstruction += 1
        }
    }
}
