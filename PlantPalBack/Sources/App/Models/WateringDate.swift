//
//  File.swift
//  
//
//  Created by Administrator on 18.07.2024.
//

import Vapor
import Fluent

final class WateringDate: Model, Content {
    static let schema: String = "dates"
    
    @ID var id: UUID?
    
    @Field(key: "date") var date: Date
    @Field(key: "seconds") var seconds: Int
    @Field(key: "device_id") var device_id: String
    
    init() { }
    
    init(id: UUID? = nil, date: Date, seconds: Int, device_id: String) {
        self.id = id
        self.date = date
        self.seconds = seconds
        self.device_id = device_id
    }
}
