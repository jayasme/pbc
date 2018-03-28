//
//  FileFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/27.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class FileFragment: BaseFragment {
    var path: String
    var compound: CompoundStatementFragment
    
    init(path: String, compound: CompoundStatementFragment) {
        self.path = path
        self.compound = compound
    }
}
