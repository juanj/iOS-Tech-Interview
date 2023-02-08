@testable import Tech_Interview

struct RecipeCacheStub: RecipeCache {
    private let empty: Bool

    init(empty: Bool) {
        self.empty = empty
    }

    func cachedDataForGetRecipe(id _: Int) -> Tech_Interview.Recipe? {
        if empty {
            return nil
        }
        return Recipe(id: 0, title: "", summary: "", instructions: "", imageURL: nil)
    }

    func saveDataForGetRecipe(id _: Int, data _: Tech_Interview.Recipe) {}

    func cachedDataForSearchRecipes(
        query _: String,
        number _: Int,
        offset _: Int
    ) -> [Tech_Interview.Recipe]? {
        if empty {
            return nil
        }
        return [Recipe(id: 0, title: "", summary: "", instructions: "", imageURL: nil)]
    }

    func saveDataForSearchRecipes(query _: String, number _: Int, offset _: Int, data _: [Tech_Interview.Recipe]) {}

    func cachedDataForGetRecipes(number _: Int, offset _: Int) -> [Tech_Interview.Recipe]? {
        if empty {
            return nil
        }
        return [Recipe(id: 0, title: "", summary: "", instructions: "", imageURL: nil)]
    }

    func saveDataForGetRecipes(number _: Int, offset _: Int, data _: [Tech_Interview.Recipe]) {}
}
