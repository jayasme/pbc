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
        do {
            try super.registerValue(declare)
        } catch let error {
            throw error
        }
    }
    
    func findDeclare(_ name: String) -> Declare? {
        return super.findValue(name)
    }
}
