import UIKit

class GroupWorker {
    private var fetcher: DataFetcher
    
    init() {
        fetcher = NetworkDataFetcher()
    }
    
    func getGroups(completion: @escaping (ItemsResponseWrapper<GroupItem>.BaseResponse) -> Void) {
        fetcher.getGroups(userId: nil, response: { rsp in
            if let respose = rsp?.response {
                completion(respose)
            }
        })
    }
    
    func searchGroups(_ searchStr: String?, completion: @escaping (ItemsResponseWrapper<GroupItem>.BaseResponse) -> Void) {
        guard let str = searchStr else { return }
        fetcher.searchGroups(searchStr: str, response: { rsp in
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
