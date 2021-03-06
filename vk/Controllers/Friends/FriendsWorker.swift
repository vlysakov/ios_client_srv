import UIKit

class FriendsWorker {
    private var fetcher: DataFetcher
    
    init() {
        fetcher = NetworkDataFetcher()
    }
    
    func getFriends(completion: @escaping (ItemsResponseWrapper<UserItem>.BaseResponse) -> Void) {
        fetcher.getFriends(userId: nil, response: { rsp in
            if let respose = rsp?.response {
                completion(respose)
            }
        })
    }
    
    func getOwnerInfo (completion: @escaping (UserItem) -> Void) {
        fetcher.getOwnerInfo(response: { rsp in
            if let ui = rsp {
                completion(ui)
            }
        })
    }
}
