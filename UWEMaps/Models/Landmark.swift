//
//  Landmark.swift
//  UWEMaps
//
//  Created by Tom Clifford on 08/04/2021.
//

import Foundation
import CoreLocation
import MapKit

struct Landmark
{
    let Name: String?
    let Description: String?
    let Coordinate: CLLocationCoordinate2D
    let ImageKey: String?
    let ImageURL: String?
    let MoreDetailsURL: String?
    
    init?(feature: MKGeoJSONFeature)
    {
        guard
            let point = feature.geometry.first as? MKPointAnnotation,
            let propertiesData = feature.properties,
            let json = try? JSONSerialization.jsonObject(with: propertiesData),
            let properties = json as? [String: Any]
            else {
                return nil
            }
        Name = properties["name"] as? String
        Description = properties["description"] as? String
        Coordinate = point.coordinate
        ImageKey = properties["imagekey"] as? String
        ImageURL = properties["imageURL"] as? String
        MoreDetailsURL = properties["moreDetailsURL"] as? String
    }
    
    init(name: String, description: String, coordinate: CLLocationCoordinate2D, imageKey: String?, imageURL: String?, moreDetailsURL: String?)
    {
        Name = name
        Description = description
        Coordinate = coordinate
        ImageKey = imageKey
        ImageURL = imageURL
        MoreDetailsURL = moreDetailsURL
    }
}
