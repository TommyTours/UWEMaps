//
//  LocationManager.swift
//  UWEMaps
//
//  Created by Tom Clifford on 23/04/2021.
//

import Foundation
import CoreLocation

class LocationManager
{
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
        print(bearing)
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
}
