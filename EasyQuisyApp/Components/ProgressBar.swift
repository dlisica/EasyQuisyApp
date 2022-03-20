import UIKit

protocol ProgressBarDelegate: NSObjectProtocol {
    
}

class ProgressBar: UIStackView, ProgressBarDelegate {
    
    private var views = [ProgressBarChunk]()
    private var currentViewIndex = 0
    private var numberOfViews = 0
    
    func setProgressBar(withCurrentViewIndex currentViewIndex: Int, withNumberOfViews numberOfViews: Int, withPreviousStates previousStates: [Bool]) {
        self.currentViewIndex = currentViewIndex
        self.numberOfViews = numberOfViews
        
        self.spacing = 5
        self.axis = .horizontal
        self.backgroundColor = SystemDesign.backgroundColor
        
        for index in 0..<previousStates.count {
            if previousStates[index] {
                let chunck = ProgressBarChunk(ofState: .correct, text: "\(index+1)")
                views.append(chunck)
            } else {
                let chunck = ProgressBarChunk(ofState: .incorrect, text: "\(index+1)")
                views.append(chunck)
            }
        }
        
        let chunck = ProgressBarChunk(ofState: .current, text: "\(currentViewIndex+1)")
        chunck.numberLabel.isHidden = false
        views.append(chunck)
        
        for index in currentViewIndex+1..<numberOfViews {
            let chunck = ProgressBarChunk(ofState: .unanswered, text: "\(index+1)")
            views.append(chunck)
        }
        
        views.forEach { self.addArrangedSubview($0) }
        
    }
    
    func setCurrentView(isCorrect: Bool) {
        views[currentViewIndex].colorLabel.backgroundColor = isCorrect ? .green : .red
    }
    
}
