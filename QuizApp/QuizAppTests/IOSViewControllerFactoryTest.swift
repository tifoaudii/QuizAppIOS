//
//  IOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 15/02/22.
//

import XCTest
@testable import QuizApp

class IOSViewControllerFactoryTest: XCTestCase {
    
    let options = ["A1", "A2"]
    
    func test_viewControllerFactory_shouldCreateSingleAnswerQuestionViewController() {
        let viewController = createQuestionViewController(question: .singleAnswer("Q1"))
        XCTAssertNotNil(viewController)
        XCTAssertEqual(viewController.question, "Q1")
    }
    

    func test_viewControllerFactory_shouldCreateSingleAnswerQuestionViewControllerWithOptions() {
        let viewController = createQuestionViewController(question: .singleAnswer("Q1"))
        XCTAssertEqual(viewController.options, options)
    }
    
    func test_viewControllerFactory_shouldCreateSingleAnswerQuestionViewControllerWithSingleSelection() {
        let viewController = createQuestionViewController(question: .singleAnswer("Q1"))
        viewController.loadViewIfNeeded()
        XCTAssertFalse(viewController.tableView.allowsMultipleSelection)
    }
    
    func test_viewControllerFactory_shouldCreateMultipleAnswerQuestionViewController() {
        let viewController = createQuestionViewController(question: .multipleAnswer("Q1"))
        XCTAssertNotNil(viewController)
        XCTAssertEqual(viewController.question, "Q1")
    }
    

    func test_viewControllerFactory_shouldCreateMultipleAnswerQuestionViewControllerWithOptions() {
        let viewController = createQuestionViewController(question: .multipleAnswer("Q1"))
        XCTAssertEqual(viewController.options, options)
    }
    
    func test_viewControllerFactory_shouldCreateMultipleAnswerQuestionViewControllerWithMultipleSelection() {
        let viewController = createQuestionViewController(question: .multipleAnswer("Q1"))
        viewController.loadViewIfNeeded()
        XCTAssertTrue(viewController.tableView.allowsMultipleSelection)
    }
    
    // MARK: Helpers
    func createSUT(options: [QuizQuestion<String>: [String]]) -> IOSViewControllerFactory {
        return IOSViewControllerFactory(options: options)
    }
    
    func createQuestionViewController(question: QuizQuestion<String> = .singleAnswer("")) -> QuestionViewController {
        createSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
}
