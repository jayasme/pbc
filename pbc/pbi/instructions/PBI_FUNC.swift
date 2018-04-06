//
//  FunctionInstructions.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/1.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_FUNC: PBI {
    
    var returnType: Type
    var pool: PBI_STACK_POOL = PBI_STACK_POOL()
    var instructions: [PBI] = []
    
    init(returnType: Type) {
        self.returnType = returnType
        super.init(catecode: 0x01, opercode: 0x01)
    }
}
