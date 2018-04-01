//
//  InvalidNameError.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/29.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class InvalidNameError: InnerError {
    
    static func Redeclaration_Of(name: String) -> InvalidNameError {
        return InvalidNameError(String(format: "Redeclaration of '%@'.", name))
    }
    
    static func Invalid_Name_Of(name: String) -> InvalidNameError {
        return InvalidNameError(String(format: "Invalid name of '%@'.", name))
    }
    
    static func For_Invalid_Counter_Name() -> InvalidNameError {
        return InvalidNameError("Invalid counter name of 'FOR' statement.")
    }
    
    static func Next_Mismatch_For() -> InvalidNameError {
        return InvalidNameError("The counter of 'NEXT' statement mismatch with its 'FOR' statement.")
    }
    
    static func Field_Not_Included_In_Type(field: String, typeName: String) -> InvalidNameError {
        return InvalidNameError(String(format: "Field '%@' not included in type '%@'.", field, typeName))
    }
}
