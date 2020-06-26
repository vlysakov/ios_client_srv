import UIKit

protocol UserProfilePresentationLogic {
    func presentData(response: UserProfile.Model.Response)
}

class UserProfilePresenter: UserProfilePresentationLogic {
    weak var viewController: UserProfileDisplayLogic?
    
    func presentData(response: UserProfile.Model.Response) {
        switch response {
        case .presentOwner(let owner):
            viewController?.displayData(viewModel: UserProfile.Model.ViewModel.displayOwner(owner: ownerViewModel(owner)))
        }
    }
    
    func ownerViewModel (_ item: UserItem) -> UserProfile.OwnerViewModel {
        let model = UserProfile.OwnerViewModel.init(fullName: "\(item.firstName) \(item.lastName)",
            photoUrlString: item.photo100)
        return model
    }
    
}
