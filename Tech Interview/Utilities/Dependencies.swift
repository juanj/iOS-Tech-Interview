import Foundation

class Dependencies: RecipeListCoordinatorDependencies, RecipeSearchCoordinatorDependencies {
    let recipeAPI = SpoonacularAPI(apiKey: "c578c95efb924e278c483a92c215ab5a")
    let cache = InMemoryRecipeCache()
    private(set) lazy var recipeRepository = RecipeRepository(api: recipeAPI, cache: cache)
}
