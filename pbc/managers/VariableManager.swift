//
//  VariableManager.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/19.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class VariableManager: BaseManager<Variable> {

    func registerVariable(_ variable: Variable) throws {
        try super.registerValue(variable)
    }

    func findVariable(_ name: String) -> Variable? {
        return super.findValue(name)
    }
    
    func parse(_ code: inout String) -> Variable? {
        guard let name = PatternedNameParser.parse(&code)?.name else {
            return nil
        }
        
        return self.findVariable(name)
    }
}
