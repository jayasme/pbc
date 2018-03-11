//
//  Function.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/22.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class ArgumentList: Equatable {
    var arguments: [Variable] = []
    
    static func ==(lhs: ArgumentList, rhs: ArgumentList) -> Bool {
        guard (lhs.arguments.count == rhs.arguments.count) else {
            return false
        }
        
        for i in 0..<lhs.arguments.count {
            guard (lhs.arguments[i].type == rhs.arguments[i].type && lhs.arguments[i].isArray == rhs.arguments[i].isArray) else {
                return false
            }
        }
        
        return true
    }
}


// A procedure may stand for a function or a sub, determined by its returningType
class Procedure {
    var name: String
    var arguments: ArgumentList
    var returningType: Type?
    
    init(name: String, arguments: ArgumentList, returningType:Type? = nil) {
        self.name = name
        self.arguments = arguments
        self.returningType = returningType
    }
    
    var isFunction: Bool {
        get {
            return returningType != nil
        }
    }
    
    var isSub: Bool {
        get {
            return returningType == nil
        }
    }
}
