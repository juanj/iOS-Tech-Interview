import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    private var tabBarController = UITabBarController()

    private var window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        window.rootViewController = tabBarController

        let rootListNavigation = UINavigationController()
        let rootSearchNavigation = UINavigationController()
        tabBarController.setViewControllers(
            [rootListNavigation, rootSearchNavigation],
            animated: false
        )

        configureAndStartRecipeListCoordinator(navigation: rootListNavigation)
        configureAndStartRecipeSearchCoordinator(navigation: rootSearchNavigation)

        window.makeKeyAndVisible()
    }

    private func configureAndStartRecipeListCoordinator(navigation _: UINavigationController) {}

    private func configureAndStartRecipeSearchCoordinator(navigation _: UINavigationController) {}
}
