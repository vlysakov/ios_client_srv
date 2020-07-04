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
    
    func getImages(completion: @escaping (ItemsResponseWrapper<PhotoItem>.BaseResponse) -> Void) {
        fetcher.getPhotos(userId: nil, response: { rsp in
            if let respose = rsp?.response {
                completion(respose)
            }
        })
    }
    
}
