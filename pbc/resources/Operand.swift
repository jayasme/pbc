//
//  Constant.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/11.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation


class Subscript {
    var lowerBound: Int
    var upperBound: Int
    
    init(lowerBound: Int = 1, upperBound: Int) throws {
        guard (upperBound > lowerBound) else {
            throw InvalidValueError("The upper bound must be greater than the lower bound.")
        }
        self.lowerBound = lowerBound
        self.upperBound = upperBound
    }
    
    var count: Int {
        return upperBound - lowerBound + 1
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
    
    static var empty: Subscripts = Subscripts()
    
    var isEmpty: Bool {
        return self == Subscripts.empty
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
}

class Operand: ExpressionItem {
    var type: Type

    var isArray: Bool {
        return self is ArrayOperand
    }
    
    func isSameWith(_ operand: Operand) -> Bool {
        if let array = self as? ArrayOperand, let operand = operand as? ArrayOperand {
            return array.type == operand.type && array.subscripts == operand.subscripts
        } else if (!self.isArray && !operand.isArray) {
            return self.type == operand.type
        }
        return false
    }
    
    func isCompatibleWith(_ operand: Operand) -> Bool {
        if let array = self as? ArrayOperand, let operand = operand as? ArrayOperand {
            return (array.type == operand.type || array.type.isNumber && operand.type.isNumber) && array.subscripts == operand.subscripts
        } else if (!self.isArray && !operand.isArray) {
            return self.type == operand.type || (self.type.isNumber && operand.type.isNumber)
        }
        return false
    }
    
    init(type: Type) {
        self.type = type
    }
}

class ArrayOperand: Operand {
    var subscripts: Subscripts
    
    init(type: Type, subscripts: Subscripts) {
        self.subscripts = subscripts
        super.init(type: type)
    }
}

