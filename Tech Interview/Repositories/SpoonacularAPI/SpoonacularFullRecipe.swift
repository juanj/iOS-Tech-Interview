import Foundation

struct SpoonacularFullRecipe: Decodable, Equatable {
    let id: Int
    let title: String
    let image: URL?
    let summary: String
    let instructions: String
}

extension SpoonacularFullRecipe {
    func toDomainObject() -> Recipe {
        return Recipe(id: id, title: title, summary: summary, instructions: instructions, imageURL: image)
    }
}
