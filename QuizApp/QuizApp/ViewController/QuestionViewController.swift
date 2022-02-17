//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 02/02/22.
//

import UIKit

final class QuestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private(set) var question: String = ""
    private(set) var options: [String] = []
    
    private var selection: (([String]) -> Void)?
    private var selectionAnswer: [String] = []
    
    private let reuseIdentifier: String = "CellIdentifier"
    private var isMultipleAnswer: Bool = false
    
    convenience init(question: String, options: [String], isMultipleAnswer: Bool = false, selection: @escaping ([String]) -> Void) {
        self.init()
        self.question = question
        self.options = options
        self.selection = selection
        self.isMultipleAnswer = isMultipleAnswer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel?.text = question
        tableView.allowsMultipleSelection = isMultipleAnswer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dequeueCell(in: tableView)
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selection?(optionsSelected(in: tableView))
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if tableView.allowsMultipleSelection {
            selection?(optionsSelected(in: tableView))
        }
    }
    
    private func optionsSelected(in tableView: UITableView) -> [String] {
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else {
            return []
        }
        
        return selectedIndexPaths.map { options[$0.row] }
    }
    
    private func dequeueCell(in tableView: UITableView) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) {
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
    }
}
