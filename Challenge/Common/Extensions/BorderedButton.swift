//
//  BorderedButton.swift
//  Challenge
//
//  Created by Kchir on 07.11.19.
//  Copyright © 2019 Test. All rights reserved.
//

import UIKit

class BorderedButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        setTitleColor(tintColor, for: .normal)
        setTitleColor(UIColor.white, for: .highlighted)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 1.0
    }
    
}
