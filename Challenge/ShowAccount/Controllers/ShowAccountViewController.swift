//
//  ViewController
//  Challenge
//
//  Created by Kchir on 05.11.19.
//  Copyright © 2019 Test. All rights reserved.
//

import EosioSwift
import EosioSwiftAbieosSerializationProvider
import EosioSwiftSoftkeySignatureProvider

class ShowAccountViewController: UIViewController {
    
    @IBOutlet weak var currencyBalanceLabel: UILabel!
    
    @IBOutlet weak var netProgressView: UIProgressView!
    @IBOutlet weak var ramProgressView: UIProgressView!
    @IBOutlet weak var cpuProgressView: UIProgressView!
    
    @IBOutlet weak var cpuValueLabel: UILabel!
    @IBOutlet weak var netValueLabel: UILabel!
    @IBOutlet weak var ramValueLabel: UILabel!
    
    @IBOutlet weak var ramPourcentageLabel: UILabel!
    @IBOutlet weak var netPourcentageLabel: UILabel!
    @IBOutlet weak var cpuPourcentageLabel: UILabel!
    @IBOutlet weak var usdCurrencyLabel: UILabel!
    
    var rpcProvider: EosioRpcProvider?
    
    
    
    var convertedUsd : Double = 0.0
    var convertedCoreLiquidBalance : Double = 0.0
    
    var showAccountViewModel: ShowAccountViewModel?
    
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.view.activityStartAnimating(activityColor: UIColor.white, backgroundColor: UIColor.black.withAlphaComponent(0.5))
        group.enter()
        self.getUrl { (usd) in
            guard let convertedUsd: Double = Double(usd) else {
                return
            }
            self.convertedUsd = convertedUsd
            self.group.leave()
        }
        
        self.setView()
        self.getAccountFromApi { response in
            UIView.animate(withDuration: 4.0) {
                self.showAccountViewModel = ShowAccountViewModel(eosioRpcAccount: response)
                guard let showAccountVM: ShowAccountViewModel  = self.showAccountViewModel else {
                    return
                }
                self.fillView(showAccountVM: showAccountVM)
            }
        }
        
        group.notify(queue: .main) {
            guard let showAccountVM: ShowAccountViewModel = self.showAccountViewModel, let usdValue: Double = self.convertedUsd else {
                self.view.activityStopAnimating()
                return
            }
            self.usdCurrencyLabel.text = "\((usdValue * showAccountVM.convertedCoreLiquidBalance).rounded(toPlaces: 4))$"
             self.view.activityStopAnimating()
        }
        
    }
    
    fileprivate func setView() {
        ramProgressView.transform = ramProgressView.transform.scaledBy(x: 1, y: 20)
        netProgressView.transform = netProgressView.transform.scaledBy(x: 1, y: 20)
        cpuProgressView.transform = cpuProgressView.transform.scaledBy(x: 1, y: 20)
    }
    
     func getAccountFromApi(completion:@escaping (EosioRpcAccountResponse) -> ()) {
        group.enter()
        let rpcProvider = EosioRpcProvider(endpoint: URL(string: Common.API_URL_EOS)!)
        do {
            let account = EosioRpcAccountRequest(accountName: Common.ACCOUNT_NAME)
            rpcProvider.getAccount(requestParameters: account) { result in
                debugPrint(result)
                switch result {
                case .success(let eosioRpcAccountResponse):
                    completion(eosioRpcAccountResponse)
                case .failure(let error):
                    print(error)
                    print(error.reason)
                }
                
            }
            self.group.leave()
        }
    }
    
    
    fileprivate func fillView(showAccountVM: ShowAccountViewModel) {
        self.currencyBalanceLabel.text = showAccountVM.currencyBalanceText
        self.cpuValueLabel.text = showAccountVM.cpuValueText
        self.cpuPourcentageLabel.text = showAccountVM.cpuPourcentageText
        self.cpuProgressView.setProgress(showAccountVM.cpuValueNumber , animated: true)
        
        self.ramValueLabel.text = showAccountVM.ramValueText
        self.ramPourcentageLabel.text = showAccountVM.ramPourcentageText
        self.ramProgressView.setProgress(showAccountVM.ramValueNumber , animated: true)
        
        self.netValueLabel.text = showAccountVM.netValueText
        self.netPourcentageLabel.text = showAccountVM.netPourcentageText
        self.netProgressView.setProgress(showAccountVM.netValueNumber , animated: true)
    }
    
    
    private func getUrl(completion:@escaping (String) -> ()) {
        let session = URLSession.shared
        let url = URL(string: Common.API_URL_TICKER)!
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Server error!")
                return
            }
            do {
                var text = String(data: data!, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                completion(text!)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    
    
    
    
    
    
    
    
    
    
    
}












