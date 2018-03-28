//
//  StatementParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/17.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class StatementParser {
    
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
            
            if let assignment = try AssignmentParser.parse(&code) {
                return assignment
            }
            if let subInvoker = try SubInvokerParser.parse(&code) {
                return subInvoker
            }
            return nil
        } catch let error {
            throw error
        }
    }
    
    private static func extractType(_ typeName: String, compound: CompoundStatementFragment) throws {
        var fields: [String: TypeField] = [:]
        for statement in compound.statements {
            guard let typeField = (statement as? SingleStatementFragment)?.statement as? TYPEFIELDStatement else {
                throw InvalidValueError("Expected a valid type field")
            }
            fields[typeField.typeField.name] = typeField.typeField
        }
        // TODO the defaultValue
        let type = Type(name: typeName, fields: fields, defaultValue: Int(1))
        try FileParser.sharedCompound?.typeManager.registerType(type)
    }
    
    static func parse(_ code: inout String, lineNumber: inout Int32) throws -> BaseStatementFragment? {
        do {
            guard let statement = try StatementParser.parseStatement(&code) else {
                throw InvalidValueError("Unknown statement.")
            }
            
            if let compoundStatement = statement as? CompoundStatement {
                let compound = try CompoundStatementParser.parse(
                    &code, lineNumber: &lineNumber,
                    didCreateCompound: { (compound: CompoundStatementFragment) throws -> Void in
                        if (type(of: compoundStatement).compoundIncludesBeginStatement) {
                            compound.statements.append(SingleStatementFragment(statement))
                        }
                        try compoundStatement.beginStatement(compound: compound)
                    }, shouldEndStatement: { (endStatement: BaseStatement, compound: CompoundStatementFragment) -> Bool in
                        let shouldEnd = type(of: compoundStatement).endStatement(statement: endStatement)
                        if (shouldEnd && type(of: compoundStatement).compoundIncludesEndStatement) {
                            compound.statements.append(SingleStatementFragment(endStatement))
                        }
                        return shouldEnd
                    }
                )
                
                // extract the type
                if let typeStatement = statement as? TYPEStatement {
                    try StatementParser.extractType(typeStatement.typeName, compound: compound)
                    return nil
                }
                
                return compound
            }
            
            return SingleStatementFragment(statement)
        } catch let error {
            throw error
        }
    }
}
