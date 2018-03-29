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
    
    static func Expected_Character(character: String) -> SyntaxError {
        return SyntaxError(String(format: "Expected '%@'.", character))
    }
    
    static func Unexpected_Character(character: String) -> SyntaxError {
        return SyntaxError(String(format: "Unexpected '%@'.", character))
    }

    
    
    
    // DECLARE
    
    static func Declare_Expected_Function_Or_Sub() -> SyntaxError {
        return SyntaxError("Expected 'FUNCTION' or 'SUB' after 'DECLARE'.")
    }
}
