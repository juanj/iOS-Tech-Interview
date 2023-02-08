@testable import Tech_Interview
import XCTest

class RecipeAPIMock: RecipeAPI {
    var getRecipeCalled = false
    func getRecipe(id: Int, completion: @escaping (Result<Tech_Interview.Recipe, Error>) -> Void) {
        getRecipeCalled = true
    }

    var searchRecipesCalled = false
    func searchRecipes(query: String, number: Int, offset: Int, completion: @escaping (Result<[Tech_Interview.Recipe], Error>) -> Void) {
        searchRecipesCalled = true
    }

    var getRecipesCalled = false
    func getRecipes(number: Int, offset: Int, completion: @escaping (Result<[Tech_Interview.Recipe], Error>) -> Void) {
        getRecipesCalled = true
    }
}
