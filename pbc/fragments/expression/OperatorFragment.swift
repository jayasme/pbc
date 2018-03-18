//
//  OperatorFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/14.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class OperatorFragment: ExpressionSubFragment {
    var value: Operator
    
    init(_ value: Operator) {
        self.value = value
    }
}
