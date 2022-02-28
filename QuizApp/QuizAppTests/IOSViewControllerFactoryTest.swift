//
//  IOSViewControllerFactoryTest.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 15/02/22.
//

import XCTest
import QuizEngineiOS
@testable import QuizApp

class IOSViewControllerFactoryTest: XCTestCase {
    
    let singleAnswerQuestion = QuizQuestion.singleAnswer("Q1")
    let multipleAnswerQuestion = QuizQuestion.multipleAnswer("Q1")
    let options = ["A1", "A2"]
    
    func test_viewControllerFactory_shouldCreateSingleAnswerQuestionViewControllerWithCorrectTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: singleAnswerQuestion)
        let viewController = createQuestionViewController(question: singleAnswerQuestion)
        XCTAssertEqual(viewController.title, presenter.title)
    }
     
    func test_viewControllerFactory_shouldCreateMultipleAnswerQuestionViewControllerWithCorrectTitle() {
        let presenter = QuestionPresenter(questions: [singleAnswerQuestion, multipleAnswerQuestion], question: multipleAnswerQuestion)
        let viewController = createQuestionViewController(question: multipleAnswerQuestion)
        XCTAssertEqual(viewController.title, presenter.title)
    }
    
    func test_viewControllerFactory_shouldCreateSingleAnswerQuestionViewController() {
        let viewController = createQuestionViewController(question: singleAnswerQuestion)
        XCTAssertNotNil(viewController)
        XCTAssertEqual(viewController.question, "Q1")
    }

    func test_viewControllerFactory_shouldCreateSingleAnswerQuestionViewControllerWithOptions() {
        let viewController = createQuestionViewController(question: singleAnswerQuestion)
        XCTAssertEqual(viewController.options, options)
    }
    
    func test_viewControllerFactory_shouldCreateSingleAnswerQuestionViewControllerWithSingleSelection() {
        let viewController = createQuestionViewController(question: singleAnswerQuestion)
        viewController.loadViewIfNeeded()
        XCTAssertFalse(viewController.tableView.allowsMultipleSelection)
    }
    
    func test_viewControllerFactory_shouldCreateMultipleAnswerQuestionViewController() {
        let viewController = createQuestionViewController(question: multipleAnswerQuestion)
        XCTAssertNotNil(viewController)
        XCTAssertEqual(viewController.question, "Q1")
    }
    

    func test_viewControllerFactory_shouldCreateMultipleAnswerQuestionViewControllerWithOptions() {
        let viewController = createQuestionViewController(question: multipleAnswerQuestion)
        XCTAssertEqual(viewController.options, options)
    }
    
    func test_viewControllerFactory_shouldCreateMultipleAnswerQuestionViewControllerWithMultipleSelection() {
        let viewController = createQuestionViewController(question: multipleAnswerQuestion)
        viewController.loadViewIfNeeded()
        XCTAssertTrue(viewController.tableView.allowsMultipleSelection)
    }
    
    func test_whenCreateResultScreen_shouldCreateResultViewControllerWithCorrectSummary() {
        let correctAnswers = [singleAnswerQuestion : ["A1"], multipleAnswerQuestion : ["A1", "A2"]]
        let sut = createSUT(options: [:], correctAnswers: correctAnswers)
        let userAnswers = [singleAnswerQuestion : ["A1"], multipleAnswerQuestion : ["A1", "A2"]]
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = QuizResult.createMock(answer: userAnswers, score: 2)
        let presenter = ResultPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let viewController = sut.resultViewController(for: result) as? ResultViewController

        XCTAssertEqual(viewController?.resultSummary, presenter.quizSummary)
    }
    
    func test_whenCreateResultScreen_shouldCreateResultViewControllerWithPresentableAnswer() {
        let correctAnswers = [singleAnswerQuestion : ["A1"], multipleAnswerQuestion : ["A1", "A2"]]
        let sut = createSUT(options: [:], correctAnswers: correctAnswers)
        let userAnswers = [singleAnswerQuestion : ["A1"], multipleAnswerQuestion : ["A1", "A2"]]
        let questions = [singleAnswerQuestion, multipleAnswerQuestion]
        let result = QuizResult.createMock(answer: userAnswers, score: 2)
        let presenter = ResultPresenter(result: result, questions: questions, correctAnswers: correctAnswers)
        let viewController = sut.resultViewController(for: result) as? ResultViewController

        XCTAssertEqual(viewController?.answers.count, presenter.presentableAnswer.count)
    }
    
    // MARK: Helpers
    func createSUT(options: [QuizQuestion<String>: [String]], correctAnswers: [QuizQuestion<String> : [String]] = [:]) -> IOSViewControllerFactory {
        return IOSViewControllerFactory(questions: [singleAnswerQuestion, multipleAnswerQuestion], options: options, correctAnswers: correctAnswers)
    }
    
    func createQuestionViewController(question: QuizQuestion<String> = .singleAnswer("")) -> QuestionViewController {
        createSUT(options: [question: options]).questionViewController(for: question, answerCallback: { _ in }) as! QuestionViewController
    }
}
