import UIKit

protocol GroupPresentationLogic {
    func presentData(response: Group.Model.Response)
}

class GroupPresenter: GroupPresentationLogic {
    weak var viewController: GroupDisplayLogic?
    
    func presentData(response: Group.Model.Response) {
        switch response {
        case .presentGroups(let groups):
            let cells = groups.items.map { groupViewModel($0) }
            let model = Group.GroupViewModel.init(cells: cells)
            viewController?.displayData(viewModel: Group.Model.ViewModel.displayGroups(groupViewModel: model))
        case .presentOwner(let owner):
            let model = Group.OwnerViewModel.init(name: owner.firstName + " " + owner.lastName, photoUrlString: owner.photo100)
            viewController?.displayData(viewModel: Group.Model.ViewModel.displayOwner(ownerViewModel: model))
        case .presentSearch(let groups):
            let cells = groups.items.map { groupViewModel($0) }
            let model = Group.GroupViewModel.init(cells: cells)
            viewController?.displayData(viewModel: Group.Model.ViewModel.displaySearch(groupViewModel: model))
        }
    }
    
    private func groupViewModel (_ item: GroupItem) -> Group.GroupViewModel.Cell {
        return Group.GroupViewModel.Cell.init(name: item.name, groupId: item.id, photoUrl: item.photo100)
    }
}
