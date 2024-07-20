//
//  File.swift
//  
//
//  Created by Administrator on 19.07.2024.
//

import Fluent
import Vapor

struct NowWateringDTO: Content {
    var seconds: Int
    var device_id: String
}
