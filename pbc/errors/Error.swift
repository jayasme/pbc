//
//  Error.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/3.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class CompilingErrors {
    var errors: [CompilingError] = []
    
    var description: String {
        var result = ""
        for error in self.errors {
            result += String(format: "[%@]%@\nAt (%d,%d)\nIn %@\n",
                             error.error.errorType,
                             error.error.message,
                             error.line,
                             error.position,
                             error.file
            )
        }
        result += String(format: "Summary %d error(s)", self.errors.count)
        
        return result
    }
}

class CompilingError {
    var error: InnerError
    var file: String
    var line: Int
    var position: Int
    
    init(_ error: InnerError, file: String, line: Int, position: Int) {
        self.error = error
        self.file = file
        self.line = line
        self.position = position
    }
}

class InnerError: Error {
    var message: String
    
    var errorType: String {
        return ""
    }
    
    init(_ message: String) {
        self.message = message
    }
}
