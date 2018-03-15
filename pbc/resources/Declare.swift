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
    var arguments: ArgumentList
    var returningType: Type?
    var subscripts: Subscripts?
    
    var procedure: Procedure? = nil
    
    init(name: String, alias: String?, module: String?, arguments: ArgumentList, returningType: Type? = nil, subscripts: Subscripts? = nil) throws {
        guard !(returningType == nil && subscripts != nil) else {
            throw InvalidValueError("No returning type specified.")
        }
        
        self.name = name
        self.alias = alias
        self.module = module
        self.arguments = arguments
        self.returningType = returningType
        self.subscripts = subscripts
    }
}

