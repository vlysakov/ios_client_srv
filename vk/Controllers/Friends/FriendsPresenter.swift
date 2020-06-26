import UIKit

protocol FriendsPresentationLogic {
    func presentData(response: Friends.Model.Response)
}

class FriendsPresenter: FriendsPresentationLogic {
    weak var viewController: FriendsDisplayLogic?
    
    func presentData(response: Friends.Model.Response) {
        switch response {
        case .presentFriends(let friends):
            let cells = friends.items.map { cellViewModel(from: $0) }
            let model = FriendViewModel.init(cells: cells)
            viewController?.displayData(viewModel: Friends.Model.ViewModel.displayFriends(friendViewModel: model))
        case .presentOwner(let owner):
            let model = UserViewModel.init(photoUrlString: owner.photo50)
            viewController?.displayData(viewModel: Friends.Model.ViewModel.displayOwner(owner: model))
        }
    }
    
    private func cellViewModel (from item: UserItem) -> FriendViewModel.Cell {
        return FriendViewModel.Cell.init(friendId: item.id, photoUrl: item.photo100, fullName: item.firstName + " " + item.lastName)
    }
}
