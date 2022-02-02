//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 02/02/22.
//

import UIKit

final class QuestionViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var question: String = ""
    private var options: [String] = []
    
    convenience init(question: String, options: [String]) {
        self.init()
        self.question = question
        self.options = options
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel?.text = question
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "A1"
        return cell
    }
}
