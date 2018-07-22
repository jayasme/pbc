//
//  MPBI_NOT.swift
//  pbc
//
//  Created by Scott Rong on 2018/7/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MPBI_NOT: PBI {
    init() {
        super.init(catecode: 0, opercode: 0x1)
    }
    
    static func create(operand: Operand) -> MPBI_NOT? {
        let type = operand.type.type
        if (type == BOOLEANType) {
            return MPBI_NOT()
        }
        return nil
    }
}
