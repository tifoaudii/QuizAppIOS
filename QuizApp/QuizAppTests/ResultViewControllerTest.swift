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
        let sut = createSUT(answers: [createDummyAnswer()])
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
    }
    
    func test_whenViewDidLoadWithCorrectAnswer_shouldRenderCorrectAnswerCell() {
        let sut = createSUT(answers: [PresentableAnswer(isCorrect: true)])
        let cell = sut.tableView.cell(at: 0) as? CorrectAnswerCell
        XCTAssertNotNil(cell)
    }
    
    func test_whenViewDidLoadWithWrongAnswer_shouldRenderWrongAnswerCell() {
        let sut = createSUT(answers: [PresentableAnswer(isCorrect: false)])
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
        PresentableAnswer(isCorrect: false)
    }
}
