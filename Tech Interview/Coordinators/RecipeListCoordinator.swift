import Foundation
import UIKit

protocol RecipeListCoordinatorDependencies {
    var recipeRepository: RecipeRepository { get }
}

class RecipeListCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    private let navigation: UINavigationController
    private let dependencies: RecipeListCoordinatorDependencies
    init(navigation: UINavigationController, dependencies: RecipeListCoordinatorDependencies) {
        self.navigation = navigation
        self.dependencies = dependencies
    }

    func start() {
        let viewController =
            RecipeListTableViewController(
                viewModel: RepositoryRecipeListTableViewModel(repository: dependencies.recipeRepository)
            )
        navigation.setViewControllers([viewController], animated: false)
    }
}
