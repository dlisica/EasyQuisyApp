//
//  QuizzesViewController.swift
//  PopQuizApp
//
//  Created by David Lisica on 29.11.2021.
//

import UIKit

protocol QuizzesViewDelegate : NSObjectProtocol {
}

class QuizzesViewController: UIViewController, QuizzesViewDelegate {
    
    private let quizzesPresenter = QuizzesPresenter(dataService: DataService.getDataService())
    
    private var quizTableView: UITableView!
    
    let cellIdentifier = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quizzesPresenter.setViewDelegate(quizzesViewDelegate: self)
        
        setLayout()
        setTableView()
    }
    
    private func setLayout() {
        self.view.backgroundColor = SystemDesign.backgroundColor
        navigationItem.titleView = TitleUILabel(textSize: 25)
        
        let titleLabel : UILabel = TitleUILabel(textSize: 45.0)
        titleLabel.text = "Quizzes"
        self.view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (maker) in
            maker.width.equalTo(250)
            maker.height.equalTo(50)
            maker.centerX.equalToSuperview()
            maker.top.equalToSuperview().offset(100)
        }
        
        quizTableView = UITableView(frame: .zero, style: .grouped)
        quizTableView.backgroundColor = SystemDesign.backgroundColor
        self.view.addSubview(quizTableView)
        quizTableView.snp.makeConstraints { (maker) in
            maker.centerX.equalToSuperview()
            maker.top.equalTo(titleLabel.snp.bottom).offset(30)
            maker.bottom.equalToSuperview().offset(-50)
            maker.left.equalToSuperview().offset(10)
            maker.right.equalToSuperview().offset(-10)
        }
        
    }
    
    private func setTableView() {
        quizTableView.register(QuizTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        quizTableView.dataSource = self
        quizTableView.delegate = self
        
        quizTableView.rowHeight = 150
    }

}

extension QuizzesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return quizzesPresenter.getNumberOfCategories()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzesPresenter.getNumberOfQuizzesByCategory(categoryIndex: section)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: QuizTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! QuizTableViewCell
        let quiz = quizzesPresenter.getQuiz(categoryIndex: indexPath.section, quizIndex: indexPath.row)
        cell.setQuizInfo(name: quiz.name, description: quiz.description, author: quiz.author, imageUrl: quiz.imageUrl)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        headerLabel.text = "    " + quizzesPresenter.getCategory(categoryIndex: section).rawValue
        headerLabel.font = .boldSystemFont(ofSize: 15)
        return headerLabel
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //change selection style
        
        let startQuizVC = StartQuizViewController(quiz: quizzesPresenter.getQuiz(categoryIndex: indexPath.section, quizIndex: indexPath.row))
        self.navigationController?.pushViewController(startQuizVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedIndexPath = quizTableView.indexPathForSelectedRow {
            quizTableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
    
}
