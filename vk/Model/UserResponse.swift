import Foundation

struct UserItem: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String?
}
