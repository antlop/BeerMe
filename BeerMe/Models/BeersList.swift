//
//  BeersList.swift
//  BeerMe
//
//  Created by This Mac on 1/22/19.
//  Copyright © 2019 LopezWorks. All rights reserved.
//

import Foundation

class BeersList: NSObject {
    var m_lBeers : [SimpleBeer]?
    
    init(beers:[SimpleBeer?]) {
        m_lBeers = [SimpleBeer]()
        for beer in beers {
            if let _ = beer {
                m_lBeers?.append(beer!)
            }
        }
    }
}
