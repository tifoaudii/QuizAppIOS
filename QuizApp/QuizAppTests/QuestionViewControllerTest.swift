//
//  QuestionViewControllerTest.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 02/02/22.
//

import Foundation
import XCTest
@testable import QuizApp

class QuestionViewControllerTest: XCTestCase {
    
    func test_whenViewDidLoad_shouldRenderQuestionLabel() {
        let sut = createSUT(question: "Q1")
        XCTAssertEqual(sut.questionLabel.text, "Q1")
    }
    
    func test_whenViewDidLoad_shouldRenderOptions() {
        XCTAssertEqual(createSUT(options: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(createSUT(options: ["A1"]).tableView.numberOfRows(inSection: 0), 1)
        XCTAssertEqual(createSUT(options: ["A1", "A2"]).tableView.numberOfRows(inSection: 0), 2)
    }
    
    func test_whenViewDidLoad_shouldRenderOptionsText() {
        XCTAssertEqual(createSUT(options: ["A1"]).tableView.title(at: 0), "A1")
        XCTAssertEqual(createSUT(options: ["A1", "A2"]).tableView.title(at: 1), "A2")
        XCTAssertEqual(createSUT(options: ["A1", "A2", "A3"]).tableView.title(at: 2), "A3")
    }
    
    func test_whenOptionSelected_shouldNotifiesDelegate() {
        var receivedAnswer: String = ""
        let sut = createSUT(options: ["A1"]) {
            receivedAnswer = $0
        }
        
        let indexPath = IndexPath(row: 0, section: 0)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
        
        XCTAssertEqual(receivedAnswer, "A1")
    }
    
    // MARK: Helper
    
    func createSUT(question: String = "", options: [String] = [], selection: @escaping ((String) -> Void) = { _ in }) -> QuestionViewController {
        let sut = QuestionViewController(question: question, options: options, selection: selection)
        sut.loadViewIfNeeded()
        return sut
    }
}

private extension UITableView {
    func cell(at row: Int) -> UITableViewCell? {
        dataSource?.tableView(self, cellForRowAt: .init(row: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        cell(at: row)?.textLabel?.text
    }
}
