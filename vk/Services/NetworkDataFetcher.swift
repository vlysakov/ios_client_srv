import Foundation

class NetworkDataFetcher: DataFetcher {
    
    private let service: NetworkService = NetworkService.instance
    
    func getFriends(userId: String?, response: @escaping (ItemsResponseWrapper<UserItem>?) -> Void) {
        var params = ["name_case": "nom", "fields": "has_photo, photo_50, photo_100, photo_max, online, status, last_seen"]
        if let id = Session.instance.userId {
            params["user_id"] = id
        }
        service.request(method: .getFriends, params: params, completion: {r, _ in
            let decoded = self.decodeJSON(type: ItemsResponseWrapper<UserItem>.self, from: r)
            response(decoded)
        })
    }
    
    func getOwnerInfo (response: @escaping (UserItem?) -> Void) {
        service.request(method: .getUsers, params: ["fields": "has_photo, photo_50, photo_100, photo_max, online, status, last_seen"], completion: {r, _ in
            let decoded = self.decodeJSON(type: BaseResponseWrapper<[UserItem]>.self, from: r)
            guard let rsp = decoded?.response else { return }
                guard rsp.count > 0 else { return }
                response(decoded?.response[0])
        })
    }
    
    func getPhotos(userId: String?, response: @escaping (ItemsResponseWrapper<PhotoItem>?) -> Void) {
        let params = ["owner_id": userId ?? (Session.instance.userId ?? ""),
                 "album_id": "wall"]
        service.request(method: .getPhotos, params: params, completion: {r, _ in
            let decoded = self.decodeJSON(type: ItemsResponseWrapper<PhotoItem>.self, from: r)
            response(decoded)
        })
    }
    
}
