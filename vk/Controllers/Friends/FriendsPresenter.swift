import UIKit

protocol FriendsPresentationLogic
{
  func presentSomething(response: Friends.Something.Response)
}

class FriendsPresenter: FriendsPresentationLogic
{
  weak var viewController: FriendsDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: Friends.Something.Response)
  {
    let viewModel = Friends.Something.ViewModel()
    viewController?.displaySomething(viewModel: viewModel)
  }
}
