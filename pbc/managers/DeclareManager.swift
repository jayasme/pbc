//
//  DeclareManager.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/4.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class DeclareManager: BaseManager<Declare> {
    
    func registerDeclare(_ declare: Declare) throws {
        try super.registerValue(declare)
    }
    
    func findDeclare(_ name: String) -> Declare? {
        return super.findValue(name)
    }
}
