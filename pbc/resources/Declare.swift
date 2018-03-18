//
//  Declare.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Declare: BaseManagerContent {
    var name: String
    var alias: String?
    var module: String?
    var parameters: Parameters
    var returningType: Type?
    var returningSubscripts: Subscripts?
    
    var procedure: Procedure? = nil
    
    init(name: String, alias: String?, module: String?, parameters: Parameters, returningType: Type? = nil, returningSubscripts: Subscripts? = nil) throws {
        guard returningType != nil || returningSubscripts == nil else {
            throw InvalidValueError("No returning type specified.")
        }
        
        self.name = name
        self.alias = alias
        self.module = module
        self.parameters = parameters
        self.returningType = returningType
        self.returningSubscripts = returningSubscripts
    }
}

