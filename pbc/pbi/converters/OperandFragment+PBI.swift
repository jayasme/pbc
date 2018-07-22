//
//  OperandFragment+PBI.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/8.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

extension OperandFragment {
    
    func convert() -> [PBI] {
        return self.value.convert()
    }
}

extension Operand {
    
    func convert() -> [PBI] {
        var pbi: [PBI] = []
        
        if let constant = self as? ConstantOperand, let pbi_const = PBI_CONST.select(constant: constant) {
            pbi.append(pbi_const)
        } else if let variable = self as? VariableOperand {
            if (variable.subscripts.isEmpty) {
                // raw value
            } else {
                // array
                for argument in variable.subscripts.arguments {
                    pbi += argument.convert()
                }
                pbi.append(PBI_IDX.select(operand: self))
            }
            
        } else if let function = self as? FunctionOperand {
            
        }
        
        return pbi
    }
}
