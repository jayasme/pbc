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
        get {
            return numberTypelList.contains(self)
        }
    }
    var isNative: Bool {
        get {
            return nativeTypeList.contains(self)
        }
    }
    var isRounded: Bool {
        get {
            return roundedTypeList.contains(self)
        }
    }
    
    var numberIndex: Int? {
        get {
            return numberTypelList.index(of: self)
        }
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
