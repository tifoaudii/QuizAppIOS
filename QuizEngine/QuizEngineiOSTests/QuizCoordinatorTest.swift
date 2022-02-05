//
//  QuizTest.swift
//  QuizEngineTests
//
//  Created by Tifo Audi Alif Putra on 05/02/22.
//

import Foundation
import XCTest
import QuizEngineiOS

class QuizCoordinatorTest: XCTestCase {
    
    func test_startQuiz_whenAnswerOneCorrectlyFromTwoQuestions_shouldGiveCorrectScore() {
        let router = RouterSpy()
        let sut = createSUT(
            questions: ["Q1", "Q2"],
            router: router,
            correctAnswers: ["Q1" : "A1", "Q2" : "A2"]
        )
        
        sut.startQuiz()
        router.answerCallback("A1")
        router.answerCallback("A3")
        
        XCTAssertEqual(router.result!.score, 1)
    }
    
    func test_startQuiz_whenHasTwoQuestionsAndAnswerWrongFromTwoQuestions_shouldGiveCorrectScore() {
        let router = RouterSpy()
        let sut = createSUT(
            questions: ["Q1", "Q2"],
            router: router,
            correctAnswers: ["Q1" : "A1", "Q2" : "A2"]
        )
        
        sut.startQuiz()
        router.answerCallback("A2")
        router.answerCallback("A3")
        
        XCTAssertEqual(router.result!.score, 0)
    }
    
    // MARK: Helpers
    
    func createSUT(questions: [String] = [], router: RouterSpy, correctAnswers: [String : String] = [:]) -> QuizCoordinator<String, String, RouterSpy> {
        QuizCoordinator(
            questions: questions,
            router: router,
            correctAnswers: correctAnswers
        )
    }
}
