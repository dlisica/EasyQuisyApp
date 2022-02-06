//
//  SmallUILabel.swift
//  PopQuizApp
//
//  Created by David Lisica on 29.11.2021.
//

import UIKit

class SmallUILabel: UILabel {

    init(text: String) {
        super.init(frame: CGRect())
        
        self.text = text
        self.font = self.font.withSize(15.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
