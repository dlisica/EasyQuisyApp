//
//  BigUILabel.swift
//  PopQuizApp
//
//  Created by David Lisica on 29.11.2021.
//

import UIKit

class BigUILabel: UILabel {

    init(text: String) {
        super.init(frame: CGRect())
        
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: 25.0)
        self.numberOfLines = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
