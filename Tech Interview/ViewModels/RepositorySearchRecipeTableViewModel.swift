import Foundation

class RepositorySearchRecipeTableViewModel: SearchRecipeTableViewModel {
    private enum Constants {
        static let recipesPerPage = 20
    }

    var didChange: () -> Void = {}
    var showError: (String) -> Void = { _ in }
    private(set) var results = [Recipe]()
    private var currentSearch = ""
    private var loading = false

    private let repository: RecipeRepository
    init(repository: RecipeRepository) {
        self.repository = repository
    }

    func willShow(index: Int) {
        if results.count - index <= 5 {
            loadPage()
        }
    }

    private func loadPage() {
        guard !loading else { return }
        loading = true
        repository.searchRecipes(query: currentSearch, number: Constants.recipesPerPage, offset: results.count) { [weak self] result in
            switch result {
            case let .success(data):
                self?.results.append(contentsOf: data)
                self?.didChange()
            case let .failure(error):
                self?.showError(error.localizedDescription)
            }
            self?.loading = false
        }
    }

    func didChangeSearch(newSearch: String) {
        currentSearch = newSearch
        guard !currentSearch.isEmpty else {
            results = []
            didChange()
            return
        }
        repository.searchRecipes(query: newSearch, number: Constants.recipesPerPage, offset: 0) { [weak self] result in
            switch result {
            case let .success(data):
                self?.results = data
                self?.didChange()
            case let .failure(error):
                self?.showError(error.localizedDescription)
            }
        }
    }
}
