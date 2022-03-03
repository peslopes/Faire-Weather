import Foundation

protocol DecoderContract: AnyObject {
    func decode<T: Decodable>(data: Data) throws -> T
}

final class Decoder: DecoderContract {
    func decode<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}
