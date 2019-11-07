//
//  Double.swift
//  Challenge
//
//  Created by Kchir on 07.11.19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

extension Double {
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

