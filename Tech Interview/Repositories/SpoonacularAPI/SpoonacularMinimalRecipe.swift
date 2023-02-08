import Foundation

struct SpoonacularMinimalRecipe: Decodable, Equatable {
    let id: Int
    let title: String
    let image: URL?
}

extension SpoonacularMinimalRecipe {
    func toDomainObject() -> Recipe {
        return Recipe(id: id, title: title, summary: "", instructions: "", imageURL: image)
    }
}
