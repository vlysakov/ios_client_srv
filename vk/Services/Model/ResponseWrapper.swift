import Foundation

struct ItemsResponseWrapper<T: Decodable>: Decodable {
    struct BaseResponse: Decodable {
        var items: [T]
    }
    var response: BaseResponse
}

struct BaseResponseWrapper<T: Decodable>: Decodable {
    var response: T
}

