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
    let Coordinates: MKPolyline
    
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
    }
    
    init(name: String, description: String, coordinates: [CLLocationCoordinate2D])
    {
        Name = name
        Description = description
        Coordinates = MKPolyline(coordinates: coordinates, count: coordinates.count)
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
