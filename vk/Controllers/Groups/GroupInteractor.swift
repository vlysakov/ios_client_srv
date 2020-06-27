import UIKit

protocol GroupBusinessLogic {
    func makeRequest(request: Group.Model.Request)
}

protocol GroupDataStore {
    //var name: String { get set }
}

class GroupInteractor: GroupBusinessLogic, GroupDataStore {
    var presenter: GroupPresentationLogic?
    var worker: GroupWorker
    
    init() {
        worker = GroupWorker()
    }
    
    func makeRequest(request: Group.Model.Request) {
        switch request {
        case .getGroups:
            worker.getGroups(completion: { [weak self] (items) in
                self?.presenter?.presentData(response: Group.Model.Response.presentGroups(groups: items))
            })
        case .getOwner:
            worker.getOwnerInfo(completion: { [weak self] (owner) in
                self?.presenter?.presentData(response: Group.Model.Response.presentOwner(owner: owner))
            })
        }
    }
}
