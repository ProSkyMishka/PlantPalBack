//
//  DiseaseDTO.swift
//
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Fluent
import Vapor

struct DiseaseDTO: Content {
    var id: UUID
    var name: String
    var description: String
    var drugs: [String]
}
