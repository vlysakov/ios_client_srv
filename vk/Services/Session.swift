import Foundation

class Session {
    
    static let instance = Session()
    
    var accessToken: String?
    var expiresIn: String?
    var authDate: Date?
    var userId: String?
    
    var isAuth: Bool {
        guard let ad = authDate, let exp = expiresIn else { return false }
        return Date() < ad.addingTimeInterval(TimeInterval(exp) ?? 0)
    }
    
    public func set (userId: String, accessToken: String, expiresIn: String) {
        self.userId = userId
        self.accessToken = accessToken
        self.expiresIn = expiresIn
        self.authDate = Date()
        let ud = UserDefaults.standard
        ud.set(self.authDate, forKey: "authDate")
        ud.set(self.expiresIn, forKey: "expiresIn")
        ud.set(self.userId, forKey: "user_id")
        ud.set(self.accessToken, forKey: "access_token")
    }
    
    private init() {
        let ud = UserDefaults.standard
        guard let at = ud.string(forKey: "access_token") else { return }
        accessToken = at
        userId = ud.string(forKey: "user_id")
        expiresIn = ud.string(forKey: "user_id")
        authDate = ud.object(forKey: "authDate") as! Date?
    }
   
}
