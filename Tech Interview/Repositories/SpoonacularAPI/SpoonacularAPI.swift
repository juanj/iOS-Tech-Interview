import Alamofire
import Foundation

enum SpoonacularAPIError: Error {
    case noData
}

class SpoonacularAPI: RecipeAPI {
    private let baseURL = "https://api.spoonacular.com"
    private let apiKey: String

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func getRecipe(id: Int, completion: @escaping (Result<Recipe, Error>) -> Void) {
        let headers: HTTPHeaders = [
            "x-api-key": apiKey,
        ]

        AF.request("\(baseURL)/recipes/\(id)/information", headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }

            guard let data = response.data else {
                completion(.failure(SpoonacularAPIError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let recipe = try decoder.decode(SpoonacularFullRecipe.self, from: data)
                completion(.success(recipe.toDomainObject()))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func searchRecipes(
        query: String,
        number: Int,
        offset: Int,
        completion: @escaping (Result<[Recipe], Error>) -> Void
    ) {
        let headers: HTTPHeaders = [
            "x-api-key": apiKey,
        ]

        let parameters: [String: Any] = [
            "query": query,
            "number": number,
            "offset": offset,
        ]

        AF.request("\(baseURL)/recipes/complexSearch", parameters: parameters, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
                return
            }

            guard let data = response.data else {
                completion(.failure(SpoonacularAPIError.noData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(SpoonacularAPIPaginatedResponse<SpoonacularMinimalRecipe>.self, from: data)
                completion(.success(response.results.map { $0.toDomainObject() }))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func getRecipes(number: Int, offset: Int, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        searchRecipes(query: "", number: number, offset: offset, completion: completion)
    }
}
