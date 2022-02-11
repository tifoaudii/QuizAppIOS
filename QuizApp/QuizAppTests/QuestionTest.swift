//
//  QuestionTest.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 08/02/22.
//

import XCTest
import Foundation
@testable import QuizApp

class QuestionTest: XCTestCase {
    
    func test_whenInitializeSingleAnswerQuestion_shouldConformHashType() {
        let inputType = "a string"
        let sut = QuizQuestion.singleAnswer(inputType)
        XCTAssertEqual(sut.hashValue, inputType.hashValue)
    }
    
    func test_whenInitializeMultipleAnswerQuestion_shouldConformHashType() {
        let inputType = "a string"
        let sut = QuizQuestion.multipleAnswer(inputType)
        XCTAssertEqual(sut.hashValue, inputType.hashValue)
    }
    
    func test_whenInitializeSingleAnswerQuestion_shouldEquatable() {
        XCTAssertEqual(QuizQuestion.singleAnswer("a"), QuizQuestion.singleAnswer("a"))
    }
    
    func test_whenInitializeSingleAnswerQuestion_shouldNotEquatable() {
        XCTAssertNotEqual(QuizQuestion.singleAnswer("a"), QuizQuestion.singleAnswer("b"))
    }
    
    func test_whenInitializeMultipleAnswerQuestion_shouldEquatable() {
        XCTAssertEqual(QuizQuestion.multipleAnswer("a"), QuizQuestion.multipleAnswer("a"))
    }
    
    func test_whenInitializeMultipleAnswerQuestion_shouldNotEquatable() {
        XCTAssertNotEqual(QuizQuestion.multipleAnswer("a"), QuizQuestion.multipleAnswer("b"))
    }
}
