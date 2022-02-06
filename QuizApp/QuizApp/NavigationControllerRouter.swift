//
//  NavigationControllerRouter.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 06/02/22.
//

import UIKit
import QuizEngineiOS

final class NavigationControllerRouter: Router {
    
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func routeTo(result: QuizResult<String, String>) {

    }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        navigationController.pushViewController(UIViewController(), animated: false)
    }
}
