import Foundation

class RepositoryRecipeListTableViewModel: RecipeListTableViewModel {
    private enum Constants {
        static let recipesPerPage = 20
    }

    var didChange: () -> Void = {}
    var showError: (String) -> Void = { _ in }
    private(set) var recipes = [Recipe]()
    private var loading = false

    private let repository: RecipeRepository
    init(repository: RecipeRepository) {
        self.repository = repository
        loadPage()
    }

    func willShow(index: Int) {
        if recipes.count - index <= 5 {
            loadPage()
        }
    }

    private func loadPage() {
        guard !loading else { return }
        loading = true
        repository.fetchRecipes(number: Constants.recipesPerPage, offset: recipes.count) { [weak self] result in
            switch result {
            case let .success(data):
                self?.recipes.append(contentsOf: data)
                self?.didChange()
            case let .failure(error):
                self?.showError(error.localizedDescription)
            }
            self?.loading = false
        }
    }
}
