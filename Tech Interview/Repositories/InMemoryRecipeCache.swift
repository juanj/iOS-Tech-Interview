import Foundation

class InMemoryRecipeCache: RecipeCache {
    private struct SearchRecipesKey: Hashable, Equatable {
        let query: String
        let number: Int
        let offset: Int
    }

    private struct GetRecipesKey: Hashable, Equatable {
        let number: Int
        let offset: Int
    }

    private var cachedGetRecipe = [Int: Recipe]()
    private var cachedSearchRecipe = [SearchRecipesKey: [Recipe]]()
    private var cachedGetRecipes = [GetRecipesKey: [Recipe]]()

    func cachedDataForGetRecipe(id: Int) -> Recipe? {
        return cachedGetRecipe[id]
    }

    func saveDataForGetRecipe(id: Int, data: Recipe) {
        cachedGetRecipe[id] = data
    }

    func cachedDataForSearchRecipes(query: String, number: Int, offset: Int) -> [Recipe]? {
        return cachedSearchRecipe[SearchRecipesKey(query: query, number: number, offset: offset)]
    }

    func saveDataForSearchRecipes(query: String, number: Int, offset: Int, data: [Recipe]) {
        cachedSearchRecipe[SearchRecipesKey(query: query, number: number, offset: offset)] = data
    }

    func cachedDataForGetRecipes(number: Int, offset: Int) -> [Recipe]? {
        return cachedGetRecipes[GetRecipesKey(number: number, offset: offset)]
    }

    func saveDataForGetRecipes(number: Int, offset: Int, data: [Recipe]) {
        cachedGetRecipes[GetRecipesKey(number: number, offset: offset)] = data
    }
}
