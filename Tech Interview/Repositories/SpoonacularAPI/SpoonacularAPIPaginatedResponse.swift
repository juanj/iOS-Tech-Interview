import Foundation

struct SpoonacularPaginatedResponse<Object: Decodable>: Decodable{
    let number: Int
    let offset: Int
    let results: [Object]
    let totalResults: Int
}
