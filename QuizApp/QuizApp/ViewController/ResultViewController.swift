//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 04/02/22.
//

import UIKit

final class ResultViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var resultSummary: String = ""
    private(set) var answers: [PresentableAnswer] = []
    
    convenience init(resultSummary: String, answers: [PresentableAnswer]) {
        self.init()
        self.resultSummary = resultSummary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel?.text = resultSummary
        tableView.registerCell(for: CorrectAnswerCell.self)
        tableView.registerCell(for: WrongAnswerCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let answer = answers[indexPath.row]
        if answer.wrongAnswer == nil {
            return createCorrectAnswerCell(for: answer)
        }
        
        return createWrongAnswerCell(for: answer)
    }
    
    private func createCorrectAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: CorrectAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.answerLabel.text = answer.answer
        return cell
    }
    
    private func createWrongAnswerCell(for answer: PresentableAnswer) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: WrongAnswerCell.self)!
        cell.questionLabel.text = answer.question
        cell.correctAnswerLabel.text = answer.answer
        cell.wrongAnswerLabel.text = answer.wrongAnswer
        return cell
    }
}

