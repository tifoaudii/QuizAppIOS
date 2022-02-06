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
    
    func test_whenRoutesToQuestion_shouldPushQuestionController() {
        let navigationController = UINavigationController()
        let sut = NavigationControllerRouter(navigationController)
        
        sut.routeTo(question: "Q1", answerCallback: { _ in })
        XCTAssertEqual(navigationController.viewControllers.count, 1)
    }
}
