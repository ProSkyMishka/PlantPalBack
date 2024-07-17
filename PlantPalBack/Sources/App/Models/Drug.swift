//
//  Drug.swift
//  
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Vapor
import Fluent

final class Drug: Model, Content {
    static let schema: String = "drugs"
    
    @ID var id: UUID?
    
    @Field(key: "name") var name: String
    @Field(key: "price") var price: Int
    @Field(key: "description") var description: String
    @Field(key: "using_method") var using_method: String?
    @Field(key: "imageURL") var imageURL: String?
    
    init() { }
    
    init(id: UUID? = nil, name: String, price: Int, description: String, using_method: String? = nil, imageURL: String? = nil) {
        self.id = id
        self.name = name
        self.price = price
        self.description = description
        self.using_method = using_method
        self.imageURL = imageURL
    }
}
