//
//  Tour.swift
//  UWEMaps
//
//  Created by Tom Clifford on 24/04/2021.
//

import Foundation
import MapKit

struct Tour
{
    let AllDestinations: [Landmark]
    let AllRoutes: [Route]
    var CurrentRouteNumber = 0
    var CurrentInstructionNumber = 0
    let DestinationCount: Int
    var CurrentRoute: Route
    var CurrentInstruction: RouteInstruction
    var CurrentDestination: Landmark
    var DistanceToDest: Double
    var ArrivalTime: Date
    var TimeToDest: Int
    
    init()
    {
        AllDestinations = Tour.loadLandmarkData()
        AllRoutes = Tour.loadRouteData()
        DestinationCount = AllDestinations.count
        CurrentRoute = AllRoutes.first!
        CurrentInstruction = CurrentRoute.Instructions.first!
        CurrentDestination = AllDestinations[1]
        DistanceToDest = CurrentRoute.TotalDistance
        var date = Date()
        let secondsToDest = DistanceToDest * 1.4
        date.addTimeInterval(TimeInterval(secondsToDest))
        ArrivalTime = date
        TimeToDest = Int((secondsToDest).rounded())
    }
    
    mutating func nextRoute()
    {
        print("Next Route")
        CurrentRouteNumber += 1
        CurrentInstructionNumber = 0
        CurrentRoute = AllRoutes[CurrentRouteNumber]
        CurrentDestination = AllDestinations[CurrentRouteNumber+1]
        CurrentInstruction = CurrentRoute.Instructions.first!
        DistanceToDest  = CurrentRoute.TotalDistance
        var date = Date()
        let secondsToDest = DistanceToDest * 1.4
        date.addTimeInterval(TimeInterval(secondsToDest))
        ArrivalTime = date
        TimeToDest = Int((secondsToDest).rounded())
        print("Time to dest: \(String(TimeToDest))")
    }
    
    mutating func nextInstruction()
    {
        print("Next Instruction")
        CurrentInstructionNumber += 1
        if CurrentInstructionNumber < CurrentRoute.Instructions.count
        {
            DistanceToDest -= CurrentInstruction.Distance
            var date = Date()
            let secondsToDest = DistanceToDest * 1.4
            date.addTimeInterval(TimeInterval(secondsToDest))
            ArrivalTime = date
            TimeToDest = Int((secondsToDest).rounded())

            CurrentInstruction = CurrentRoute.Instructions[CurrentInstructionNumber]
        }
        print(CurrentInstruction.InstructionText)
        if CurrentRoute.CoordinateArray.count > 0
        {
            CurrentRoute.CoordinateArray.remove(at: 0)
        }
        CurrentRoute.Coordinates = MKPolyline(coordinates: CurrentRoute.CoordinateArray, count: CurrentRoute.CoordinateArray.count)
    }
    
    private static func loadLandmarkData() -> [Landmark]
    {
        var localLandmarkArr = [Landmark]()
        guard
            let fileName = Bundle.main.url(forResource: "TourLandmarksV2", withExtension: "geojson"),
            let landmarkData = try? Data(contentsOf: fileName)
        else {
            return []
        }
        
        do {
            let decodedJSON = try MKGeoJSONDecoder()
                .decode(landmarkData)
                .compactMap { $0 as? MKGeoJSONFeature }
            let validLandmarks = decodedJSON.compactMap(Landmark.init)
            localLandmarkArr.append(contentsOf: validLandmarks)
        } catch {
            print("Unexpected error: \(error)")
        }
        return localLandmarkArr
        //        let fileName = Bundle.main.url(forResource: "Resources/TourLandmarks", withExtension: "geojson")
        //        let subDir = Bundle.main.resourceURL!.path//.appendingPathComponent("Resources").path
        //        let subDirURL = URL(fileURLWithPath: subDir)
        //        let GEOJSONURL = URL(fileURLWithPath: "TourLandmarks", relativeTo: subDirURL).appendingPathExtension("geojson")
        //        guard let landmarkData = try? Data(contentsOf: GEOJSONURL) else { return [] }
        //
        //        do {
        //            let features = try MKGeoJSONDecoder()
        //                .decode(landmarkData)
        //                .compactMap { $0 as? MKGeoJSONFeature }
        //            let validLandmarks = features.compactMap(Landmark.init)
        //            localLandmarkArr.append(contentsOf: validLandmarks)
        //        } catch {
        //            print("Unexpected Error \(error)")
        //        }
        //        return localLandmarkArr
    }
    
    private static func loadRouteData() -> [Route]
    {
        var routes = [Route]()
        guard
            let fileName = Bundle.main.url(forResource: "TourLandmarksV2", withExtension: "geojson"),
            let landmarkData = try? Data(contentsOf: fileName)
        else {
            return []
        }
        
        do {
            let decodedJSON = try MKGeoJSONDecoder()
                .decode(landmarkData)
                .compactMap { $0 as? MKGeoJSONFeature }
            let validRoutes =
                decodedJSON.compactMap(Route.init)
            routes.append(contentsOf: validRoutes)
        } catch {
            print("Unexpected error: \(error)")
        }
        return routes
    }
}
