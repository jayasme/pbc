//
//  Function.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/22.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Parameters: Equatable {
    var parameters: [Variable] = []
    
    static var empty: Parameters {
        return Parameters()
    }
    
    var isEmpty: Bool {
        return parameters.count == 0
    }
    
    static func ==(lhs: Parameters, rhs: Parameters) -> Bool {
        guard (lhs.parameters.count == rhs.parameters.count) else {
            return false
        }
        
        for i in 0..<lhs.parameters.count {
            guard (lhs.parameters[i].type.isCompatibleWith(type: rhs.parameters[i].type)) else {
                return false
            }
        }
        
        return true
    }
    
    static func ==(lhs: Parameters, rhs: Arguments) -> Bool {
        guard (lhs.parameters.count == rhs.arguments.count) else {
            return false
        }
        
        for i in 0..<lhs.parameters.count {
            guard (lhs.parameters[i].type.isCompatibleWith(type: rhs.arguments[i].type)) else {
                return false
            }
        }
        return true
    }
    
    subscript(index: Int) -> Variable {
        get {
            return self.parameters[index]
        }
        set(value) {
            self.parameters[index] = value
        }
    }
    
    var description: String {
        let result = self.parameters.reduce("", { $0 + $1.type.name + "," }).trimmingCharacters(in: CharacterSet(charactersIn: ","))
        return String(format: "(%@)", result)
    }
}

class Arguments: Equatable {
    var arguments: [Operand] = []
    
    static var empty: Arguments {
        return Arguments()
    }
    
    var isEmpty: Bool {
        return arguments.count == 0
    }
    
    static func ==(lhs: Arguments, rhs: Arguments) -> Bool {
        guard (lhs.arguments.count == rhs.arguments.count) else {
            return false
        }
        
        for i in 0..<lhs.arguments.count {
            guard (lhs.arguments[i].type.isCompatibleWith(type: rhs.arguments[i].type)) else {
                return false
            }
        }
        
        return true
    }
    
    func isConformWith(parameters: Parameters) -> Bool {
        guard (self.arguments.count == parameters.parameters.count) else {
            return false
        }
        
        for i in 0..<self.arguments.count {
            if self.arguments[i].type.isArray, let subscripts = parameters[i].type.subscripts, subscripts.isDynamic {
                // if the parameter is dynamic array
                continue
            }
            
            guard (self.arguments[i].type.isCompatibleWith(type: parameters.parameters[i].type)) else {
                return false
            }
        }
        
        return true
    }
    
    subscript(index: Int) -> Operand {
        get {
            return self.arguments[index]
        }
        set(value) {
            self.arguments[index] = value
        }
    }
    
    var description: String {
        let result = self.arguments.reduce("", { $0 + $1.type.name + "," }).trimmingCharacters(in: CharacterSet(charactersIn: ","))
        return String(format: "(%@)", result)
    }
}

// A procedure may stand for a function or a sub, determined by its returnType
class Procedure {
    var name: String
    var parameters: Parameters
    
    init(name: String, parameters: Parameters) {
        self.name = name
        self.parameters = parameters
    }
    
    var isFunction: Bool {
        get {
            return self is Function
        }
    }
    
    var isSub: Bool {
        get {
            return self is Sub
        }
    }
}

class Sub: Procedure { }

class Function: Procedure {
    var returnType: TypeTuple

    init(name: String, parameters: Parameters, returnType: TypeTuple) {
        self.returnType = returnType
        super.init(name: name, parameters: parameters)
    }
    
}
