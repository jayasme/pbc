//
//  OperandFragment+PBI.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/8.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

extension OperandFragment {
    func convert() throws -> [PBI] {
        return try self.value.convert()
    }
}

extension Operand {
    
    func convert() throws -> [PBI] {
        var pbi: [PBI] = []
        
        if let constant = self as? ConstantOperand, let pbi_const = PBI_CONST.select(constant: constant) {
            pbi.append(pbi_const)
        } else if let variable = self as? VariableOperand {
            if let dimensions = variable.type.subscripts?.dimensions {
                // array value
                guard variable.subscripts.arguments.count == dimensions else {
                    throw InvalidValueError.Array_Elements_Identical()
                }
                
                for argument in variable.subscripts.arguments {
                    pbi += try argument.convert()
                }
                // FIXME: index
                pbi.append(PBI_LOADX.create(type: variable.type.type, index: 0, dimensions: dimensions))

            } else {
                // normal value
                // FIXME: index
                pbi.append(PBI_LOAD.create(type: variable.type.type, index: 0))
            }
            
        } else if let function = self as? FunctionOperand {
            
        }
        
        return pbi
    }
}
