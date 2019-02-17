//
//  SwiftWrapper.swift
//  SwiftWrapperForCLib
//
//  Created by ceciliah on 2/13/31 H.
//  Copyright © 31 Heisei Humlan. All rights reserved.
//

import Foundation
import CWrapper

//Relavant read https://developer.apple.com/documentation/swift/imported_c_and_objective-c_apis/using_imported_c_macros_in_swift

public func randomString(size: Int) -> String {
    let str = randomString(Int32(size))
    defer {
        str?.deallocate()
    }
    return String(cString: str!)
}


// Mark: macro - C macro does not work in swift. So in C we need a c wrapper for c macros
// because macro is not c code, but pre processor code.
//method overloading: same function name but takes different types
public func max(x:Int, y:Int) -> Int {
    return Int(maxInt(Int32(x), Int32(y)))
}

public func max(x:Float, y:Float) -> Float {
    return maxFloat(x, y)
}

public func max(x:Double, y:Double) -> Double {

    return maxDouble(x, y)
}

// Mark: global variable

public var globalNumber: Int {
    get {
        return Int(CWrapper.globalNumber)
    }
    set {
        CWrapper.globalNumber = Int32(newValue)
    }
}


// Mark:  struct
public struct Nationality {
    let identifier: Int
    let country: String

    // In c, the lib is only responsible for creating struct and not storing the or doing memory management.

    private var cStruct: CWrapper.Nationality {

        return country.withCString{ (ptstr) -> CWrapper.Nationality in
            return CWrapper.Nationality(
                identifier: Int32(identifier),
                country: UnsafeMutablePointer(mutating: ptstr))
        }
    }

    public func printCountry() {
        //UnsafeMutablePointer<Nationality>!
        //& is a reference, and print_nationlity_country wants a pointer. & converts a struct into pointer to a struct
        //it also complained about get only property can not convert to inout
        var mutableVariable = cStruct
       // CWrapper.print_nationlity_country(&mutableVariable)
        CWrapper.print_nationlity_country(&mutableVariable)
    }

    //initializer is internal by default, need to override it
    public init(identifier: Int, country: String) {
        self.identifier = identifier
        self.country = country
    }
}


// Mark: enum
public enum Week: Int {
    case 月曜日
    case 火曜日
    case 水曜日
    case 木曜日
    case 金曜日
    case 土曜日
    case 日曜日

    init(weekDay: CWrapper.曜日) {
        switch weekDay {
        case CWrapper.月曜日:
            self = .月曜日
        case CWrapper.火曜日:
            self = .火曜日
        case CWrapper.水曜日:
            self = .水曜日
        case CWrapper.木曜日:
            self = .木曜日
        case CWrapper.金曜日:
            self = .金曜日
        case CWrapper.土曜日:
            self = .土曜日
        case CWrapper.日曜日:
            self = .日曜日
        default:
            fatalError()
        }
    }

    var cWeekDay: CWrapper.曜日 {
        get {
            switch self {
            case .月曜日:
                return CWrapper.月曜日
            case .火曜日:
                return CWrapper.火曜日
            case .水曜日:
                return CWrapper.水曜日
            case .木曜日:
                return CWrapper.木曜日
            case .金曜日:
                return CWrapper.金曜日
            case .土曜日:
                return CWrapper.土曜日
            case .日曜日:
                return CWrapper.日曜日
            }
        }
    }

    public func printWeekDay() {
        print("C week day is \(cWeekDay)")
        let swiftWeekDay = Week(weekDay: cWeekDay)
        print(" swift week day is \(swiftWeekDay)")
    }
}

public func todayIs() -> Week {
    let CDay = CWrapper.currentDayOfWeek()
    let SDay = Week(weekDay: CDay)
    print("day string is \(SDay)")
    return SDay
}



//Declare this as optional, global value that stores local closure
var globalClosure: ((Int)->Int)?

public func functionPointer(startValue: Int, getNextValue: @escaping (Int)->Int) ->Int {
    globalClosure = getNextValue

    func localClosure(val: Int32) -> Int32 {
        return Int32(globalClosure!(Int(val)))
    }
    return Int(CWrapper.functionPointer(Int32(startValue), localClosure))
}





