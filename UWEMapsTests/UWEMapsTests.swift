//
//  UWEMapsTests.swift
//  UWEMapsTests
//
//  Created by Tom Clifford on 24/03/2021.
//

import XCTest
@testable import UWEMaps

class UWEMapsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testNorthZero()
    {
        let bearing = 0.0
        let direction = LocationManager.GetRoughCardinalDirection(bearing: bearing)
        XCTAssertEqual(direction, Route.CompassDirections.North)
    }
    
    func testNorth360()
    {
        let bearing = 360.0
        let direction = LocationManager.GetRoughCardinalDirection(bearing: bearing)
        XCTAssertEqual(direction, Route.CompassDirections.North)
    }
    
    func testEast()
    {
        let bearing = 76.0
        let direction = LocationManager.GetRoughCardinalDirection(bearing: bearing)
        XCTAssertEqual(direction, Route.CompassDirections.East)
    }
    func testSouth()
    {
        let bearing = 224.0
        let direction = LocationManager.GetRoughCardinalDirection(bearing: bearing)
        XCTAssertEqual(direction, Route.CompassDirections.South)
    }
    func testWest()
    {
        let bearing = 301.0
        let direction = LocationManager.GetRoughCardinalDirection(bearing: bearing)
        XCTAssertEqual(direction, Route.CompassDirections.West)
    }
    
    func testLeft1()
    {
        let bearing1 = 160.0
        let bearing2 = 30.0
        let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
        XCTAssertEqual(direction, "left")
    }
    func testLeft2()
    {
        let bearing1 = 3.0
        let bearing2 = 355.0
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "left")
    }
    func testLeft3()
    {
        let bearing1 = 142.0
        let bearing2 = 108.0
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "left")
    }
    func testleft4()
    {
        let bearing1 = 2.0
        let bearing2 = 314.0
        let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
        XCTAssertEqual(direction, "left")
    }
    func testleft5()
    {
        let bearing1 = 1.0
        let bearing2 = 359.0
        let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
        XCTAssertEqual(direction, "left")
    }
    func testleft6()
    {
        let bearing1 = 48.24158211461568
        let bearing2 = 281.3731067004416
        let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
        XCTAssertEqual(direction, "left")
    }
    func testleft7()
    {
        let bearing1 = 229.11022408403733
        let bearing2 = 140.1000085992418
        let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
        XCTAssertEqual(direction, "left")
    }
    func testleft8()
    {
        let bearing1 = 262.9759405467405
        let bearing2 = 174.95145141082494
        let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
        XCTAssertEqual(direction, "left")
    }
    func testleft9()
    {
        let bearing1 = 60.759133881004765
        let bearing2 = 264.25502880647224
        let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
        XCTAssertEqual(direction, "left")
    }
    func testleft10()
    {
        let bearing1 = 5.075181750573425
        let bearing2 = 263.89519826697807
        let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
        XCTAssertEqual(direction, "left")
    }
    func testright1()
    {
        let bearing1 = 63.0
        let bearing2 = 92.0
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "right")
    }
    func testright2()
    {
        let bearing1 = 4.0
        let bearing2 = 54.0
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "right")
    }
    func testright3()
    {
        let bearing1 = 9.0
        let bearing2 = 74.0
        let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
        XCTAssertEqual(direction, "right")
    }
    func testright4()
    {
        let bearing1 = 355.0
        let bearing2 = 3.0
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "right")
    }
    func testright5()
    {
        let bearing1 = 125.42787597885257
        let bearing2 = 242.27462639414577
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "right")
    }
    func testright6()
    {
        let bearing1 = 171.65218928160687
        let bearing2 = 242.27462639414577
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "right")
    }
    func testright7()
    {
        let bearing1 = 327.18569252295595
        let bearing2 = 335.65105824318033
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "right")
    }
    func testright8()
    {
        let bearing1 = 178.97099332701956
        let bearing2 = 190.66358584484172
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "right")
    }
    func testright9()
    {
        let bearing1 = 329.3060176829088
        let bearing2 = 137.650465949485
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "right")
    }
    func testReverse()
    {
        let bearing1 = 3.0
        let bearing2 = 183.0
            let direction = RouteInstruction.leftOrRight(firstBearing: bearing1, secondBearing: bearing2)
            XCTAssertEqual(direction, "reverse")

    }
    
    
}
