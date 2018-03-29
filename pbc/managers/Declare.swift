//
//  Declare.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class Declare: BaseManagerContent {
    var name: String
    var alias: String?
    var module: String?
    var parameters: Parameters
    
    var procedure: Procedure? = nil
    
    init(name: String, alias: String?, module: String?, parameters: Parameters) {
        self.name = name
        self.alias = alias
        self.module = module
        self.parameters = parameters
    }
    
    var sub: Sub? {
        get {
            return self.procedure as? Sub
        }
        set(value) {
            self.procedure = value
        }
    }
    
    var function: Function? {
        get {
            return self.procedure as? Function
        }
        set(value) {
            self.procedure = value
        }
    }
}

class SubDeclare: Declare { }

class FunctionDeclare: Declare {
    var returningType: TypeTuple
    
    init(name: String, alias: String?, module: String?, parameters: Parameters, returningType: TypeTuple) {
        self.returningType = returningType
        
        super.init(name: name, alias: alias, module: module, parameters: parameters)
    }
}
