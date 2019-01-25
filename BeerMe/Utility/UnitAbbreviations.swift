//
//  UnitAbbreviations.swift
//  BeerMe
//
//  Created by This Mac on 1/24/19.
//  Copyright © 2019 LopezWorks. All rights reserved.
//

import Foundation

var AbbrevMap = [String:String]()

class AbbreviationsInitializer {
    init() {
        AbbrevMap["grams"] = "g"
        AbbrevMap["kilograms"] = "kgs"
    }
}
