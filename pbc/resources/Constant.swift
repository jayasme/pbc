//
//  Constant.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/13.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Constant: Operand {
    var value: Any
    
    init(value: Any, type: Type) {
        self.value = value
        super.init(type: type)
    }
    
    var shortValue: Int16? {
        return self.value as? Int16
    }
    
    var integerValue: Int32? {
        return self.value as? Int32
    }
    
    var longValue: Int64? {
        return self.value as? Int64
    }
    
    var floatValue: Float? {
        return self.value as? Float
    }
    
    var doubleValue: Double? {
        return self.value as? Double
    }
    
    var stringValue: String? {
        return self.value as? String
    }
    
    var booleanValue: Bool? {
        return self.value as? Bool
    }
}

class ArrayConstant: ArrayOperand {
    var value: Array<Any>
    
    init(value: Array<Any>, type: Type, subscripts: [Subscript] = []) {
        self.value = value
        super.init(type: type, subscripts: subscripts)
    }
    
    var shortValue: Array<Int16>? {
        return self.value as? Array<Int16>
    }
    
    var integerValue: Array<Int32>? {
        return self.value as? Array<Int32>
    }
    
    var longValue: Array<Int64>? {
        return self.value as? Array<Int64>
    }
    
    var floatValue: Array<Float>? {
        return self.value as? Array<Float>
    }
    
    var doubleValue: Array<Double>? {
        return self.value as? Array<Double>
    }
    
    var stringValue: Array<String>? {
        return self.value as? Array<String>
    }
    
    var booleanValue: Bool? {
        return self.value as? Array<Bool>
    }
}
