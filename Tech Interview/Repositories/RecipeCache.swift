import Foundation

protocol RecipeCache {
    func cachedDataForGetRecipe(id: Int) -> Recipe?
    func saveDataForGetRecipe(id: Int, data: Recipe)

    func cachedDataForSearchRecipes(query: String, number: Int, offset: Int) -> [Recipe]?
    func saveDataForSearchRecipes(query: String, number: Int, offset: Int, data: [Recipe])

    func cachedDataForGetRecipes(number: Int, offset: Int) -> [Recipe]?
    func saveDataForGetRecipes(number: Int, offset: Int, data: [Recipe])
}
