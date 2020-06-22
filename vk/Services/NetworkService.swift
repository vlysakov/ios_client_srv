import UIKit
import Alamofire

enum VkApiMethod: String {
    case getFriends         = "friends.get"
    case getPhotos          = "photos.get"
    case getPhotosAlbums    = "photos.getAlbums"
    case getGroups          = "groups.get"
    case searchGroups       = "groups.search"
}

class NetworkService {
    static let instance = NetworkService()
    
    static let host = "https://api.vk.com/method/"
    static let vkVersion = "5.110"
    
    private init() {}
    
    public func getMethodUrl (_ method: VkApiMethod) -> String {
        return NetworkService.host + method.rawValue
    }
    
    func request(method: VkApiMethod, params: [String : String], completion: @escaping (AFDataResponse<Data?>) -> Void) {
        guard let token = Session.instance.accessToken else { return }
        var p = params
        p["access_token"] = token
        p["v"] = NetworkService.vkVersion
        AF.request(getMethodUrl(method), method: .post, parameters: p).response { response in completion(response) }
    }
    
    func printFriends() {
        request(method: .getFriends, params: ["name_case": "nom", "fields": "photo_100"], completion: {r in
            print("printFriends **********************************************************************")
            debugPrint(r)})
    }
    
    func printPhotos() {
        let p = ["owner_id": Session.instance.userId ?? "",
                 "album_id": "wall",
                 "count": "2"]
        NetworkService.instance.request(method: .getPhotos, params: p, completion: {r in
            print("printPhotos **********************************************************************")
            debugPrint(r)})

    }
    
    func printGroups() {
        request(method: .getGroups, params: ["owner_id": Session.instance.userId ?? "", "extended": "1"], completion: {r in
            print("printGroups **********************************************************************")
            debugPrint(r)})
    }
    
    func printSearchGroups(_ str: String) {
        request(method: .searchGroups, params: ["q": str, "count": "3"], completion: {r in
            print("printSearchGroups **********************************************************************")
            debugPrint(r)})
    }
    
}
