import Foundation

enum RequesterError: Error {
    case requestError(localizedDescription: String)
    case unknownError
    case parseError(localizedDescription: String)
    case invalidURL
}
