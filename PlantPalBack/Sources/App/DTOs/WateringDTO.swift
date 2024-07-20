//
//  DiseaseDTO.swift
//
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Fluent
import Vapor

struct WateringDTO: Content {
    var startDate: String
    var interval: Int
    var repeats: Int
    var seconds: Int
    var device_id: String
}
