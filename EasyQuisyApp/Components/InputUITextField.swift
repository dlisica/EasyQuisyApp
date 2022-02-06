//
//  InputUITextField.swift
//  PopQuizApp
//
//  Created by David Lisica on 29.11.2021.
//

import UIKit

class InputUITextField: UITextField {
    
    init(placeholderText: String) {
        super.init(frame: CGRect())
        
        self.placeholder = placeholderText
        self.backgroundColor = .secondarySystemBackground
        self.textAlignment = .center
        self.layer.cornerRadius = 25
        self.layer.borderWidth = 1
        
        self.snp.makeConstraints { (maker) in
            maker.width.equalTo(250)
            maker.height.equalTo(50)
        }
        
        self.addTarget(self, action: #selector(enterFocus), for: .editingDidBegin)
        self.addTarget(self, action: #selector(leaveFocus), for: .editingDidEnd)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func enterFocus() {
        self.layer.borderWidth += 2.0
    }
    
    @objc
    func leaveFocus() {
        self.layer.borderWidth -= 2.0
    }
    
}
