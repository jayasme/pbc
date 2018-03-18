//
//  pPRINT.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/5.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation


class BuiltInDeclares {

    static var PRINTDeclare: Declare = try! Declare(name: "$WRITE_LN", alias: "PRINT", module: "PRINT", parameters: Parameters.empty)
}

var PRINTDeclare: Declare? = nil
