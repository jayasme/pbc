//
//  Constant.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/11.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation


class Subscript {
    var lowerBound: Int32
    var upperBound: Int32
    
    init(lowerBound: Int32 = 1, upperBound: Int32) throws {
        guard (upperBound > lowerBound) else {
            throw InvalidValueError("The upper bound must be greater than the lower bound.")
        }
        self.lowerBound = lowerBound
        self.upperBound = upperBound
    }
    
    var count: Int {
        return Int(upperBound - lowerBound) + 1
    }
}

class Subscripts: Equatable {
    static func ==(lhs: Subscripts, rhs: Subscripts) -> Bool {
        guard (lhs.subscripts.count == rhs.subscripts.count) else {
            return false
        }
        
        for i in 0..<lhs.subscripts.count {
            if (lhs.subscripts[i].count != rhs.subscripts[i].count) {
                return false
            }
        }
        
        return true
    }
    
    private var subscripts: [Subscript]
    
    static var empty: Subscripts {
        return Subscripts()
    }
    
    var isEmpty: Bool {
        return self.subscripts.count == 0
    }
    
    init(current: Subscript? = nil) {
        if let current = current {
            self.subscripts = [current]
        } else {
            self.subscripts = []
        }
    }
    
    init(current: Subscript, parentSubscripts: Subscripts) {
        self.subscripts =  [current] + parentSubscripts.subscripts
    }
    
    init(baseSubscripts: Subscripts, attached: Subscript) {
        self.subscripts = baseSubscripts.subscripts + [attached]
    }
    
    subscript(index: Int) -> Subscript {
        get {
            return self.subscripts[index]
        }
        set(value) {
            self.subscripts[index] = value
        }
    }
    
    var dimensions: Int {
        return self.subscripts.count
    }
    
    var isDynamic: Bool {
        return self.dimensions == 0
    }
}

class Operand {
    var type: Type

    var isArray: Bool {
        return self is ArrayOperand
    }
    
    func isSameWith(operand: Operand) -> Bool {
        if let arraySelf = self as? ArrayOperand, let arrayOperand = operand as? ArrayOperand {
            return self.type == operand.type && arraySelf.subscripts == arrayOperand.subscripts
        } else if (!self.isArray && !operand.isArray) {
            return self.type == operand.type
        }
        return false
    }
    
    func isCompatibleWith(operand: Operand) -> Bool {
        if let arraySelf = self as? ArrayOperand, let arrayOperand = operand as? ArrayOperand {
            return (self.type.isCompatibleWith(type: operand.type)) && arraySelf.subscripts == arrayOperand.subscripts
        } else if (!self.isArray && !operand.isArray) {
            return self.type.isCompatibleWith(type: operand.type)
        }
        return false
    }
    
    init(type: Type) {
        self.type = type
    }
}

protocol ArrayOperand {
    var subscripts: Subscripts { get }
}
