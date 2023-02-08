import Foundation

class RepositoryRecipeListTableViewModel: RecipeListTableViewModel {
    var didChange: () -> Void = {}
    var showError: (String) -> Void = { _ in }
    private(set) var recipes = [Recipe]()

    private let repository: RecipeRepository
    init(repository: RecipeRepository) {
        self.repository = repository
        repository.fetchRecipes(number: 10, offset: 0) { [weak self] result in
            switch result {
            case let .success(data):
                self?.recipes.append(contentsOf: data)
                self?.didChange()
            case let .failure(error):
                self?.showError(error.localizedDescription)
            }
        }
    }
}
