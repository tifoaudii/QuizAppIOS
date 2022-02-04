//
//  ResultViewController.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 04/02/22.
//

import UIKit

struct PresentableAnswer {
    let isCorrect: Bool
}

class CorrectAnswerCell: UITableViewCell {
    
}

class WrongAnswerCell: UITableViewCell {
    
}

final class ResultViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var resultSummary: String = ""
    private var answers: [PresentableAnswer] = []
    
    convenience init(resultSummary: String, answers: [PresentableAnswer]) {
        self.init()
        self.resultSummary = resultSummary
        self.answers = answers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel?.text = resultSummary
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if answers[indexPath.row].isCorrect {
            return CorrectAnswerCell()
        }
        
        return WrongAnswerCell()
    }
}
