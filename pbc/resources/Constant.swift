//
//  Constant.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/13.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Constant {
    var value: Any
    var type: TypeTuple
    
    init(value: Any, type: TypeTuple) {
        self.value = value
        self.type = type
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
    
    var arrayValue: Array<Any>? {
        return self.value as? Array<Any>
    }
    
    var arrayShortValue: Array<Int16>? {
        return self.value as? Array<Int16>
    }
    
    var arrayIntegerValue: Array<Int32>? {
        return self.value as? Array<Int32>
    }
    
    var arrayLongValue: Array<Int64>? {
        return self.value as? Array<Int64>
    }
    
    var arrayFloatValue: Array<Float>? {
        return self.value as? Array<Float>
    }
    
    var arrayDoubleValue: Array<Double>? {
        return self.value as? Array<Double>
    }
    
    var arrayStringValue: Array<String>? {
        return self.value as? Array<String>
    }
    
    var arrayBoolValue: Array<Bool>? {
        return self.value as? Array<Bool>
    }
}
