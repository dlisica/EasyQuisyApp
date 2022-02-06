//
//  TitleUILabel.swift
//  PopQuizApp
//
//  Created by David Lisica on 29.11.2021.
//

import UIKit

class TitleUILabel: UILabel {

    init(textSize: Double) {
        super.init(frame: CGRect())
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "American Typewriter Semibold", size: textSize)! ]
        let myAttrString = NSAttributedString(string: SystemDesign.quizName, attributes: myAttribute)
        
        self.attributedText = myAttrString
        self.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
