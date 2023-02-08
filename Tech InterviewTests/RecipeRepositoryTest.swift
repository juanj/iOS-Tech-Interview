@testable import Tech_Interview
import XCTest

class RecipeRepositoryTests: XCTestCase {
    func testFetchRecipe_callsAPI_ifCacheIsEmpty() {
        let mockAPI = RecipeAPIMock()
        let repository = RecipeRepository(api: mockAPI, cache: RecipeCacheStub(empty: true))

        repository.fetchRecipe(id: 1) { _ in }

        XCTAssertTrue(mockAPI.getRecipeCalled)
    }

    func testFetchRecipe_savesToCache() {
        let mockCache = RecipeCacheMock()
        let repository = RecipeRepository(api: RecipeAPIStub(), cache: mockCache)

        repository.fetchRecipe(id: 1) { _ in }

        XCTAssertTrue(mockCache.saveDataForGetRecipeCalled)
    }

    func testFetchRecipe_doesNotCallsAPI_ifCacheHasData() {
        let mockAPI = RecipeAPIMock()
        let repository = RecipeRepository(api: mockAPI, cache: RecipeCacheStub(empty: false))

        repository.fetchRecipe(id: 1) { _ in }

        XCTAssertFalse(mockAPI.getRecipeCalled)
    }

    func testSearchRecipes_callsAPI_ifCacheIsEmpty() {
        let mockAPI = RecipeAPIMock()
        let repository = RecipeRepository(api: mockAPI, cache: RecipeCacheStub(empty: true))

        repository.searchRecipes(query: "apple", number: 1, offset: 0) { _ in }

        XCTAssertTrue(mockAPI.searchRecipesCalled)
    }

    func testSearchRecipes_savesToCache() {
        let mockCache = RecipeCacheMock()
        let repository = RecipeRepository(api: RecipeAPIStub(), cache: mockCache)

        repository.searchRecipes(query: "apple", number: 1, offset: 0) { _ in }

        XCTAssertTrue(mockCache.saveDataForSearchRecipesCalled)
    }

    func testSearchRecipes_doesNotCallsAPI_ifCacheHasData() {
        let mockAPI = RecipeAPIMock()
        let repository = RecipeRepository(api: mockAPI, cache: RecipeCacheStub(empty: false))

        repository.searchRecipes(query: "apple", number: 1, offset: 0) { _ in }

        XCTAssertFalse(mockAPI.searchRecipesCalled)
    }

    func testFetchRecipes_callsAPI_ifCacheIsEmpty() {
        let mockAPI = RecipeAPIMock()
        let repository = RecipeRepository(api: mockAPI, cache: RecipeCacheStub(empty: true))

        repository.fetchRecipes(number: 1, offset: 0) { _ in }

        XCTAssertTrue(mockAPI.getRecipesCalled)
    }

    func testFetchRecipes_savesToCache() {
        let mockCache = RecipeCacheMock()
        let repository = RecipeRepository(api: RecipeAPIStub(), cache: mockCache)

        repository.fetchRecipes(number: 1, offset: 0) { _ in }

        XCTAssertTrue(mockCache.saveDataForGetRecipesCalled)
    }

    func testFetchRecipes_doesNotCallsAPI_ifCacheHasData() {
        let mockAPI = RecipeAPIMock()
        let repository = RecipeRepository(api: mockAPI, cache: RecipeCacheStub(empty: false))

        repository.fetchRecipes(number: 1, offset: 0) { _ in }

        XCTAssertFalse(mockAPI.getRecipesCalled)
    }
}
