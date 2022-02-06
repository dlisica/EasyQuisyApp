//
//  BigInputUITextField.swift
//  PopQuizApp
//
//  Created by David Lisica on 01.12.2021.
//

import Foundation
import UIKit

// HOW TO ADD TARGET TO UITEXTVIEW ???
class BigInputUITextField : UITextView {
    
    init(text: String) {
        super.init(frame: CGRect.zero, textContainer: nil)
        
        self.text = text
        
        self.font = UIFont(name: "Callout", size: 20)
        self.textAlignment = .center
        self.layer.borderWidth = 1
        self.autocorrectionType = .no
        self.backgroundColor = .secondarySystemBackground
        self.textColor = .black
        self.font = UIFont.preferredFont(forTextStyle: .body)
        self.layer.cornerRadius = 25
        self.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
    
        self.snp.makeConstraints { (maker) in
            maker.width.equalTo(250)
            maker.height.equalTo(100)
        }
        
        let tap = UIGestureRecognizer(target: self, action: #selector(enterFocus))
        
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func enterFocus() {
        self.layer.borderWidth += 2.0
        print("enter")
    }
    
    @objc
    func leaveFocus() {
        self.layer.borderWidth -= 2.0
        print("leave")
    }
    
}
