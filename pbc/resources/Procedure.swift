//
//  Function.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/22.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Arguments: Equatable {
    var arguments: [Variable] = []
    
    static func ==(lhs: Arguments, rhs: Arguments) -> Bool {
        guard (lhs.arguments.count == rhs.arguments.count) else {
            return false
        }
        
        for i in 0..<lhs.arguments.count {
            guard (lhs.arguments[i].type.isCompatibileWith(type: rhs.arguments[i].type)) else {
                return false
            }
        }
        
        return true
    }
}


// A procedure may stand for a function or a sub, determined by its returningType
class Procedure {
    var name: String
    var arguments: Arguments
    var returningType: Type?
    
    init(name: String, arguments: Arguments, returningType:Type? = nil) {
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
