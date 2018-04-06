//
//  PBI_STRUCT.swift
//  pbc
//
//  Created by Scott Rong on 2018/4/1.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class PBI_STRUCT: PBI {
    var name: String
    var fields: PBI_STACK_POOL = PBI_STACK_POOL()
    
    init(type: Type) {
        self.name = type.name
        for field in type.fields {
            self.fields.appendElement(element: PBI_FIELD(field.key, type: field.value.type))
        }
        super.init(catecode: 0x2, opercode: 0x1)
    }
}
