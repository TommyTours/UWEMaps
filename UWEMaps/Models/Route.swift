//
//  Route.swift
//  UWEMaps
//
//  Created by Tom Clifford on 22/04/2021.
//

import Foundation
import CoreLocation
import MapKit

struct Route
{
    let Name: String?
    let Description: String?
    var Coordinates: MKPolyline
    var Instructions: [RouteInstruction] = []
    var CoordinateArray: [CLLocationCoordinate2D]
    let TotalDistance: Double
    
    
    /// Takes a GeoJSON file containing route data and inits a Route instance with the line data converted to an MKPolyline
    init?(feature: MKGeoJSONFeature)
    {
        guard
            let points = feature.geometry.first as? MKPolyline,
            let propertiesData = feature.properties,
            let json = try? JSONSerialization.jsonObject(with: propertiesData),
            let properties = json as? [String: Any]
            else {
                return nil
            }
        Name = properties["name"] as? String
        Description = properties["description"] as? String
        Coordinates = points
        var coordinateArr: [CLLocationCoordinate2D] = []
        let pointCount = points.coordinates.count
        for i in 0...(pointCount-1)
        {
            // If there are at least three points left, this means that there is another step after this and the three argument init for the instruction is called
            if i <= (pointCount - 3)
            {
                Instructions.append(RouteInstruction(start: points.coordinates[i], end: points.coordinates[i+1], next: points.coordinates[i+2]))
            }
            // Else if there are 2 points remaining this is the final step and the 2 argument init is called to create a "you will reach the destination message"
            else if i <= (pointCount - 2)
            {
                Instructions.append(RouteInstruction(start: points.coordinates[i], destination: points.coordinates[i+1]))
            }
            coordinateArr.append(CLLocationCoordinate2D(latitude: points.coordinates[i].latitude, longitude: points.coordinates[i].longitude))
        }
        var runningDistance = 0.0
        Instructions.forEach {
            runningDistance += $0.Distance
        }
        TotalDistance = runningDistance.rounded()
        CoordinateArray = coordinateArr
    }
    
//    init(name: String, description: String, coordinates: [CLLocationCoordinate2D])
//    {
//        Name = name
//        Description = description
//        Coordinates = MKPolyline(coordinates: coordinates, count: coordinates.count)
//    }
    
    /// Goes through the route and bundles any points that are close together (for example to create a curve on the map) into a single point for direction calculation.
    /// Not really working atm
    func GetMeaningfulPoints() -> [CLLocationCoordinate2D]
    {
        var meaningfulPoints: [CLLocationCoordinate2D] = []
        var groupedPoints: [CLLocationCoordinate2D] = []
        guard let firstPoint = Coordinates.coordinates.first else { return meaningfulPoints }
        meaningfulPoints.append(firstPoint)
        var prevCoord = Coordinates.coordinates.first
        for point in Coordinates.coordinates
        {
            if point.latitude == firstPoint.latitude && point.longitude == firstPoint.longitude { continue }
            let distanceBetweenPoints = CLLocation(latitude: prevCoord!.latitude, longitude: prevCoord!.longitude).distance(from: CLLocation(latitude: point.latitude, longitude: point.longitude))
            if distanceBetweenPoints > 27
            {
                if groupedPoints.count > 2
                {
                    meaningfulPoints.append(groupedPoints.first!)
                    meaningfulPoints.append(groupedPoints[groupedPoints.count/2])
                    groupedPoints.removeAll()
                }
                else if !groupedPoints.isEmpty
                {
                    meaningfulPoints.append(groupedPoints.first!)
                    groupedPoints.removeAll()
                }
                meaningfulPoints.append(point)
            }
            else
            {
                groupedPoints.append(point)
            }
            prevCoord = point
        }
        if meaningfulPoints.last?.latitude != prevCoord?.latitude && meaningfulPoints.last?.longitude != prevCoord?.longitude
        {
            meaningfulPoints.append(prevCoord!)
        }
        printLonLat(points: meaningfulPoints)
        return meaningfulPoints
    }
    
    /// Function that prints the lon and lat of a CLLocationCoordinate2D array in the format of a GEOJson line, for the purposes of visualising during debugging.
    func printLonLat(points: [CLLocationCoordinate2D])
    {
        for point in points
        {
            print("[\(point.longitude),\n\(point.latitude)],")
        }
    }
    
    public enum CompassDirections
    {
        case North
        case East
        case South
        case West
    }
}

public extension MKMultiPoint
{
    var coordinates: [CLLocationCoordinate2D]
    {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: pointCount)
        
        getCoordinates(&coords, range: NSRange(location: 0, length: pointCount))
        
        return coords
    }
}
