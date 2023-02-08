import Foundation
import UIKit

protocol RecipeSearchCoordinatorDependencies {
    var recipeRepository: RecipeRepository { get }
}

class RecipeSearchCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()

    private let navigation: UINavigationController
    private let dependencies: RecipeSearchCoordinatorDependencies
    init(navigation: UINavigationController, dependencies: RecipeSearchCoordinatorDependencies) {
        self.navigation = navigation
        self.dependencies = dependencies
    }

    func start() {
        let viewController =
            SearchRecipeTableViewController(
                viewModel: RepositorySearchRecipeTableViewModel(repository: dependencies.recipeRepository)
            )
        navigation.setViewControllers([viewController], animated: false)
    }
}
