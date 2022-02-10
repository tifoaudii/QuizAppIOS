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
        let sut = Question.singleAnswer(inputType)
        XCTAssertEqual(sut.hashValue, inputType.hashValue)
    }
    
    func test_whenInitializeMultipleAnswerQuestion_shouldConformHashType() {
        let inputType = "a string"
        let sut = Question.multipleAnswer(inputType)
        XCTAssertEqual(sut.hashValue, inputType.hashValue)
    }
    
    func test_whenInitializeSingleAnswerQuestion_shouldEquatable() {
        XCTAssertEqual(Question.singleAnswer("a"), Question.singleAnswer("a"))
    }
    
    func test_whenInitializeSingleAnswerQuestion_shouldNotEquatable() {
        XCTAssertNotEqual(Question.singleAnswer("a"), Question.singleAnswer("b"))
    }
    
    func test_whenInitializeMultipleAnswerQuestion_shouldEquatable() {
        XCTAssertEqual(Question.multipleAnswer("a"), Question.multipleAnswer("a"))
    }
    
    func test_whenInitializeMultipleAnswerQuestion_shouldNotEquatable() {
        XCTAssertNotEqual(Question.multipleAnswer("a"), Question.multipleAnswer("b"))
    }
}
