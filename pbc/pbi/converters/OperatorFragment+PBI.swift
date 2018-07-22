//
//  OperatorFragment+PBI.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/8.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

extension OperatorFragment {
    
    func convertUnary(operand: Operand) -> PBI? {
        return self.value.convertUnary(operand: operand)
    }
    
    func convertBinary(operand1: Operand, operand2: Operand) -> PBI? {
        return self.value.convertBinary(operand1: operand1, operand2: operand2)
    }
}

extension Operator {

    func convertUnary(operand: Operand) -> PBI? {
        
        if (self == .not), let pbi = MPBI_NOT.create(operand: operand) {
            return pbi
        } else if (self == .positive), let pbi = MPBI_POS.create(operand: operand) {
            return pbi
        } else if (self == .negative), let pbi = PBI_NEG.select(operand: operand) {
            return pbi
        }
        
        return nil
    }
    
    func convertBinary(operand1: Operand, operand2: Operand) -> PBI? {
        if (self == .addition), let pbi = PBI_ADD.select(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .subtract), let pbi = PBI_SUB.select(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .multiply), let pbi = PBI_MUL.select(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .division), let pbi = PBI_DIV.select(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .modulo), let pbi = PBI_MOD.select(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .divisible), let pbi = PBI_DIB.select(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .power), let pbi = PBI_POW.select(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .and), let pbi = PBI_AND.select(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .or), let pbi = PBI_OR.select(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .xor), let pbi = PBI_XOR.create(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .eqv), let pbi = PBI_EQV.create(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .equal), let pbi = MPBI_EQ.create(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .notEqual), let pbi = MPBI_NEQ.create(operand1: operand1, operand2: operand2)  {
            return pbi
        } else if (self == .greater), let pbi = MPBI_GT.create(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .greaterOrEqual), let pbi = MPBI_GE.create(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .less), let pbi = MPBI_LT.create(operand1: operand1, operand2: operand2) {
            return pbi
        } else if (self == .lessOrEqual), let pbi = MPBI_LE.create(operand1: operand1, operand2: operand2) {
            return pbi
        }
        
        return nil
    }
}
