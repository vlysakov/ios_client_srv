import Foundation

protocol DataFetcher {
    func getFriends(userId: String?, response: @escaping (ItemsResponseWrapper<UserItem>?) -> Void)
    func getPhotos(userId: String?, response: @escaping (ItemsResponseWrapper<PhotoItem>?) -> Void)
    func getGroups(userId: String?, response: @escaping (ItemsResponseWrapper<GroupItem>?) -> Void)
    func searchGroups(searchStr str: String, response: @escaping (ItemsResponseWrapper<GroupItem>?) -> Void)
    func getOwnerInfo (response: @escaping (UserItem?) -> Void)
}

extension DataFetcher {
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
