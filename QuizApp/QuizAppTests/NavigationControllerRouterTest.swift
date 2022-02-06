//
//  NavigationControllerRouterTest.swift
//  QuizAppTests
//
//  Created by Tifo Audi Alif Putra on 06/02/22.
//

import UIKit
import QuizEngineiOS
import XCTest
@testable import QuizApp

class NavigationControllerRouterTest: XCTestCase {
    
    let navigationController = NonAnimatedNavigationController()
    let factory = ViewControllerFactoryStub()
    
    func test_whenRoutesToQuestion_shouldPushToCorrectViewController() {
        let viewController = UIViewController()
        let secondViewController = UIViewController()
        
        factory.stub(question: "Q1", with: viewController)
        factory.stub(question: "Q2", with: secondViewController)
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        sut.routeTo(question: "Q2", answerCallback: { _ in })
        
        XCTAssertEqual(navigationController.viewControllers.count, 2)
        XCTAssertEqual(navigationController.viewControllers.first, viewController)
        XCTAssertEqual(navigationController.viewControllers.last, secondViewController)
    }
    
    func test_whenRoutesToQuestion_shouldGetTheAnswerCallback() {
        let viewController = UIViewController()
        
        factory.stub(question: "Q1", with: viewController)
        let sut = NavigationControllerRouter(navigationController, factory: factory)
        
        var answerCallbackCalled = false
        var receivedAnswer = ""
        
        sut.routeTo(question: "Q1", answerCallback: { answer in
            receivedAnswer = answer
            answerCallbackCalled = true
        })
        
        factory.answersStub["Q1"]!("A1")
        
        XCTAssertTrue(answerCallbackCalled)
        XCTAssertEqual(receivedAnswer, "A1")
    }
    
    
    
    // MARK: Helpers
    
    class NonAnimatedNavigationController: UINavigationController {
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: false)
        }
    }
    
    class ViewControllerFactoryStub: ViewControllerFactory {
        private var questionsStub: [String : UIViewController] = [:]
        var answersStub: [String : (String) -> Void] = [:]
        
        func stub(question: String, with viewController: UIViewController) {
            questionsStub[question] = viewController
        }
        
        func questionViewController(for question: String, answerCallback: @escaping (String) -> Void) -> UIViewController {
            self.answersStub[question] = answerCallback
            return questionsStub[question]!
        }
    }
}
