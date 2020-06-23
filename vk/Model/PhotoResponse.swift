import Foundation

struct PhotoItem: Decodable {
    struct PhotoSize: Decodable {
        let height: Int
        let width: Int
        let url: String
        let type: String
    }
    
    let id: Int
    let text: String?
    let likes: CountableItem?
    let reposts: CountableItem?
    let comments: CountableItem?
    let sizes: [PhotoSize]?
}


