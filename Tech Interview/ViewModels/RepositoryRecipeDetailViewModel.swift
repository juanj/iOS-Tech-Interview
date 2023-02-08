import Foundation

class RepositoryRecipeDetailViewModel: RecipeDetailViewModel {
    var didChange: () -> Void = {}
    var showError: (String) -> Void = { _ in }
    var title: String { recipe.title }
    var headerImageURL: URL? { recipe.imageURL }
    var summary: String { recipe.summary }
    var instructions: String { recipe.instructions }

    private var recipe: Recipe
    private let repository: RecipeRepository
    init(recipe: Recipe, repository: RecipeRepository) {
        self.recipe = recipe
        self.repository = repository

        repository.fetchRecipe(id: recipe.id) { [weak self] result in
            switch result {
            case let .success(data):
                self?.recipe = data
                self?.didChange()
            case let .failure(error):
                self?.showError(error.localizedDescription)
            }
        }
    }
}
