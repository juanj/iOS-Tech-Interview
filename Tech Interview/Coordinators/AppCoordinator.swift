import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private var tabBarController = UITabBarController()
    private let dependencies = Dependencies()

    private var window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        showSplash()
        preloadApp()
    }

    private func showSplash() {
        window.rootViewController = SplashViewController()
        window.makeKeyAndVisible()
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            self.showApp()
        }
    }

    private func preloadApp() {
        let rootListNavigation = UINavigationController()
        let rootSearchNavigation = UINavigationController()
        tabBarController.setViewControllers(
            [rootListNavigation, rootSearchNavigation],
            animated: false
        )

        configureAndStartRecipeListCoordinator(navigation: rootListNavigation)
        configureAndStartRecipeSearchCoordinator(navigation: rootSearchNavigation)

        _ = tabBarController.view
    }

    private func showApp() {
        window.rootViewController = tabBarController
    }

    private func configureAndStartRecipeListCoordinator(navigation: UINavigationController) {
        let coordinator = RecipeListCoordinator(navigation: navigation, dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
    }

    private func configureAndStartRecipeSearchCoordinator(navigation: UINavigationController) {
        let coordinator = RecipeSearchCoordinator(navigation: navigation, dependencies: dependencies)
        childCoordinators.append(coordinator)
        coordinator.start()
    }
}
