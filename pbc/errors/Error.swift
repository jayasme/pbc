//
//  Error.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class CompilingError {
    var error: InnerError
    var line: Int
    var position: Int?
    
    init(_ error: InnerError, line: Int, position: Int? = nil) {
        self.error = error
        self.line = line
        self.position = position
    }
}

class InnerError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}
