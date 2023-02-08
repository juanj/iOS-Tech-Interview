@testable import Tech_Interview
import XCTest

class SpoonacularPaginatedResponseTests: XCTestCase {
    func testObjectDecodesCorrectly() throws {
        let decoder = JSONDecoder()

        let object = try decoder.decode(
            SpoonacularPaginatedResponse<SpoonacularMinimalRecipe>.self,
            from: spoonacularComplexSearchJSON.data(using: .utf8)!
        )

        XCTAssertEqual(
            object,
            SpoonacularPaginatedResponse(number: 2, offset: 0, results: [
                SpoonacularMinimalRecipe(
                    id: 782_585,
                    title: "Cannellini Bean and Asparagus Salad with Mushrooms",
                    image: URL(string: "https://spoonacular.com/recipeImages/782585-312x231.jpg")!
                ),
                SpoonacularMinimalRecipe(
                    id: 716_426,
                    title: "Cauliflower, Brown Rice, and Vegetable Fried Rice",
                    image: URL(string: "https://spoonacular.com/recipeImages/716426-312x231.jpg")!
                ),
            ], totalResults: 5221)
        )
    }
}
