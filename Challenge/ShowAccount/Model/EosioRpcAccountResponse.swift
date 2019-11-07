//
//  EosioRpcAccountResponse.swift
//  Challenge
//
//  Created by Kchir on 07.11.19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

import EosioSwift

extension EosioRpcAccountResponse {
    
    public func getLimitNet(used: Double, max: Double) -> Int {
        let number = round((Double(used/max) * 100))
        print(Int(number))
        return Int(number)
    }
    
    
    public func getLimitRam(used: Double, max: Double) -> Double {
        let number = round((Double(used/max)))
        return Double(number)
    }
    
    
    public func fromBytesToKB(numberBytes: Double)-> Double {
        return Double(numberBytes/1000).rounded(toPlaces: 2)
    }
    
    
    public func getRamBytesToKB(numberBytes: Double)-> Double {
        return Double(numberBytes/1024).rounded(toPlaces: 2)
    }
    
    
}
