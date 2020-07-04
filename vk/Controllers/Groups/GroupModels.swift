import UIKit

enum Group {
    enum Model {
        enum Request {
            case getGroups
            case getOwner(ownerId: String?)
            case searchGroups(searchStr: String?)
        }
        enum Response {
            case presentGroups(groups: ItemsResponseWrapper<GroupItem>.BaseResponse)
            case presentOwner(owner: UserItem)
            case presentSearch(groups: ItemsResponseWrapper<GroupItem>.BaseResponse)
        }
        enum ViewModel {
            case displayGroups(groupViewModel: GroupViewModel)
            case displayOwner(ownerViewModel: OwnerViewModel)
            case displaySearch(groupViewModel: GroupViewModel)
        }
    }
    
    struct GroupViewModel {
        struct Cell {
            var name: String
            var groupId: Int
            var photoUrl: String?
        }
        let cells: [Cell]
    }
    
    struct OwnerViewModel {
        var name: String?
        var photoUrlString: String?
    }
    
}
