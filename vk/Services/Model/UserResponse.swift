import Foundation

struct UserItem: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let hasPhoto: Int
    let photo100: String?
    let photo50: String?
    let photo_max: String?
    let online: Int
    let status: String?
    let lastSeen: Timestamp
}
