//
//  RouteInstruction.swift
//  UWEMaps
//
//  Created by Tom Clifford on 23/04/2021.
//

import Foundation
import CoreLocation

struct RouteInstruction
{
    let StartPoint: CLLocationCoordinate2D
    let EndPoint: CLLocationCoordinate2D
    let NextPoint: CLLocationCoordinate2D
    let InstructionText: String
    
    init(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D, next: CLLocationCoordinate2D)
    {
        StartPoint = start
        EndPoint = end
        NextPoint = next
        let distance = CLLocation(latitude: start.latitude, longitude: start.longitude).distance(from: CLLocation(latitude: end.latitude, longitude: end.longitude))
        let firstBearing = LocationManager.calculateHeading(start: start, end: end)
        let secondBearing = LocationManager.calculateHeading(start: end, end: next)
        let firstCardinalDirection = LocationManager.GetRoughCardinalDirection(bearing: firstBearing)
        let secondCardinalDirection = LocationManager.GetRoughCardinalDirection(bearing: secondBearing)
        if firstCardinalDirection == secondCardinalDirection
        {
            let direction = RouteInstruction.leftOrRight(firstBearing: firstBearing, secondBearing: secondBearing)
            InstructionText = "Follow the path for \(distance.rounded()) metres then bear \(direction)."
            
        }
        else if RouteInstruction.isOppositeDirection(firstDirection: firstCardinalDirection, secondDirection: secondCardinalDirection)
        {
            InstructionText = "Turn around and follow the path for \(distance.rounded()) metres."
        }
        else
        {
            let direction = RouteInstruction.leftOrRight(firstBearing: firstBearing, secondBearing: secondBearing)
            InstructionText = "Follow the path for \(distance.rounded()), then turn \(direction)."
        }
    }
    
    static func leftOrRight(firstBearing: Double, secondBearing: Double) -> String
    {
        let diffFrom360 = abs(firstBearing - 360.0)
        let normalisedSecond = (secondBearing + diffFrom360).truncatingRemainder(dividingBy: 360.0)
        if normalisedSecond < 180
        {
            return("right")
        }
        else if normalisedSecond > 180
        {
            return("left")
        }
        else
        {
            return("reverse")
        }
//        var opposite = (firstBearing + 180.0).truncatingRemainder(dividingBy: 360.0)
//
//        if firstBearing > secondBearing
//        {
//            if secondBearing < opposite
//            {
//                if opposite > 180
//                {
//                    return("left")
//                }
//                else
//                {
//                    return("right")
//                }
//            }
//            else if secondBearing > opposite
//            {
//                if opposite > 180
//                {
//                    return("left")
//                }
//                else
//                {
//                    return("right")
//                }
//            }
//            else
//            {
//                return("reverse")
//            }
//        }
//        else
//        {
//            if secondBearing > opposite
//            {
//                return("left")
//            }
//            else if secondBearing < opposite
//            {
//                return("right")
//            }
//            else
//            {
//                return("reverse")
//            }
//        }
//        let difference = abs(firstBearing - secondBearing)
//
//        if firstBearing <= 180
//        {
//            if secondBearing >= 0 && secondBearing < firstBearing
//            {
//                return "left"
//            }
//
//        }
//
//        if secondBearing < firstBearing
//        {
//            return "left"
//        }
//        else
//        {
//            return "right"
//        }
    }
    
    static func isOppositeDirection(firstDirection: Route.CompassDirections, secondDirection: Route.CompassDirections) -> Bool
    {
        switch firstDirection {
        case Route.CompassDirections.North:
            if secondDirection == Route.CompassDirections.South
            {
                return true
            }
            else
            {
                return false
            }
        case Route.CompassDirections.East:
            if secondDirection == Route.CompassDirections.West
            {
                return true
            }
            else
            {
                return false
            }
        case Route.CompassDirections.South:
            if secondDirection == Route.CompassDirections.North
            {
                return true
            }
            else
            {
                return false
            }
        case Route.CompassDirections.West:
            if secondDirection == Route.CompassDirections.East
            {
                return true
            }
            else
            {
                return false
            }
        }
    }
}
