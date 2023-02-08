import Foundation

struct SpoonacularPaginatedResponse<Object: Decodable & Equatable>: Decodable, Equatable {
    let number: Int
    let offset: Int
    let results: [Object]
    let totalResults: Int
}
