import UIKit

protocol FriendsBusinessLogic {
    func makeRequest(request: Friends.Model.Request)
}

protocol FriendsDataStore {
    //var name: String { get set }
}

class FriendsInteractor: FriendsBusinessLogic, FriendsDataStore {
    var presenter: FriendsPresentationLogic?
    var worker: FriendsWorker
    
    init() {
        worker = FriendsWorker()
    }
    
    func makeRequest(request: Friends.Model.Request) {
        switch request {
        case .getFriends:
            worker.getFriends(completion: { [weak self] (items) in
                self?.presenter?.presentData(response: Friends.Model.Response.presentFriends(friends: items))
            })
        case .getOwner:
            worker.getOwnerInfo(completion: { [weak self] (owner) in
                self?.presenter?.presentData(response: Friends.Model.Response.presentOwner(owner: owner))
            })
        }
    }
    
}
