//
//  Variable.swift
//  pbc
//
//  Created by Scott Rong on 2018/2/21.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Variable: BaseManagerContent {
    var name: String
    var type: TypeTuple
    
    init(name: String, type: TypeTuple) {
        self.name = name
        self.type = type
    }
}

