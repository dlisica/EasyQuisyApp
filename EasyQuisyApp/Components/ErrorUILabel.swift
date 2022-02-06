//
//  ErrorUILabel.swift
//  PopQuizApp
//
//  Created by David Lisica on 30.11.2021.
//

import UIKit

class ErrorUILabel: UILabel {

    init(text: String) {
        super.init(frame: CGRect())
        
        self.isHidden = true
        self.text = text
        self.textAlignment = .center
        self.textColor = .red
        self.numberOfLines = 2
        
        self.snp.makeConstraints { (maker) in
            maker.width.equalTo(250)
            maker.height.equalTo(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
