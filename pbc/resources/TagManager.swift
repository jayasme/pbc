//
//  TagManager.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/2.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class TagManager: BaseManager<Tag> {
    
    func registerTag(_ tag: Tag) throws {
        try super.registerValue(tag)
    }
    
    func findTag(_ name: String) -> Tag? {
        return super.findValue(name)
    }
}

