//
//  IOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 15/02/22.
//

import XCTest
@testable import QuizApp

class IOSViewControllerFactoryTest: XCTestCase {
    
    func test_viewControllerFactory_shouldCreateQuestionViewController() {
        let question = QuizQuestion.singleAnswer("Q1")
        let options = ["A1", "A2"]
        
        let sut = IOSViewControllerFactory(options: [question: options])
        let viewController = sut.questionViewController(for: question, answerCallback: { _ in }) as? QuestionViewController
        
        XCTAssertNotNil(viewController)
        XCTAssertEqual(viewController?.question, "Q1")
    }
    

    func test_viewControllerFactory_shouldCreateQuestionViewControllerWithOptions() {
        let question = QuizQuestion.singleAnswer("Q1")
        let options = ["A1", "A2"]
        
        let sut = IOSViewControllerFactory(options: [question : options])
        let viewController = sut.questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
        
        XCTAssertEqual(viewController.options, options)
    }
}
