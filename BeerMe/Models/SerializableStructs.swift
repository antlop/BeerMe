//
//  SerializableStructs.swift
//  BeerMe
//
//  Created by This Mac on 1/22/19.
//  Copyright © 2019 LopezWorks. All rights reserved.
//

import Foundation

/* :::: Shared :::: */
struct Amount : Codable {
    var value : Float?
    var unit : String?
}

/* :::: Method :::: */
struct Mash_temp : Codable {
    var temp : Amount?
    var duration : Int?
}

struct Fermentation : Codable {
    var temp : Amount?
}

struct Method : Codable {
    var mash_temp : [Mash_temp]?
    var fermentation : Fermentation?
    var twist : String?
}

/*:::: Ingredients ::::*/
struct Malt : Codable {
    var amount : Amount?
    var name : String?
}

struct Hops : Codable {
    var name : String?
    var amount : Amount?
    var add : String?
    var attribute : String?
}

struct Ingredients : Codable {
    var malt : [Malt]?
    var hops : [Hops]?
    var yeast : String?
}

/* :::: Beer ::::*/
struct Beer : Codable {
    var id : Int?
    var name : String?
    var tagline : String?
    var first_brewed : String?
    var description : String?
    var image_url : String?
    var abv : Float?
    var ibu : Float?
    var target_fg : Float?
    var target_og : Float?
    var ebc : Int?
    var srm : Float?
    var ph : Float?
    var attenuation_level : Float?
    var volume : Amount?
    var boil_volume : Amount?
    var method : Method?
    var ingredients : Ingredients?
    var food_pairing : [String]?
    var brewers_tips : String?
    var contributed_by : String?
}

/* :::: A Simplified structure as we dont need all the data up front :::: */
struct SimpleBeer : Codable {
    var id : Int?
    var name : String?
    var image_url: String?
}
