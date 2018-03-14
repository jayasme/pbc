//
//  Operator.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/13.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

enum OperatorType: String {
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
    case square
    case intDivision
    case equal
    case less
    case greater
    case lessOrEqual
    case greaterOrEqual
    case notEqual
}

enum OperatorCategory {
    case mathematics
    case logic
    case comparation
    case equality
}

enum OperatorOperands {
    case unary
    case binary
}

fileprivate let operatorsCategory: [OperatorType: OperatorCategory] = [
    .addition: .mathematics, .subtract: .mathematics, .multiply: .mathematics, .division: .mathematics, .square: .mathematics, .intDivision: .mathematics, .modulo: .mathematics, .positive: .mathematics, .negative: .mathematics,
    .and: .logic, .or: .logic, .not: .logic, .xor: .logic, .eqv: .logic,
    .equal: .equality, .notEqual: .equality,
    .less: .comparation, .greater: .comparation, .lessOrEqual: .comparation, .greaterOrEqual: .comparation,
]

fileprivate let operatorsPiority: [OperatorType: Int] = [
    .not: 6, .positive: 6, .negative: 6,
    .square: 5,
    .multiply: 4, .division: 4, .modulo: 4, .intDivision: 4,
    .addition: 3, .subtract: 3,
    .equal: 2, .less: 2, .greater: 2, .lessOrEqual: 2, .greaterOrEqual: 2, .notEqual: 2,
    .and: 1, .or: 1, .xor: 1, .eqv: 1
]

class Operator: ExpressionItem {
    var type: OperatorType
    
    var category: OperatorCategory {
        get {
            return operatorsCategory[self.type]!
        }
    }
    var operands: OperatorOperands {
        get {
            if (self.type == .not || self.type == .positive || self.type == .negative) {
                return .unary
            }
            return .binary
        }
    }
    var piority: Int {
        get {
            return operatorsPiority[self.type]!
        }
    }
    
    init(_ type: OperatorType) {
        self.type = type
    }
}
