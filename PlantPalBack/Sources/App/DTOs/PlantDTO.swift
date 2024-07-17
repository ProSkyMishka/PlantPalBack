//
//  PlantDTO.swift
//
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Fluent
import Vapor

struct PlantDTO: Content {
    var name: String
    var description: String
    var imageURL: String
    var minT: Int
    var maxT: Int
    var humidity: Int
    var waterInterval: Int
    var seconds: Int
    var MLID: String
}
