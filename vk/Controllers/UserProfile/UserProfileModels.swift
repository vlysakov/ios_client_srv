
import UIKit

enum UserProfile {
    
    enum Model {
        enum Request {
            case getOwner
            case getImages
        }
        enum Response {
            case presentOwner(owner: UserItem)
            case presentImages(images: ItemsResponseWrapper<PhotoItem>.BaseResponse)
        }
        enum ViewModel {
            case displayOwner(owner: OwnerViewModel)
            case displayImages(images: ImageViewModel)
        }
    }
    
    struct OwnerViewModel {
        var fullName: String
        var photoUrlString: String?
    }
    
    struct ImageViewModel {
        var imageUrls: [String]
    }
    
}


