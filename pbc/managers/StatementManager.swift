//
//  StatementManager.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/17.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class StatementManager {
    
    private var statementMap: [String: BaseStatement.Type] = [:]
    
    static var shared: StatementManager = StatementManager()
    
    init() {
        self.registerBuiltInStatements()
    }
    
    // register a statement
    @discardableResult
    func registerStatement(_ statementType: BaseStatement.Type) -> Bool {
        let name = statementType.name
        if (self.StatementExists(name) != nil) {
            return false
        }
        
        self.statementMap[name.uppercased()] = statementType
        return true
    }
    
    fileprivate func registerBuiltInStatements() {
        self.registerStatement(LETStatement.self)
        
        self.registerStatement(DECLAREStatement.self)
        self.registerStatement(CALLStatement.self)
        
        self.registerStatement(FUNCTIONStatement.self)
        self.registerStatement(ENDFUNCTIONStatement.self)
        self.registerStatement(SUBStatement.self)
        self.registerStatement(ENDSUBStatement.self)

        self.registerStatement(TYPEStatement.self)
        self.registerStatement(TYPEFIELDStatement.self)
        self.registerStatement(ENDTYPEStatement.self)
        
        self.registerStatement(REMStatement.self)
        
        self.registerStatement(DIMStatement.self)
        self.registerStatement(REDIMStatement.self)
        
        self.registerStatement(IFStatement.self)
        self.registerStatement(ELSEIFStatement.self)
        self.registerStatement(ELSEStatement.self)
        self.registerStatement(ENDIFStatement.self)

        self.registerStatement(FORStatement.self)
        self.registerStatement(NEXTStatement.self)
        self.registerStatement(DOStatement.self)
        self.registerStatement(LOOPStatement.self)
        
        self.registerStatement(EXITFORStatement.self)
        self.registerStatement(EXITDOStatement.self)
        
        self.registerStatement(GOTOStatement.self)
        
        self.registerStatement(PRINTStatement.self)
    }
    
    func StatementExists(_ name: String) -> BaseStatement.Type? {
        return self.statementMap[name]
    }
    
    var statements: [BaseStatement.Type] {
        get {
            return self.statementMap.values.map{ $0 }
        }
    }
}
