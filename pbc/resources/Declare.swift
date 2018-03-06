//
//  Declare.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Declare: BaseManagerContent {
    var alias: String?
    var module: String?
    var arguments: ArgumentList
    var returningType: Type?
    
    var procedure: Procedure? = nil
    
    init(name: String, alias: String?, module: String?, arguments: ArgumentList, returningType: Type?) {
        self.alias = alias
        self.module = module
        self.arguments = arguments
        self.returningType = returningType
        super.init(name)
    }
}

