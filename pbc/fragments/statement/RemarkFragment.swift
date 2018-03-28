//
//  RemarkFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/28.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

// RemarkFragment is for ' type remarks
// REMStatement is for REM type remarks
class RemarkFragment: BaseFragment {
    var remark: String
    
    init(_ remark: String) {
        self.remark = remark
    }
}
