//
//  TYPEFIELD.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class TYPEFIELDStatement: BaseStatement {
    static var name: String {
        get {
            return "TYPE FIELD"
        }
    }
    
    static var keywords: [String] {
        get {
            return []
        }
    }
    
    var typeField: TypeField
    
    init(_ typeField: TypeField) {
        self.typeField = typeField
    }
    
    static func parse(_ code: inout String) throws -> BaseStatement? {
        var tryCode = code
        // parse the name
        guard let patternedName = PatternedNameParser.parse(&tryCode)?.name else {
            return nil
        }
        
        // parse the AS
        guard (KeywordParser.parse(&tryCode, keyword: "AS") != nil) else {
            return nil
        }
        
        // parse the type
        guard let type = try FileParser.sharedCompound?.typeManager.parseType(&tryCode) else {
            throw SyntaxError.Expected_Type()
        }
        
        code = tryCode
        let field = TypeField(name: patternedName, type: type)
        return TYPEFIELDStatement(field)
    }
}
