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
        let sut = QuestionViewController(question: "Q1", options: [])
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.questionLabel.text, "Q1")
    }

    func test_whenViewDidLoadWithNoOptions_shouldRenderEmptyOptions() {
        let sut = QuestionViewController(question: "Q1", options: [])
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
    }
    

    func test_whenViewDidLoadWithOneOptions_shouldRenderOneOption() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_whenViewDidLoadWithOneOptions_shouldRenderOptionText() {
        let sut = QuestionViewController(question: "Q1", options: ["A1"])
        
        sut.loadViewIfNeeded()
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: indexPath)
        XCTAssertEqual(cell?.textLabel?.text, "A1")
    }
}
