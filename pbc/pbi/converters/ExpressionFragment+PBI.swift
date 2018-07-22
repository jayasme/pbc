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

                    if (oper == .not), let pbi = MPBI_NOT.create(operand: operand) {
                        result.append(pbi)
                        continue
                    } else if (oper == .positive), let pbi = MPBI_POS.create(operand: operand) {
                        result.append(pbi)
                        continue
                    } else if (oper == .negative), let pbi = PBI_NEG.select(operand: operand) {
                        result.append(pbi)
                        continue
                    }
                    
                    throw InvalidTypeError.Operator_Cannot_Be_Applied_To(oper: oper.symbol, type: operand.type.type.name)
                    
                } else if (oper.operands == .binary) {
                    let operand2 = stack.pop()!
                    let operand1 = stack.pop()!
                    
                    if (oper == .addition), let pbi = PBI_ADD.select(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .subtract), let pbi = PBI_SUB.select(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .multiply), let pbi = PBI_MUL.select(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .division), let pbi = PBI_DIV.select(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .modulo), let pbi = PBI_MOD.select(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .divisible), let pbi = PBI_DIB.select(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .power), let pbi = PBI_POW.select(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .and), let pbi = PBI_AND.select(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .or), let pbi = PBI_OR.select(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .xor), let pbi = PBI_XOR.create(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .eqv), let pbi = PBI_EQV.create(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .equal), let pbi = MPBI_EQ.create(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .notEqual), let pbi = MPBI_NEQ.create(operand1: operand1, operand2: operand2)  {
                        result.append(pbi)
                        continue
                    } else if (oper == .greater), let pbi = MPBI_GT.create(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .greaterOrEqual), let pbi = MPBI_GE.create(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .less), let pbi = MPBI_LT.create(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    } else if (oper == .lessOrEqual), let pbi = MPBI_LE.create(operand1: operand1, operand2: operand2) {
                        result.append(pbi)
                        continue
                    }
                    
                    throw InvalidTypeError.Operator_Cannot_Be_Applied_Between(oper: oper.symbol, type1: operand1.type.type.name, type2: operand2.type.type.name)
                }
            } else if let operand = fragment.operandValue {
                if let constant = operand as? ConstantOperand, let pbi = PBI_CONST.select(constant: constant) {
                    result.append(pbi)
                    continue
                } else if let variable = operand as? VariableOperand, let pbi = PBI_LOAD.create(variable: variable) {
                    result.append(pbi)
                    continue
                }
            }
            
            throw SyntaxError.Illegal_Expression()
        }
        
        return result
    }
}
