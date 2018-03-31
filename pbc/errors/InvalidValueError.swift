//
//  InvalidValueError.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/16.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class InvalidValueError: InnerError {
    
    static func Upper_Bound_Must_Greater() -> InvalidValueError {
        return InvalidValueError("The upper bound must be greater than the lower bound.")
    }
    
    static func Cannot_Find_The_Declaration(declarationName: String) -> InvalidValueError {
        return InvalidValueError(String(format: "Cannot find the '%@'", declarationName))
    }
    
    static func Array_Elements_Identical() -> InvalidValueError {
        return InvalidValueError("The types or subscripts of every element in the array should be identical.")
    }

}
