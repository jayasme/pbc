//
//  ExpressionFragment+PBI.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/2.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

extension ExpressionFragment {
    
    func convert(stackPool: PBI_STACK_POOL) throws -> [PBI] {
        var result: [PBI] = []
        let stack = Stack<Operand>()
        
        for fragment in self.fragments {
            if let oper = fragment.operatorValue {
                if (oper.operands == .unary) {
                    let operand = stack.pop()!
                    guard let pbi = oper.convertUnary(operand: operand) else {
                        throw InvalidTypeError.Operator_Cannot_Be_Applied_To(oper: oper.symbol, type: operand.type.type.name)
                    }
                    
                    result.append(pbi)

                } else if (oper.operands == .binary) {
                    let operand2 = stack.pop()!
                    let operand1 = stack.pop()!
                    
                    guard let pbi = oper.convertBinary(operand1: operand1, operand2: operand2) else {
                        throw InvalidTypeError.Operator_Cannot_Be_Applied_Between(oper: oper.symbol, type1: operand1.type.type.name, type2: operand2.type.type.name)
                    }
                    
                    result.append(pbi)
                }
            } else if let operand = fragment.operandValue {
                if let constant = operand as? ConstantOperand, let pbi = PBI_CONST.select(constant: constant) {
                    result.append(pbi)
                    continue
                } else if let variable = operand as? VariableOperand {
                    result += try variable.convert()
                    continue
                }
            }
            
            throw SyntaxError.Illegal_Expression()
        }
        
        return result
    }
}
