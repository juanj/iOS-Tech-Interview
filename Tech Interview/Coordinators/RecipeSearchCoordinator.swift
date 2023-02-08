import Foundation
import UIKit

class RecipeSearchCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    private let navigation: UINavigationController
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func start() {
        let viewController = UIViewController()
        navigation.setViewControllers([viewController], animated: false)
    }
}
