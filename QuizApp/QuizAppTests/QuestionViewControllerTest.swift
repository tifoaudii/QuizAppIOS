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
    
    func test_whenOptionSelectedWithSingleSelection_shouldNotifiesLastSelection() {
        var receivedAnswer: [String] = []
        let sut = createSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A2"])
    }
     
    func test_whenOptionDeselectedWithSingleSelection_shouldNotNotifiyDelegate() {
        var receivedAnswer: [String] = []
        let sut = createSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
    }
    
    func test_whenOptionSelectedAndEnabledMultipleSelection_shouldNotifiesDelegateSelections() {
        var receivedAnswer: [String] = []
        let sut = createSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.select(row: 1)
        XCTAssertEqual(receivedAnswer, ["A1", "A2"])
    }
    
    func test_whenOptionDeselectedAndEnabledMultipleSelection_shouldNotifiesDelegate() {
        var receivedAnswer: [String] = []
        let sut = createSUT(options: ["A1", "A2"]) { receivedAnswer = $0 }
        sut.tableView.allowsMultipleSelection = true
        
        sut.tableView.select(row: 0)
        XCTAssertEqual(receivedAnswer, ["A1"])
        
        sut.tableView.deselect(row: 0)
        XCTAssertEqual(receivedAnswer, [])
    }
    
    // MARK: Helper
    
    func createSUT(question: String = "", options: [String] = [], selection: @escaping (([String]) -> Void) = { _ in }) -> QuestionViewController {
        let questionExample = QuizQuestion.singleAnswer(question)
        let factory = IOSViewControllerFactory(questions: [], options: [questionExample : options])
        let sut = factory.questionViewController(for: questionExample, answerCallback: selection) as! QuestionViewController
        sut.loadViewIfNeeded()
        return sut
    }
} 
