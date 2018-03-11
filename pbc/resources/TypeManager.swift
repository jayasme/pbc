//
//  TypeManager.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class TypeManager: BaseManager<Type> {
    
    init(parentManager: TypeManager? = nil) {
        super.init(parentManager: parentManager)
        self.registerBuiltInTypes()
    }
    
    func registerBuiltInTypes() {
        try? self.registerType(SHORTType)
        try? self.registerType(INTEGERType)
        try? self.registerType(LONGType)
        try? self.registerType(SINGLEType)
        try? self.registerType(DOUBLEType)
        try? self.registerType(STRINGType)
        try? self.registerType(BOOLEANType)
    }
    
    func registerType(_ type: Type) throws {
        do {
            try super.registerValue(type)
        } catch let error {
            throw error
        }
    }
    
    func findType(_ name: String) -> Type? {
        return super.findValue(name)
    }
    
    func parseType(_ code: inout String) -> Type? {
        guard let name = PatternedNameParser.parse(&code)?.name else {
            return nil
        }
        
        return self.findType(name)
    }
}
