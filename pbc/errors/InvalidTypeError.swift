//
//  InvalidTypeError.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/29.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class InvalidTypeError: InnerError {
    
    override var errorType: String {
        return "INVALID TYPE ERROR"
    }
    
    static func Expected_Type(typeName: String) -> InvalidTypeError {
        return InvalidTypeError(String(format: "Expected type '%@'.", typeName))
    }
    
    static func Expected_Type_Of(typeName: String, something: String) -> InvalidTypeError {
        return InvalidTypeError(String(format: "Expected type '%@' of %@.", typeName, something))
    }
    
    static func Cannot_Convert_Type_From_To(fromType: String, toType: String) -> InvalidTypeError {
        return InvalidTypeError(String(format: "Cannot convert type from '%@' to '%@'.", fromType, toType))
    }
    
    static func Type_Does_Not_Exist(typeName: String) -> InvalidTypeError {
        return InvalidTypeError(String(format: "Type '%@' does not exist in context.", typeName))
    }
    
    static func Type_Expected_Dimension_Subscripts(typeName: String, dimension: Int) -> InvalidTypeError {
        return InvalidTypeError(String(format: "Type '%@' expected %d-dimension subscripts.", typeName, dimension))
    }
    
    static func Type_Does_Not_Recieve_Subscripts(typeName: String) -> InvalidTypeError {
        return InvalidTypeError(String(format: "Type '%@' dose not recieve subscript.", typeName))
    }
    
    static func Variable_Must_Indicate_Subscripts(variableName: String) -> InvalidTypeError {
        return InvalidTypeError(String(format: "Must indicate subscirpts for '%@'.", variableName))
    }

    static func Operator_Cannot_Be_Applied(oper: String, type1: String, type2: String) -> InvalidTypeError {
        return InvalidTypeError(String(format: "Operator '%@' cannot be applied between '%@' and '%@'.", oper, type1, type2))
    }
    
    
    
    static func Invoker_Expected_Arguments(arguments: String, practicalArguments: String) -> InvalidValueError {
        return InvalidValueError(String(format: "Arguments '%@' mismatch with the praticial arguments '%@'.", arguments, practicalArguments))
    }
    
    static func Implement_Expected_Arguments(arguments: String, practicalArguments: String) -> InvalidValueError {
        return InvalidValueError(String(format: "Arguments '%@' mismatch with its 'DECLARE' arguments '%@'.", arguments, practicalArguments))
    }
    
    static func Implement_Expected_Return_Type(typeName: String, practicalTypeName: String) -> InvalidValueError {
        return InvalidValueError(String(format: "Return type '%@' mismatch with its 'DECLARE' return type '%@'.", typeName, practicalTypeName))
    }
}
