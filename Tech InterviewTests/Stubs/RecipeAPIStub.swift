@testable import Tech_Interview
import XCTest

struct RecipeAPIStub: RecipeAPI {
    func getRecipe(id: Int, completion: @escaping (Result<Tech_Interview.Recipe, Error>) -> Void) {
        completion(.success(Recipe(id: 0, title: "", summary: "", instructions: "", imageURL: nil)))
    }

    func searchRecipes(query: String, number: Int, offset: Int, completion: @escaping (Result<[Tech_Interview.Recipe], Error>) -> Void) {
        completion(.success([Recipe(id: 0, title: "", summary: "", instructions: "", imageURL: nil)]))
    }

    func getRecipes(number: Int, offset: Int, completion: @escaping (Result<[Tech_Interview.Recipe], Error>) -> Void) {
        completion(.success([Recipe(id: 0, title: "", summary: "", instructions: "", imageURL: nil)]))
    }
}
