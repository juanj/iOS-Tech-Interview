@testable import Tech_Interview

class RecipeCacheMock: RecipeCache {
    var cachedDataForGetRecipeCalled = false
    func cachedDataForGetRecipe(id _: Int) -> Tech_Interview.Recipe? {
        cachedDataForGetRecipeCalled = true
        return nil
    }

    var saveDataForGetRecipeCalled = false
    func saveDataForGetRecipe(id _: Int, data _: Tech_Interview.Recipe) {
        saveDataForGetRecipeCalled = true
    }

    var cachedDataForSearchRecipesCalled = false
    func cachedDataForSearchRecipes(
        query _: String,
        number _: Int,
        offset _: Int
    ) -> [Tech_Interview.Recipe]? {
        cachedDataForSearchRecipesCalled = true
        return nil
    }

    var saveDataForSearchRecipesCalled = false
    func saveDataForSearchRecipes(query _: String, number _: Int, offset _: Int, data _: [Tech_Interview.Recipe]) {
        saveDataForSearchRecipesCalled = true
    }

    var cachedDataForGetRecipesCalled = false
    func cachedDataForGetRecipes(number _: Int, offset _: Int) -> [Tech_Interview.Recipe]? {
        cachedDataForGetRecipesCalled = true
        return nil
    }

    var saveDataForGetRecipesCalled = false
    func saveDataForGetRecipes(number _: Int, offset _: Int, data _: [Tech_Interview.Recipe]) {
        saveDataForGetRecipesCalled = true
    }
}
