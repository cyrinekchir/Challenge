//
//  ChallengeTests.swift
//  ChallengeTests
//
//  Created by Kchir on 05.11.19.
//  Copyright © 2019 Test. All rights reserved.
//

import XCTest
@testable import Challenge
import EosioSwift


class ChallengeTests: XCTestCase {
    
    let json = """
            {    "account_name":"eosasia11111",
                "head_block_num":88657837,"head_block_time":"2019-11-07T14:22:39.000","privileged":false,"last_code_update":"1970-01-01T00:00:00.000","created":"2018-06-10T13:04:53.500","core_liquid_balance":"5531.3660 EOS","ram_quota":28614,"net_weight":1000,"cpu_weight":6000426,"net_limit":{"used":105,"available":77977,"max":78082},"cpu_limit":{"used":1126,"available":60591,"max":61717},"ram_usage":9670,"permissions":[{"perm_name":"active","parent":"owner","required_auth":{"threshold":2,"keys":[{"key":"EOS5G83XMHXGmnne3tXopUfCfxMx3kJbToSzTu6C5UgpSAvjAEtyA","weight":2},{"key":"EOS5uAo3139tpiw8yShyAJSDQXA4ZfdRB6E6XCs4sUuf2mQAeAzzX","weight":1},{"key":"EOS7AvCa1XMEeoYcxB6sPGe5fbYeTMnGARfm5MrKuFY9zjtVFPfaT","weight":1}],"accounts":[],"waits":[]}},{"perm_name":"blacklistops","parent":"active","required_auth":{"threshold":1,"keys":[{"key":"EOS8eC1s1XY69Rw99c2Y1gz9mRpUW88mYeK4HViqR3jUQX6HDE9Cf","weight":1}],"accounts":[],"waits":[]}},{"perm_name":"claimer","parent":"active","required_auth":{"threshold":1,"keys":[{"key":"EOS7GgX1yTyApcSKvCFYrBgY2xKiUYfkQ6bfM9Yvm2rtBrzJNokL2","weight":1}],"accounts":[],"waits":[]}},{"perm_name":"day2day","parent":"active","required_auth":{"threshold":1,"keys":[{"key":"EOS64cD7xEXGasbE9HqBtW62AikG2Ko7R8atHDEysVB1sJkg3DjUG","weight":1}],"accounts":[],"waits":[]}},{"perm_name":"owner","parent":"","required_auth":{"threshold":1,"keys":[{"key":"EOS83HZEdUFuB5krCYLHSosMUuguxYh7QhwbHZDYBwsLAyuiJcbFi","weight":1}],"accounts":[],"waits":[]}},{"perm_name":"refvoter","parent":"active","required_auth":{"threshold":1,"keys":[{"key":"EOS619KjhGMSoE2S9acxQpA6m35ynUSaXUQ7sTU1fdrtCbPo97Gio","weight":1}],"accounts":[],"waits":[]}}],"total_resources":{"owner":"eosasia11111","net_weight":"0.1000 EOS","cpu_weight":"600.0426 EOS","ram_bytes":27214},"self_delegated_bandwidth":{"from":"eosasia11111","to":"eosasia11111","net_weight":"0.1000 EOS","cpu_weight":"2.1000 EOS"},"refund_request":null,"voter_info":{"owner":"eosasia11111","proxy":"","producers":["eosasia11111"],"staked":26240,"last_vote_weight":"24080935818.67958068847656250","proxied_vote_weight":"0.00000000000000000","is_proxy":0,"flags1":0,"reserved2":0,"reserved3":"0.0000 EOS"}}
        """
    
    
    

    override func setUp() {}

    override func tearDown() {}
    
    func testgetAccountWalletAPI() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        XCTAssertNotNil(sb, "Could not instantiate storyboard for Info View content loading")
        guard let vc = sb.instantiateViewController(withIdentifier: "InformationView") as? ShowAccountViewController else {
            XCTAssert(false, "Could not instaniate view controller for Info View content loading")
            return
        }
        _ = vc.view
        let oldCpuValueLabel = vc.cpuValueLabel.text
        vc.getAccountFromApi { response in
            vc.showAccountViewModel = ShowAccountViewModel(eosioRpcAccount: response)
            XCTAssertNotNil(vc.showAccountViewModel)
            let newCpuValueLabel = vc.cpuValueLabel.text
            XCTAssert(oldCpuValueLabel != newCpuValueLabel, "Loading content for Account did not change text")
        }
        
    }

    
    
    func testInfoAccountWallet() {
        
        let jsonData = json.data(using: .utf8)
        let decoder = JSONDecoder()
         do {
            let eosioRpcAccountResponse: EosioRpcAccountResponse = try decoder.decode(EosioRpcAccountResponse.self, from: jsonData!)
            let viewModel = ShowAccountViewModel(eosioRpcAccount: eosioRpcAccountResponse)
            XCTAssertEqual(eosioRpcAccountResponse.accountName, viewModel.eosioRpcAccount.accountName)
           let ramUsageValue = viewModel.getRamValue(ramValueConverted: " \(eosioRpcAccountResponse.ramUsage)")
            XCTAssertEqual(ramUsageValue, "9670")
         } catch {
            print("error")
        }
        
        
    }
    

    

}
