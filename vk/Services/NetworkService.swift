import UIKit
import Alamofire

enum VkApiMethod: String {
    case getFriends         = "friends.get"
    case getPhotos          = "photos.get"
    case getPhotosAlbums    = "photos.getAlbums"
    case getGroups          = "groups.get"
    case searchGroups       = "groups.search"
    case getUsers           = "users.get"
}

class NetworkService {
    static let instance = NetworkService()
    
    static let host = "https://api.vk.com/method/"
    static let vkVersion = "5.110"
    
    private init() {}
    
    public func getMethodUrl (_ method: VkApiMethod) -> String {
        return NetworkService.host + method.rawValue
    }
    
    func request(method: VkApiMethod, params: [String : String], completion: @escaping (Data?, AFError?) -> Void) {
        guard let token = Session.instance.accessToken else { return }
        var p = params
        p["access_token"] = token
        p["v"] = NetworkService.vkVersion
        AF.request(getMethodUrl(method), method: .post, parameters: p).responseJSON { response in
            switch response.result {
            case .success:
                if let json = response.data {
                    completion(json, nil)
                }
            case .failure(let err):
                completion(nil, err)
                print(err)
            }
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
}
