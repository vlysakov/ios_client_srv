import UIKit

class UserProfileWorker {
    private var fetcher: DataFetcher
    
    init() {
        fetcher = NetworkDataFetcher()
    }
    
    func getOwnerInfo (completion: @escaping (UserItem) -> Void) {
        fetcher.getOwnerInfo(response: { rsp in
            if let ui = rsp {
                completion(ui)
            }
        })
    }
}
