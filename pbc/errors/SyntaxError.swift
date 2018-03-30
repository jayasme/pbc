//
//  UnexceptedCharacterError.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class SyntaxError: InnerError {
    
    static func Illegal_Expression() -> SyntaxError {
        return SyntaxError("Illegal expression.")
    }
    
    static func Illegal_Expression_After(syntax: String) -> SyntaxError {
        return SyntaxError(String(format: "Illegal expression after '%@'.", syntax))
    }
    
    static func Expected(syntax: String) -> SyntaxError {
        return SyntaxError(String(format: "Expected '%@'.", syntax))
    }
    
    static func Unexpected(syntax: String) -> SyntaxError {
        return SyntaxError(String(format: "Unexpected '%@'.", syntax))
    }
    
    static func Expected_Valid_Bound() -> SyntaxError {
        return SyntaxError("Expected a valid bound.")
    }
    
    static func Expected_Valid_Upper_Bound() -> SyntaxError {
        return SyntaxError("Expected a valid upper bound after 'TO'.")
    }
    
    static func Cannot_Find_The_Matched_Statement(statement: String) -> SyntaxError {
        return SyntaxError(String(format: "Cannot find the matched '%@' statement.", statement))
    }
    
    
    // DECLARE
    static func Declare_Expected_Function_Or_Sub() -> SyntaxError {
        return SyntaxError("Expected 'FUNCTION' or 'SUB' after 'DECLARE'.")
    }
    
    // FUNCTION
    static func Function_Declare_Not_Found(functionName: String) -> SyntaxError {
        return SyntaxError(String(format: "Cannot find the 'DECLARE' statement for the function '%@'.", functionName))
    }
    
    static func Function_Cannot_Implement_External(functionName: String) -> SyntaxError {
        return SyntaxError(String(format: "Cannot implement an external function '%@'.", functionName))
    }
    
    static func Function_Reimplement(functionName: String) -> SyntaxError {
        return SyntaxError(String(format: "Re-implement the function '%@'.", functionName))
    }
    
    // SUB
    static func Sub_Declare_Not_Found(subName: String) -> SyntaxError {
        return SyntaxError(String(format: "Cannot find the 'DECLARE' statement for the sub '%@'.", subName))
    }
    
    static func Sub_Cannot_Implement_External(subName: String) -> SyntaxError {
        return SyntaxError(String(format: "Cannot implement an external sub '%@'.", subName))
    }
    
    static func Sub_Reimplement(subName: String) -> SyntaxError {
        return SyntaxError(String(format: "Re-implement the sub '%@'.", subName))
    }
    
    // REDIM
    
    static func Redim_Expected_Array_Variable(variableName: String) -> SyntaxError {
        return SyntaxError(String(format: "Cannot REDIM a non-array variable '%@'.", variableName))
    }
    
    static func Redim_Expected_At_Least_One_Argument() -> SyntaxError {
        return SyntaxError("Expected at least one argument in REDIM statement.")
    }

    // LOOP
    
    static func Loop_Only_One_Condition() -> SyntaxError {
        return SyntaxError("There must and only be one condition between the LOOP and its matched DO statement.")
    }
}
