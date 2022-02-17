//
//  ResultPresenterTest.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 17/02/22.
//

import XCTest
import QuizEngineiOS
@testable import QuizApp

class ResultPresenterTest: XCTestCase {
    
    func test_whenAnswerTwoQuestionWithOneCorrectAnswer_shouldCreateCorrectResultSummary() {
        
        let answer = [
            QuizQuestion.singleAnswer("Q1") : ["A1"],
            QuizQuestion.singleAnswer("Q2") : ["A2"],
        ]
        
        let result = QuizResult.createMock(answer: answer, score: 1)
        let sut = ResultPresenter(result: result, correctAnswers: [:])
        XCTAssertEqual(sut.quizSummary, "You got 1 from 2 correct answer")
    }
    
    func test_whenGotEmptyAnswer_shouldCreateEmptyPresentableAnswer() {
        let answer: [QuizQuestion<String> : [String]] = [:]
        let result = QuizResult.createMock(answer: answer, score: 1)
        let sut = ResultPresenter(result: result, correctAnswers: [:])
        XCTAssertTrue(sut.presentableAnswer.isEmpty)
    }
    
    func test_whenGotWrongSingleAnswers_shouldCreatePresentableAnswer() {
        let answer = [
            QuizQuestion.singleAnswer("Q1") : ["A1"]
        ]
        
        let correctAnswer = [
            QuizQuestion.singleAnswer("Q1") : ["A2"]
        ]
        
        let result = QuizResult.createMock(answer: answer, score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1")
    }
    
    func test_whenGotWrongMultipleAnswers_shouldCreatePresentableAnswer() {
        let answer = [
            QuizQuestion.multipleAnswer("Q1") : ["A1", "A4"]
        ]
        
        let correctAnswer = [
            QuizQuestion.multipleAnswer("Q1") : ["A2", "A3"]
        ]
        
        let result = QuizResult.createMock(answer: answer, score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertEqual(sut.presentableAnswer.first!.wrongAnswer, "A1, A4")
    }
    
    func test_whenGotCorrectSingleAnswers_shouldCreatePresentableAnswer() {
        let answer = [
            QuizQuestion.singleAnswer("Q1") : ["A2"]
        ]
        
        let correctAnswer = [
            QuizQuestion.singleAnswer("Q1") : ["A2"]
        ]
        
        let result = QuizResult.createMock(answer: answer, score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
    }
    
    func test_whenGotCorrectMultipleAnswers_shouldCreatePresentableAnswer() {
        let answer = [
            QuizQuestion.multipleAnswer("Q1") : ["A2", "A3"]
        ]
        
        let correctAnswer = [
            QuizQuestion.multipleAnswer("Q1") : ["A2", "A3"]
        ]
        
        let result = QuizResult.createMock(answer: answer, score: 0)
        let sut = ResultPresenter(result: result, correctAnswers: correctAnswer)
        
        XCTAssertEqual(sut.presentableAnswer.count, 1)
        XCTAssertEqual(sut.presentableAnswer.first!.question, "Q1")
        XCTAssertEqual(sut.presentableAnswer.first!.answer, "A2, A3")
        XCTAssertNil(sut.presentableAnswer.first!.wrongAnswer)
    }
    
}
