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
        let viewController = RecipeListTableViewController(
            viewModel: RepositoryRecipeListTableViewModel(repository: dependencies.recipeRepository)
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
