import Foundation

class RecipeRepository {
    private let api: RecipeAPI
    private let cache: RecipeCache

    init(api: RecipeAPI, cache: RecipeCache) {
        self.api = api
        self.cache = cache
    }

    func fetchRecipe(id: Int, completion: @escaping (Result<Recipe, Error>) -> Void) {
        if let cachedData = cache.cachedDataForGetRecipe(id: id) {
            completion(.success(cachedData))
            return
        }

        api.getRecipe(id: id) { [weak self] result in
            guard let self else { return }
            if case let .success(data) = result {
                self.cache.saveDataForGetRecipe(id: id, data: data)
            }
            completion(result)
        }
    }

    func searchRecipes(
        query: String,
        number: Int,
        offset: Int,
        completion: @escaping (Result<[Recipe], Error>) -> Void
    ) {
        if let cachedData = cache.cachedDataForSearchRecipes(query: query, number: number, offset: offset) {
            completion(.success(cachedData))
            return
        }

        api.searchRecipes(query: query, number: number, offset: offset) { [weak self] result in
            guard let self else { return }
            if case let .success(data) = result {
                self.cache.saveDataForSearchRecipes(query: query, number: number, offset: offset, data: data)
            }
            completion(result)
        }
    }

    func fetchRecipes(number: Int, offset: Int, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        if let cachedData = cache.cachedDataForGetRecipes(number: number, offset: offset) {
            completion(.success(cachedData))
            return
        }

        api.getRecipes(number: number, offset: offset) { [weak self] result in
            guard let self else { return }
            if case let .success(data) = result {
                self.cache.saveDataForGetRecipes(number: number, offset: offset, data: data)
            }
            completion(result)
        }
    }
}
