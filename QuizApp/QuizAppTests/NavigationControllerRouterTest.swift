//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 06/02/22.
//

import UIKit
@testable import QuizEngineiOS
import XCTest
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    
    func test_whenRoutesToQuestion_shouldPushToCorrectViewController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        
        factory.stub(question: QuizQuestion.singleAnswer("Q1"), with: viewController)
        factory.stub(question: QuizQuestion.singleAnswer("Q2"), with: secondViewController)
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        sut.routeTo(question: QuizQuestion.singleAnswer("Q1"), answerCallback: { _ in })
        sut.routeTo(question: QuizQuestion.singleAnswer("Q2"), answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_whenRoutesToSingleAnswerQuestion_shouldGetTheAnswerCallback() {
        let viewController = UIViewController()
        
        factory.stub(question: QuizQuestion.singleAnswer("Q1"), with: viewController)
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        var answerCallbackCalled = false
        var receivedAnswer: [String] = []
        
        sut.routeTo(question: QuizQuestion.singleAnswer("Q1"), answerCallback: { answer in
            receivedAnswer = answer
            answerCallbackCalled = true
        })
        
        factory.answersStub[QuizQuestion.singleAnswer("Q1")]!(["A1"])
        
        XCTAssertTrue(answerCallbackCalled)
        XCTAssertEqual(receivedAnswer, ["A1"])
    }
    
    func test_whenRoutesToMultipleAnswerQuestion_shouldNotGoToNextQuestion() {
        let viewController = UIViewController()
        
        factory.stub(question: QuizQuestion.multipleAnswer("Q1"), with: viewController)
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        var answerCallbackCalled = false
        
        sut.routeTo(question: QuizQuestion.multipleAnswer("Q1"), answerCallback: { answer in
            answerCallbackCalled = true
        })
        
        XCTAssertFalse(answerCallbackCalled)
    }
    
    func test_whenRoutesToMultipleAnswerQuestion_shouldConfigureRightBarButtonItem() {
        let viewController = UIViewController()
        
        factory.stub(question: QuizQuestion.multipleAnswer("Q1"), with: viewController)
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        sut.routeTo(question: QuizQuestion.multipleAnswer("Q1"), answerCallback: { _ in })
        
        XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem)
        XCTAssertFalse(viewController.navigationItem.rightBarButtonItem!.isEnabled)
        
        factory.answersStub[QuizQuestion.multipleAnswer("Q1")]!(["A1"])
        XCTAssertTrue(viewController.navigationItem.rightBarButtonItem!.isEnabled)
    }
    
    func test_whenRoutesToMultipleAnswerQuestion_shouldNavigateToNextQuestion() {
        let viewController = UIViewController()
        factory.stub(question: QuizQuestion.multipleAnswer("Q1"), with: viewController)
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        var answerCallbackCalled = false
        sut.routeTo(question: QuizQuestion.multipleAnswer("Q1"), answerCallback: { _ in
            answerCallbackCalled = true
        })
        
        factory.answersStub[QuizQuestion.multipleAnswer("Q1")]!(["A1"])
        let button = viewController.navigationItem.rightBarButtonItem!
        button.onTap()
        XCTAssertTrue(answerCallbackCalled)
    }
    
    func test_whenRoutesToResult_shouldPushToResult() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        
        let result = QuizResult.createMock(answer: [QuizQuestion.singleAnswer("Q1") : ["A1"]], score: 10)
        let secondResult = QuizResult.createMock(answer: [QuizQuestion.singleAnswer("Q2") : ["A2"]], score: 20)
        
        factory.stub(result: result, for: viewController)
        factory.stub(result: secondResult, for: secondViewController)
        
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        sut.routeTo(result: result)
        sut.routeTo(result: secondResult)
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    
    
    // MARK: Helpers
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        private var questionsStub: [QuizQuestion<String> : UIViewController] = [:]
        
        var resultStub: [QuizResult<QuizQuestion<String>, [String]> : UIViewController] = [:]
        var answersStub: [QuizQuestion<String> : ([String]) -> Void] = [:]
        
        func stub(question: QuizQuestion<String>, with viewController: UIViewController) {
            questionsStub[question] = viewController
        }
                
        func stub(result: QuizResult<QuizQuestion<String>, [String]>, for viewController: UIViewController) {
            resultStub[result] = viewController
        }
        
        func questionViewController(for question: QuizQuestion<String>, answerCallback: @escaping ([String]) -> Void) -> UIViewController {
            self.answersStub[question] = answerCallback
            return questionsStub[question]!
        }
        
        func resultViewController(for result: QuizResult<QuizQuestion<String>, [String]>) -> UIViewController {
            return resultStub[result]!
        }
    }
}

private extension UIBarButtonItem {
    func onTap() {
        target!.performSelector(onMainThread: action!, with: nil, waitUntilDone: true)
    }
}
