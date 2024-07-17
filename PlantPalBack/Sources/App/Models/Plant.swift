//
//  Plant.swift
//  
//
//  Created by Михаил Прозорский on 05.07.2024.
//

import Vapor
import Fluent

final class Plant: Model, Content {
    static var schema: String = "plants"
    
    @ID var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "description") var description: String
    @Field(key: "imageURL") var imageURL: String
    @Field(key: "temp") var temp: String
    @Field(key: "humidity") var humidity: String
    @Field(key: "waterInterval") var waterInterval: Int
    @Field(key: "seconds") var seconds: Int
    @Field(key: "MLID") var MLID: String
    
    init() { }
    
    init(id: UUID? = nil, name: String, description: String, imageURL: String, temp: String, humidity: String, waterInterval: Int, seconds: Int, MLID: String) {
        self.id = id
        self.name = name
        self.description = description
        self.imageURL = imageURL
        self.temp = temp
        self.humidity = humidity
        self.waterInterval = waterInterval
        self.seconds = seconds
        self.MLID = MLID
    }
}
