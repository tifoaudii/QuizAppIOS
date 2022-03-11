//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Tifo Audi Alif Putra on 01/02/22.
//

import UIKit
import QuizEngineiOS

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        let singleAnswerQuestion = QuizQuestion.singleAnswer("Where is rendang come from?")
        let multipleAnswerQuestion = QuizQuestion.multipleAnswer("Select food from Indonesia")
        
        let factory = IOSViewControllerFactory(
            questions: [singleAnswerQuestion, multipleAnswerQuestion],
            options: [singleAnswerQuestion : ["Bali", "Padang", "Jawa"], multipleAnswerQuestion : ["Sushi", "Sate", "Bakso"]], correctAnswers: [singleAnswerQuestion : ["Padang"], multipleAnswerQuestion : ["Sate", "Bakso"]])
        
        let router = NavigationControllerRouter(navigationController, factory: factory)
        let quizCoordinator = QuizCoordinator(
            questions: [singleAnswerQuestion, multipleAnswerQuestion],
            router: router,
            correctAnswers: [singleAnswerQuestion : ["Padang"], multipleAnswerQuestion : ["Sate", "Bakso"]]
        )
        
        quizCoordinator.startQuiz()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

