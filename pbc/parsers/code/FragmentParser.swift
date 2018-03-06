//
//  StatementParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/17.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class StatementElement: FragmentElement {
    
    var statement: BaseStatement
    
    init(_ statement: BaseStatement) {
        self.statement = statement
    }
}


class FragmentParser {
    
    private static func parseStatement(_ code: inout String) throws -> BaseStatement? {
        do {
            for statementType in StatementManager.shared.statements {
                guard (MultikeywordsParser.parse(&code, keywords: statementType.keywords) != nil) else {
                    continue
                }
                
                if let statement = try statementType.parse(&code) {
                    return statement
                }
            }
            
            return try AssignmentParser.parse(&code)
        } catch let error {
            throw error
        }
    }
    
    private static func extractType(_ typeName: String, block: BlockElement) throws {
        var fields: [String: TypeField] = [:]
        for fragment in block.fragments {
            guard let typeField = (fragment as? StatementElement)?.statement as? TYPEFIELDStatement else {
                throw InvalidValueError("Expected a valid type field")
            }
            fields[typeField.typeField.name] = typeField.typeField
        }
        let type = Type.init(name: typeName, fields: fields)
        try CodeParser.sharedBlock?.typeManager.registerType(type)
    }
    
    static func parse(_ code: inout String, lineNumber: inout Int32) throws -> FragmentElement? {
        do {
            guard let statement = try FragmentParser.parseStatement(&code) else {
                throw InvalidValueError("Unknown statement.")
            }
            
            if let group = statement as? GroupedStatement {
                let block = try BlockParser.parse(&code, lineNumber: &lineNumber, didCreateBlock: { (block: BlockElement) throws -> Void in
                    do {
                        if (type(of: group).blockIncludesBeginStatement) {
                            block.fragments.append(StatementElement(statement))
                        }
                        try group.beginStatement(block: block)
                    } catch let error {
                        throw error
                    }
                }, shouldEndStatement: { (endStatement: BaseStatement, block: BlockElement) -> Bool in
                    let shouldEnd = type(of: group).endStatement(statement: endStatement)
                    if (shouldEnd && type(of: group).blockIncludesEndStatement) {
                        block.fragments.append(StatementElement(endStatement))
                    }
                    return shouldEnd
                })
                
                // extract the type
                if let typeStatement = statement as? TYPEStatement {
                    try FragmentParser.extractType(typeStatement.typeName, block: block)
                    return nil
                }
                
                return block
            }
            
            return StatementElement(statement)
        } catch let error {
            throw error
        }
    }
}
