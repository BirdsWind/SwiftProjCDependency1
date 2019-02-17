//
//  SwiftWrapperForCLibTests.swift
//  SwiftWrapperForCLibTests
//
//  Created by ceciliah on 2/8/31 H.
//  Copyright © 31 Heisei Humlan. All rights reserved.
//

import XCTest
import SwiftWrapperForCLib

class SwiftWrapperForCLibTests: XCTestCase {

    func testSwiftRandomString() {
        let result = randomString(size: 5)
        print("result is \(result)")
    }

    func testMacroInt() {
        let result = max(x: 5, y: 6)
        XCTAssertEqual(result, 6)
    }

    func testGlobalVariable() {
        globalNumber = 5
        XCTAssertEqual(globalNumber, 5)
    }

    func testStruct() {
        let nationality = Nationality(identifier: 123, country: "Sweden")
        nationality.printCountry()
    }

    func testEnum() {
        let result = todayIs()
        //This gets the simulators locale
        //https://developer.apple.com/documentation/foundation/nscalendar/unit/1416394-weekday
        let SResult = Calendar.current.dateComponents([.weekday], from: Date()).weekday! - 1
        XCTAssertEqual(result.rawValue, SResult)
    }

    func testFunctionalPointer() {

        func local(startValue: Int) -> Int {
            return startValue * startValue
        }
        let result = functionPointer(startValue: 5, getNextValue: local)

        XCTAssertEqual(result, 25)
    }
}


