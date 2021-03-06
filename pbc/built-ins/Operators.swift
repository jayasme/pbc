//
//  Operators.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/15.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation


enum Operator {
    case addition
    case subtract
    case multiply
    case division
    case positive
    case negative
    case and
    case or
    case not
    case xor
    case eqv
    case modulo
    case power
    case divisible
    case equal
    case less
    case greater
    case lessOrEqual
    case greaterOrEqual
    case notEqual
    case dot
    
    var category: OperatorCategory {
        get {
            return operatorsCategory[self]!
        }
    }
    var operands: OperatorOperands {
        get {
            if (self == .not || self == .positive || self == .negative) {
                return .unary
            }
            return .binary
        }
    }
    var piority: Int {
        get {
            return operatorsPiority[self]!
        }
    }
    
    var symbol: String {
        switch(self) {
        case .addition:
            return "+"
        case .subtract:
            return "-"
        case .multiply:
            return "*"
        case .division:
            return "/"
        case .power:
            return "^"
        case .positive:
            return "+"
        case .negative:
            return "-"
        case .and:
            return "AND"
        case .or:
            return "OR"
        case .not:
            return "NOT"
        case .xor:
            return "XOR"
        case .eqv:
            return "EQV"
        case .modulo:
            return "MOD"
        case .divisible:
            return "\\"
        case .equal:
            return "="
        case .less:
            return "<"
        case .greater:
            return ">"
        case .lessOrEqual:
            return "<="
        case .greaterOrEqual:
            return ">="
        case .notEqual:
            return "<>"
        case .dot:
            return "."
        }
    }
}

enum OperatorCategory {
    case mathematics
    case logic
    case comparation
    case equality
    case accessibility
}

enum OperatorOperands {
    case unary
    case binary
}

fileprivate let operatorsCategory: [Operator: OperatorCategory] = [
    .addition: .mathematics, .subtract: .mathematics, .multiply: .mathematics, .division: .mathematics, .power: .mathematics, .divisible: .mathematics, .modulo: .mathematics, .positive: .mathematics, .negative: .mathematics,
    .and: .logic, .or: .logic, .not: .logic, .xor: .logic, .eqv: .logic,
    .equal: .equality, .notEqual: .equality,
    .less: .comparation, .greater: .comparation, .lessOrEqual: .comparation, .greaterOrEqual: .comparation,
    .dot: .accessibility
]

fileprivate let operatorsPiority: [Operator: Int] = [
    .dot: 7,
    .not: 6, .positive: 6, .negative: 6,
    .power: 5,
    .multiply: 4, .division: 4, .modulo: 4, .divisible: 4,
    .addition: 3, .subtract: 3,
    .equal: 2, .less: 2, .greater: 2, .lessOrEqual: 2, .greaterOrEqual: 2, .notEqual: 2,
    .and: 1, .or: 1, .xor: 1, .eqv: 1
]
