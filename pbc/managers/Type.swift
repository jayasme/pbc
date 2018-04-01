//
//  BaseType.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

fileprivate var roundedTypeList = [SHORTType, INTEGERType, LONGType]
fileprivate var numberTypelList = [SHORTType, INTEGERType, LONGType, SINGLEType, DOUBLEType]
fileprivate var nativeTypeList = [SHORTType, INTEGERType, LONGType, SINGLEType, DOUBLEType, STRINGType, BOOLEANType]

class TypeField {
    var name: String
    var type: Type
    
    init(name: String, type: Type) {
        self.name = name
        self.type = type
    }
}

class Type: BaseManagerContent, Equatable {
    var name: String
    
    static func ==(lhs: Type, rhs: Type) -> Bool {
        return lhs.name == rhs.name
    }
    
    var fields: [String: TypeField]
    var defaultValue: Any
    
    var isNumber: Bool {
        return numberTypelList.contains(self)
    }
    var isNative: Bool {
        return nativeTypeList.contains(self)
    }
    var isRounded: Bool {
        return roundedTypeList.contains(self)
    }

    var numberIndex: Int? {
        return numberTypelList.index(of: self)
    }
    
    func isCompatibleWith(type: Type) -> Bool {
        return self == type || (self.isNumber && type.isNumber)
    }
    
    init(name: String, fields: [String: TypeField] = [:], defaultValue: Any) {
        self.name = name
        self.fields = fields
        self.defaultValue = defaultValue
    }
    
    static func mixType(type1: Type, type2: Type) -> Type? {
        guard (type1 != type2) else {
            return type1
        }

        guard let index1 = type1.numberIndex, let index2 = type2.numberIndex else {
            return nil
        }
        
        return numberTypelList[max(index1, index2)]
    }
}



class Subscript {
    var lowerBound: Int32
    var upperBound: Int32
    
    init(lowerBound: Int32 = 1, upperBound: Int32) throws {
        guard (upperBound >= lowerBound) else {
            throw InvalidValueError.Upper_Bound_Must_Greater()
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
    
    static func !=(lhs: Subscripts, rhs: Subscripts) -> Bool {
        return !(lhs == rhs)
    }
    
    private var subscripts: [Subscript]
    
    static var empty: Subscripts {
        return Subscripts()
    }
    
    var isEmpty: Bool {
        return self.subscripts.count == 0
    }
    
    var description: String {
        return String(format: "(%@)", subscripts.reduce("", { $0 + String($1.count) + "," }).trimmingCharacters(in: CharacterSet(charactersIn: ",")))
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

class TypeTuple: Equatable {
    var type: Type
    var subscripts: Subscripts?
    
    static func ==(lhs: TypeTuple, rhs: TypeTuple) -> Bool {
        return lhs.type == rhs.type && lhs.subscripts == rhs.subscripts
    }
    
    static func !=(lhs: TypeTuple, rhs: TypeTuple) -> Bool {
        return !(lhs == rhs)
    }
    
    static func ==(lhs: TypeTuple, rhs: Type) -> Bool {
        return lhs.type == rhs
    }
    
    static func !=(lhs: TypeTuple, rhs: Type) -> Bool {
        return !(lhs == rhs)
    }
    
    func isCompatibleWith(type: TypeTuple) -> Bool {
        return self.type.isCompatibleWith(type: type.type) && self.subscripts == type.subscripts
    }
    
    var name: String {
        if let subscripts = self.subscripts {
            return self.type.name + subscripts.description
        }
        
        return self.type.name
    }
    
    var isArray: Bool {
        return self.subscripts != nil
    }
    
    var isNumber: Bool {
        return self.type.isNumber
    }
    var isNative: Bool {
        return self.type.isNative
    }
    var isRounded: Bool {
        return self.type.isRounded
    }
    
    static func mixType(type1: TypeTuple, type2: TypeTuple) -> TypeTuple? {
        if (type1.subscripts == nil && type2.subscripts == nil) {
            if let type = Type.mixType(type1: type1.type, type2: type2.type) {
                return TypeTuple(type)
            }
        } else if let subscripts1 = type1.subscripts, let subscripts2 = type2.subscripts {
            guard subscripts1 == subscripts2 else {
                return nil
            }
            
            if let type = Type.mixType(type1: type1.type, type2: type2.type) {
                return TypeTuple(type, subscripts: subscripts1)
            }
        }
        
        return nil
    }

    init(_ type: Type, subscripts: Subscripts? = nil) {
        self.type = type
        self.subscripts = subscripts
    }
}
