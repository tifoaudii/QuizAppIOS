//
//  ResultViewControllerTest.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 04/02/22.
//

import Foundation
import XCTest
@testable import QuizApp

class ResultViewControllerTest: XCTestCase {
    
    func test_whenViewDidLoad_shouldRenderResultSummary() {
        let sut = createSUT(resultSummary: "A result summary")
        XCTAssertEqual(sut.headerLabel?.text, "A result summary")
    }
    
    func test_whenViewDidLoad_shouldRenderUserAnswers() {
        XCTAssertEqual(createSUT(answers: []).tableView.numberOfRows(inSection: 0), 0)
        XCTAssertEqual(createSUT(answers: [createAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_whenViewDidLoadWithCorrectAnswer_shouldConfigureCorrectCell() {
        let answer = createAnswer(question: "Q1", answer: "A1")
        let sut = createSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.answerLabel.text, "A1")
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
    }
    
    func test_whenViewDidLoadWithWrongAnswer_shouldConfigureCorrectCell() {
        let answer = createAnswer(question: "Q1", wrongAnswer: "wrong", answer: "A1")
        let sut = createSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
        XCTAssertEqual(cell?.wrongAnswerLabel.text, "wrong")
    }
    
    // MARK: Helpers
    
    func createSUT(resultSummary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(resultSummary: resultSummary, answers: answers)
        sut.loadViewIfNeeded()
        return sut
    }

    func createAnswer(question: String = "", wrongAnswer: String? = nil, answer: String = "") -> PresentableAnswer {
        PresentableAnswer(answer: answer, question: question, wrongAnswer: wrongAnswer)
    }
}
