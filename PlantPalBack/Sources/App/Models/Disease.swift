//
//  Disease.swift
//  
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Vapor
import Fluent

final class Disease: Model, Content {
    static let schema: String = "diseases"
    
    @ID var id: UUID?
    
    @Field(key: "name") var name: String
    @Field(key: "description") var description: String
    @Field(key: "drugs") var drugs: [String]
    
    init() { }
    
    init(id: UUID? = nil, name: String, description: String, drugs: [String]) {
        self.id = id
        self.name = name
        self.description = description
        self.drugs = drugs
    }
}
