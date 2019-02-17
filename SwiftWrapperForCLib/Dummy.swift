//
//  Dummy.swift
//  SwiftWrapperForCLib
//
//  Created by ceciliah on 2/12/31 H.
//  Copyright © 31 Heisei Humlan. All rights reserved.
//

import Foundation
import CWrapper
class Dummy {

    func dummier() {
        // Use the C library code, otherwise it is NOT properly linked
        let bytes = randomString(10)
        //Yeah swift has functions to talk to C
        let result = String(cString: bytes!)
        print("in Project, new string from c \(result)")
    }

}
