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
    
    func test_whenRoutesToQuestion_shouldGetTheAnswerCallback() {
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

extension QuizResult: Hashable {
    public static func == (lhs: QuizResult<Question, Answer>, rhs: QuizResult<Question, Answer>) -> Bool {
        lhs.score == rhs.score
    }
    
    
    static func createMock(answer: [Question : Answer] = [:], score: Int = 0) -> QuizResult<Question, Answer> {
        .init(answer: answer, score: score)
    }
    
    public var hashValue: Int {
        1
    }
}


