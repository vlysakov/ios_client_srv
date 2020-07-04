import UIKit

enum Friends {
    enum Model {
        enum Request {
            case getFriends
            case getOwner
        }
        enum Response {
            case presentFriends(friends: ItemsResponseWrapper<UserItem>.BaseResponse)
            case presentOwner(owner: UserItem)
        }
        enum ViewModel {
            case displayFriends(friendViewModel: FriendViewModel)
            case displayOwner(owner: UserViewModel)
        }
    }
}

struct UserViewModel {
    var photoUrlString: String?
}

struct FriendViewModel {
    struct Cell {
        var friendId: Int
        var photoUrl: String?
        var fullName: String
    }
    
    let cells: [Cell]
}
