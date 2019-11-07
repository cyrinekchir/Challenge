//
//  ShowAccountViewModel.swift
//  Challenge
//
//  Created by Kchir on 07.11.19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation
import EosioSwift



public final class ShowAccountViewModel {
    
    
    public let eosioRpcAccount: EosioRpcAccountResponse
    
    public var currencyBalanceText: String = ""
    public var cpuPourcentageText: String = ""
    public var cpuValueText: String = ""
    public var cpuValueNumber: Float = 0.0
    public var netValueText: String = ""
    public var netValueNumber: Float = 0.0
    public var netPourcentageText: String = ""
    public var ramValueText: String = ""
    
    public var ramValueNumber: Float = 0.0
    public var ramPourcentageText: String = ""
    var usdCurrencyText: String = ""
    
 
    var convertedCoreLiquidBalance : Double = 0.0
    
    
    // MARK: - Object Lifecycle
    public init(eosioRpcAccount: EosioRpcAccountResponse) {
        self.eosioRpcAccount = eosioRpcAccount
        self.currencyBalanceText = "\(eosioRpcAccount.coreLiquidBalance)"
        
        if let cpuUsed: Double = self.eosioRpcAccount.cpuLimit["used"] as? Double,
            let cpuLimit: Double = self.eosioRpcAccount.cpuLimit["max"] as? Double   {
            
            self.cpuValueText = "\(self.eosioRpcAccount.fromBytesToKB(numberBytes: Double(cpuUsed))) KB / \(self.eosioRpcAccount.fromBytesToKB(numberBytes:Double(cpuLimit))) KB"
            self.cpuPourcentageText = "\(self.eosioRpcAccount.getLimitNet(used: cpuUsed, max: cpuLimit)) %"
            self.cpuValueNumber = Float(cpuUsed/cpuLimit)
        }
        
        if let coreLiquidBalanceConverted: Double = Double(eosioRpcAccount.coreLiquidBalance.digits) {
            self.convertedCoreLiquidBalance = coreLiquidBalanceConverted
        }
        
        if let netUsed: Double = eosioRpcAccount.netLimit["used"] as? Double, let netLimit: Double = eosioRpcAccount.netLimit["max"] as? Double  {
            self.netValueText = "\(self.eosioRpcAccount.fromBytesToKB(numberBytes: Double(netUsed))) KB / \(self.eosioRpcAccount.fromBytesToKB(numberBytes:Double(netLimit))) KB"
            self.netPourcentageText = "\(self.eosioRpcAccount.getLimitNet(used: netUsed, max: netLimit)) %"
            self.netValueNumber = Float(netUsed/netLimit)
        }
        
        let ramUsages = self.getRamValue(ramValueConverted: "\(self.eosioRpcAccount.ramUsage)")
        let ramQuotas = self.getRamValue(ramValueConverted: "\(self.eosioRpcAccount.ramQuota)")
        
        
        if let ramUsed: Double = Double(ramUsages),
            let ramLimit: Double = Double(ramQuotas) {
            self.ramValueText = "\(self.eosioRpcAccount.getRamBytesToKB(numberBytes: ramUsed)) KB / \(self.eosioRpcAccount.getRamBytesToKB(numberBytes: ramLimit)) KB"
            self.ramPourcentageText = "\(self.eosioRpcAccount.getLimitNet(used: ramUsed, max: ramLimit)) %"
            self.ramValueNumber = Float(ramUsed/ramLimit)
        }
    }
    
    
    public func getRamValue(ramValueConverted: String)-> String {
        let splitedRam = ramValueConverted.components(separatedBy: ["(", ")"])
        return  splitedRam[1]
    }
    
    
    
    
    
}





