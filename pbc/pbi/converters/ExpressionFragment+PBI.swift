//
//  ExpressionFragment+PBI.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/2.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

extension ExpressionFragment {
    
    func convert(stackPool: PBI_STACK_POOL) -> [PBI] {
        var result: [PBI] = []
        let stack = Stack<Operand>()
        
        for fragment in self.fragments {
            var pbi: PBI? = nil

            if let oper = fragment.operatorValue {
                if (oper.operands == .unary) {
                    let operand = stack.pop()!
                    
                    if (oper == .not) {
                        // pib = PBI_NOT
                    } else if (oper == .positive) {
                        
                    } else if (oper == .negative) {
                        pbi = PBI_NEG.select(operand: operand)
                    }
                } else if (oper.operands == .binary) {
                    let operand2 = stack.pop()!
                    let operand1 = stack.pop()!
                    
                    if (oper == .addition) {
                        pbi = PBI_ADD.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .subtract) {
                        pbi = PBI_SUB.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .multiply) {
                        pbi = PBI_MUL.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .division) {
                        pbi = PBI_DIV.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .modulo) {
                        pbi = PBI_MOD.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .divisible) {
                        pbi = PBI_DIB.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .power) {
                        pbi = PBI_POW.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .and) {
                        pbi = PBI_AND.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .or) {
                        pbi = PBI_OR.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .xor) {
                        pbi = PBI_XOR.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .eqv) {
                        pbi = PBI_EQV.select(operand1: operand1, operand2: operand2)
                    } else if (oper == .equal) {
                        
                    } else if (oper == .greater) {
                        
                    } else if (oper == .greaterOrEqual) {
                        
                    } else if (oper == .less) {
                        
                    } else if (oper == .lessOrEqual) {
                        
                    }
                }
            } else if let operand = fragment.operandValue {
                if let constant = operand as? ConstantOperand {
                    pbi = PBI_CONST.select(constant: constant)
                } else if let variable = operand as? VariableOperand {
                    pbi = PBI_LOAD.select(variable: variable)
                }
            }
            
            guard pbi != nil else {
                // TODO
                break
            }
            
            result.append(pbi!)
        }
        
        return result
    }
}
