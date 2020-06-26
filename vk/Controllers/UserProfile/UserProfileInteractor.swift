import UIKit

protocol UserProfileBusinessLogic {
    func makeRequest(request: UserProfile.Model.Request)
}

protocol UserProfileDataStore {
    //var name: String { get set }
}

class UserProfileInteractor: UserProfileBusinessLogic, UserProfileDataStore {
    var presenter: UserProfilePresentationLogic?
    var worker: UserProfileWorker
    
    init() {
        worker = UserProfileWorker()
    }
    
    func makeRequest(request: UserProfile.Model.Request) {
        switch request {
        case .getOwner:
            worker.getOwnerInfo(completion: { [weak self] (owner) in
                self?.presenter?.presentData(response: UserProfile.Model.Response.presentOwner(owner: owner))
            })
        case .getImages:
            worker.getImages(completion: { [weak self] (images) in
                self?.presenter?.presentData(response: UserProfile.Model.Response.presentImages(images: images))
            })
        }
        
    }
    
}
