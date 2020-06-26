
import UIKit

enum UserProfile {
    
    enum Model {
        enum Request {
            case getOwner
        }
        enum Response {
            case presentOwner(owner: UserItem)
        }
        enum ViewModel {
            case displayOwner(owner: OwnerViewModel)
        }
    }
    
    struct OwnerViewModel {
        var fullName: String
        var photoUrlString: String?
    }
    
}


