//
//  Base.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation


/*
 
 Instructions sheet
 
 
 Loads (0x1)
 sload(0x1,0x1) iload(0x1,0x2) lload(0x1,0x3) fload(0x1,0x4) dload(0x1,0x5) tload(0x1,0x6)
 
 Constants (0x2)
 sconst(0x2,0x1) iconst(0x2,0x2) lconst(0x2,0x3) fstore(0x2,0x4) dstore(0x2,0x5) tstore(0x2,0x6)
 
 Stores (0x3)
 store(0x3,0x1) istore(0x3,0x2) lstore(0x3,0x3) fstore(0x3,0x4) dstore(0x3,0x5) tstore(0x3,0x6)
 
 Alloc (0x4)
 
 Delloc (0x5)
 delloc(0x5,0x0)
 
 Invoke (0x10)
 invoke(0x10,0x0)
 
 Returns (0x11)
 return(0x11,0x0) sreturn(0x11,0x1) ireturn(0x11,0x2) lreturn(0x11,0x3) freturn(0x11,0x4) dreturn(0x11,0x5) treturn(0x11,0x6)
 
 Additions (0x20)
 addition(0x20,0x0)
 
 Subtracts (0x21)
 ssubtract(0x21,0x0)

 Multiples (0x22)
 smultiple(0x22,0x0)
 
 Divisions (0x23)
 sdivision(0x23,0x0)
 
 Modulos (0x24)
 modulo(0x24,0x0)
 
 Squares (0x25)
 square(0x25,0x0)
 
*/


/*
class BaseInstruction {
    var byteCode: Int16
    var operands: [OperandElement]
    
    init(categoryCode: Int8, subByteCode: Int8, operands: [OperandElement]) {
        self.byteCode = Int16(categoryCode) << 8 & Int16(subByteCode)
        self.operands = operands
    }
}

class Instructions {
    
    static func convertOperandToInstruction(_ operand: OperandElement) throws -> BaseInstruction {
        do {
            if (operand is ConstantElement) {
                return try BaseConstant.select(operand)
            }
            return try BaseLoad.select(operand)
        } catch let error {
            throw error
        }
    }
    
    static func flattenInstructions(_ instructions: [BaseInstruction]) throws -> [BaseInstruction] {
        var result: [BaseInstruction] = []
        
        do {
            for instruction in instructions {
                for operand in instruction.operands {
                    if let variable = operand as? ExpressionVariableElement, let parametersGroup = variable.parameters {
                        var parameterVariables: [ExpressionVariableElement] = []
                        for parameters in parametersGroup {
                            result += parameters
                            // store the results of argument to temp storage slot
                            let variable = VariableManager.expSlot.createNewVariable(type: .int) // TODO
                            parameterVariables.append(variable)
                            try result.append(BaseStore.select(variable))
                        }
                        // check the variable is function or array
                        if let function = FunctionManager.shared.functionExists(variable.name) {
                            // function
                            result.append(Invoke(function.name, operands: parameterVariables))
                        }
                    }
                }
            }
            
            result += VariableManager.expSlot.buildDellocInstructions()
            VariableManager.expSlot.clear()
            
            return result
        } catch let error {
            throw error
        }
    }
}
*/
