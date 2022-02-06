//
//  ProgressBarChunk.swift
//  PopQuizApp
//
//  Created by David Lisica on 22.12.2021.
//

import UIKit

class ProgressBarChunk: UIView {
    
    enum ProgressBarChunkState {
        case correct
        case incorrect
        case current
        case unanswered
    }

    var numberLabel: UILabel!
    var colorLabel: UILabel!
    
    init(ofState state : ProgressBarChunkState, text: String) {
        super.init(frame: CGRect())
        
        numberLabel = UILabel()
        numberLabel.text = text
        numberLabel.textAlignment = .center
        numberLabel.isHidden = true
        numberLabel.backgroundColor = SystemDesign.backgroundColor
        self.addSubview(numberLabel)
        
        colorLabel = UILabel()
        colorLabel.layer.cornerRadius = 5
        colorLabel.layer.masksToBounds = true
        self.addSubview(colorLabel)
        
        switch(state) {
        case .correct: colorLabel.backgroundColor = .green
        case .incorrect: colorLabel.backgroundColor = .red
        case .current: colorLabel.backgroundColor = .white
        case .unanswered: colorLabel.backgroundColor = .systemGray4
        }
        
        numberLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(30)
            maker.height.equalTo(30)
            maker.top.equalToSuperview()
            maker.left.equalToSuperview()
        }
        
        colorLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(30)
            maker.height.equalTo(10)
            maker.top.equalTo(numberLabel.snp.bottom)
        }
  
        self.snp.makeConstraints { (maker) in
            maker.width.equalTo(30)
            maker.height.equalTo(40)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
