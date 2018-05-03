//
//  PBI_AND.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/6.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_AND: PBI {
    init(opercode: Int8) {
        super.init(catecode: 0x27, opercode: opercode)
    }
    
    static func select(operand1: Operand, operand2: Operand) -> PBI_AND? {
        let type = Type.mixType(type1: operand1.type.type, type2: operand2.type.type)
        if (type == SHORTType) {
            return PBI_AND_S()
        }
        
        return nil
    }
}

class PBI_AND_S: PBI_AND {
    init() {
        super.init(opercode: 0x1)
    }
}
