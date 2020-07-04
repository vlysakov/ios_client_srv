import Foundation

class Session {
    
    static let instance = Session()
    
    var accessToken: String?
    var expiresIn: String?
    var userId: String?
    
    private init() {}
}
