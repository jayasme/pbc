//
//  UnexceptedCharacterError.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class SyntaxError: InnerError {
    static var InvalidToken: SyntaxError = SyntaxError("Unexpected token, expected '%s'.")
}
