import UIKit
import Kingfisher

protocol UserProfilePresentationLogic {
    func presentData(response: UserProfile.Model.Response)
}

class UserProfilePresenter: UserProfilePresentationLogic {
    weak var viewController: UserProfileDisplayLogic?
    
    func presentData(response: UserProfile.Model.Response) {
        switch response {
        case .presentOwner(let owner):
            viewController?.displayData(viewModel: UserProfile.Model.ViewModel.displayOwner(owner: ownerViewModel(owner)))
        case .presentImages(let images):
            let cells = images.items.map { imagesViewModel($0)}
            let model = UserProfile.ImageViewModel.init(imageUrls: cells)
            viewController?.displayData(viewModel: UserProfile.Model.ViewModel.displayImages(images: model))
        }
    }
    
    func ownerViewModel (_ item: UserItem) -> UserProfile.OwnerViewModel {
        let model = UserProfile.OwnerViewModel.init(fullName: "\(item.firstName) \(item.lastName)",
            photoUrlString: item.photo100)
        return model
    }
    
    func imagesViewModel (_ item: PhotoItem ) -> String {
        let s = item.sizes?.filter { $0.type == "x" }
        guard s?.count != 0 else { return "" }
        guard let u = s?[0].url else { return "" }
        return u
    }
    
}
