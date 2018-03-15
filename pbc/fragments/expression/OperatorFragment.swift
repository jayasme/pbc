//
//  OperatorFragment.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/14.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

class OperatorFragment: ExpressionSubFragment {
    var oper: Operator
    
    init(_ oper: Operator) {
        self.oper = oper
    }
}
