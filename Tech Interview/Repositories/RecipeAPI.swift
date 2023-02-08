import Foundation

protocol RecipeAPI {
    func getRecipe(id: Int, completion: @escaping (Result<Recipe, Error>) -> Void)
    func searchRecipes(query: String, number: Int, offset: Int, completion: @escaping (Result<[Recipe], Error>) -> Void)
    func getRecipes(number: Int, offset: Int, completion: @escaping (Result<[Recipe], Error>) -> Void)
}
