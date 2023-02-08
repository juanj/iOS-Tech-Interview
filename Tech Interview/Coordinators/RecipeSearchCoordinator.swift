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
        let viewController = SearchRecipeTableViewController(
            viewModel: RepositorySearchRecipeTableViewModel(repository: dependencies.recipeRepository)
        )

        viewController.didSelectRecipe = { [weak self] recipe in
            guard let self else { return }
            self.navigation.pushViewController(
                RecipeDetailViewController(viewModel: RepositoryRecipeDetailViewModel(
                    recipe: recipe,
                    repository: self.dependencies.recipeRepository
                )),
                animated: true
            )
        }

        navigation.setViewControllers([viewController], animated: false)
    }
}
