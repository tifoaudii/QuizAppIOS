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
        XCTAssertEqual(createSUT(answers: [createDummyAnswer()]).tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_whenViewDidLoadWithCorrectAnswer_shouldConfigureCorrectCell() {
        let answer = createAnswer(question: "Q1", answer: "A1", isCorrect: true)
        let sut = createSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.answerLabel.text, "A1")
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
    }
    
    func test_whenViewDidLoadWithWrongAnswer_shouldConfigureCorrectCell() {
        let answer = createAnswer(question: "Q1", answer: "A1", isCorrect: false)
        let sut = createSUT(answers: [answer])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell?.correctAnswerLabel.text, "A1")
        XCTAssertEqual(cell?.questionLabel.text, "Q1")
    }
    
    func test_whenViewDidLoadWithWrongAnswer_shouldRenderWrongAnswerCell() {
        let sut = createSUT(answers: [createAnswer(isCorrect: false)])
        let cell = sut.tableView.cell(at: 0) as? WrongAnswerCell
        XCTAssertNotNil(cell)
    }
    
    // MARK: Helpers
    
    func createSUT(resultSummary: String = "", answers: [PresentableAnswer] = []) -> ResultViewController {
        let sut = ResultViewController(resultSummary: resultSummary, answers: answers)
        sut.loadViewIfNeeded()
        return sut
    }
    
    func createDummyAnswer() -> PresentableAnswer {
        createAnswer(isCorrect: false)
    }
    
    func createAnswer(question: String = "", answer: String = "", isCorrect: Bool) -> PresentableAnswer {
        PresentableAnswer(answer: answer, isCorrect: isCorrect, question: question)
    }
}
