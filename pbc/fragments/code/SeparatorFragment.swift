//
//  SeparatorParser.swift
//  pbc
//
//  Created by Scott Rong on 2018/3/28.
//  Copyright © 2018年 jadestudio. All rights reserved.
//

import Foundation

enum SeparatorType {
    case colon
    case newLine
}

class SeparatorFragment: BaseFragment {
    var separatorType: SeparatorType
    
    init(_ separatorType: SeparatorType) {
        self.separatorType = separatorType
    }
}
