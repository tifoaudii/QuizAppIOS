//
//  QuestionPresenterTest.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 18/02/22.
//

import Foundation
@testable import QuizApp
import XCTest

class QuestionPresenterTest: XCTestCase {
    
    func test_questionPresenter_shouldFormatCorrectTitleQuestion() {
        let question = QuizQuestion.singleAnswer("Q1")
        let sut = QuestionPresenter(questions: [question], question: question)
        XCTAssertEqual(sut.title, "Question #1")
    }
    
    func test_questionPresenter_shouldFormatCorrectTitleQuestion2() {
        let firstQuestion = QuizQuestion.singleAnswer("Q1")
        let secondQuestion = QuizQuestion.multipleAnswer("Q2")
        let sut = QuestionPresenter(questions: [firstQuestion, secondQuestion], question: secondQuestion)
        XCTAssertEqual(sut.title, "Question #2")
    }
    
    func test_questionPresenter_shouldFormatEmptyTitleWhenQuestionsEmpty() {
        let firstQuestion = QuizQuestion.singleAnswer("Q1")
        let sut = QuestionPresenter(questions: [], question: firstQuestion)
        XCTAssertEqual(sut.title, "")
    }
}
