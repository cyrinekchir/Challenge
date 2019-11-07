//
//  RangeReplaceableCollection.swift
//  Challenge
//
//  Created by Kchir on 07.11.19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

extension RangeReplaceableCollection where Self: StringProtocol {
    var digits: Self {
        return filter(("0"..."9").contains)
    }
}
