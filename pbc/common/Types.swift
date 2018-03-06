//
//  Types.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/7.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

enum DataType: Int {
    case short = 1
    case int = 2
    case long = 3
    case float = 4
    case double = 5
    case string = 100
}




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
