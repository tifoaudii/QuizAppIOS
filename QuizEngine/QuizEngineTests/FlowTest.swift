//
//  RouterTest.swift
//  QuizEngineTests
//
//  Created by Tifo Audi Alif Putra on 31/01/22.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    let router: RouterSpy = RouterSpy()
    
    func test_whenNoQuestion_shouldNotRoutedToQuestion() {
        // Given
        let sut = createSUT(questions: [])
        
        // When
        sut.start()
        
        // Then
        XCTAssertTrue(router.questions.isEmpty)
    }
    
    func test_whenHasOneQuestion_shouldRoutesToCorrectQuestion() {
        // Given
        let sut = createSUT(questions: ["Q1"])

        // When
        sut.start()

        // Then
        XCTAssertEqual(router.questions, ["Q1"])
    }
    
    func test_whenHasOneQuestion_shouldRoutesToCorrectQuestion2() {
        // Given
        let sut = createSUT(questions: ["Q2"])

        // When
        sut.start()

        // Then
        XCTAssertEqual(router.questions, ["Q2"])
    }
    
    func test_whenHasTwoQuestions_shouldRoutesToFirstQuestion() {
        // Given
        let sut = createSUT(questions: ["Q1", "Q2"])

        // When
        sut.start()

        // Then
        XCTAssertEqual(router.questions, ["Q1"])
    }
    
    func test_whenHasTwoQuestionsAndStartTwice_shouldRoutesToFirstQuestionTwice() {
        // Given
        let sut = createSUT(questions: ["Q1", "Q2"])

        // When
        sut.start()
        sut.start()

        // Then
        XCTAssertEqual(router.questions, ["Q1", "Q1"])
    }
    
    func test_whenHasTwoQuestionsAnsAnswerFirstQuestion_shouldRoutesToSecondQuestion() {
        // Given
        let sut = createSUT(questions: ["Q1", "Q2"])

        // When
        sut.start()
        router.answerCallback("A1")

        // Then
        XCTAssertEqual(router.questions, ["Q1", "Q2"])
    }
    
    func test_whenAnswerFirstAndSecondQuestionAndHasThreeQuestions_shouldRoutesToSecondAndThreeQuestion() {
        // Given
        let sut = createSUT(questions: ["Q1", "Q2", "Q3"])
        
        // When
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        // Then
        XCTAssertEqual(router.questions, ["Q1", "Q2", "Q3"])
    }
    
    func test_whenAnswerFirstQuestionAndHasOnlyOneQuestion_shouldNotRoutesToAnotherQuestion() {
        // Given
        let sut = createSUT(questions: ["Q1"])
        
        // When
        sut.start()
        router.answerCallback("A1")
        
        // Then
        XCTAssertEqual(router.questions, ["Q1"])
    }
    
    func test_whenNoQuestion_shouldRoutedToResult() {
        // Given
        let sut = createSUT(questions: [])
        
        // When
        sut.start()
        
        // Then
        XCTAssertEqual(router.result, [:])
    }
    
    func test_whenAnswerFirstAndSecondQuestionAndHasTwoQuestions_shouldRoutesToResult() {
        // Given
        let sut = createSUT(questions: ["Q1", "Q2"])
        
        // When
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        // Then
        XCTAssertEqual(router.result, ["Q1" : "A1", "Q2" : "A2"])
    }
    
    func test_whenHasOneQuestionAndNotAnsweredYet_shouldNotRoutesToResult() {
        // Given
        let sut = createSUT(questions: ["Q1"])
        
        // When
        sut.start()
        
        // Then
        XCTAssertNil(router.result)
    }
    
    func test_whenAnswerFirstQuestionAndHasTwoQuestions_shouldNotRoutesToResult() {
        // Given
        let sut = createSUT(questions: ["Q1", "Q2"])
        
        // When
        sut.start()
        router.answerCallback("A1")
        
        // Then
        XCTAssertNil(router.result)
    }
    
    // MARK: Helpers
    
    func createSUT(questions: [String]) -> Flow {
        Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var questions: [String] = []
        var result: [String : String]?
        var answerCallback: ((String) -> Void) = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping Router.AnswerCallback) {
            questions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String : String]) {
            self.result = result
        }
    }
}
