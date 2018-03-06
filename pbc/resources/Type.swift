//
//  BaseType.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

fileprivate var decimaTypelList = [SHORTType, INTEGERType, LONGType, SINGLEType, DOUBLEType]
fileprivate var nativeTypeList = [SHORTType, INTEGERType, LONGType, SINGLEType, DOUBLEType, STRINGType, BOOLEANType]

class TypeField {
    var name: String
    var type: Type
    
    init(name: String, type: Type) {
        self.name = name
        self.type = type
    }
}

class Type: BaseManagerContent {
    var fields: [String: TypeField]
    var isDecimal: Bool {
        get {
            return decimaTypelList.contains(self)
        }
    }
    var isNative: Bool {
        get {
            return nativeTypeList.contains(self)
        }
    }
    
    init(name: String, fields: [String: TypeField]) {
        self.fields = fields
        super.init(name)
    }
}
