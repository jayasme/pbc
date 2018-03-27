//
//  MemberOperandFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class MemberOperand: Operand {
    var parent: Type
    var name: String
    
    init(_ name: String, parent: Type) throws {
        guard let field = parent.fields[name] else {
            throw InvalidValueError("Cannot find the memebrt '" + name + "' in type '" + parent.name + "'")
        }
    
        self.parent = parent
        self.name = name
    
        super.init(type: TypeTuple(field.type))
    }
}

class MemberOperandFragment: OperandFragment {
    init(_ member: MemberOperand) {
        super.init(member)
    }
}
