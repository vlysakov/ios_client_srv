import UIKit

protocol FriendsBusinessLogic
{
  func doSomething(request: Friends.Something.Request)
}

protocol FriendsDataStore
{
  //var name: String { get set }
}

class FriendsInteractor: FriendsBusinessLogic, FriendsDataStore
{
  var presenter: FriendsPresentationLogic?
  var worker: FriendsWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: Friends.Something.Request)
  {
    worker = FriendsWorker()
    worker?.doSomeWork()
    
    let response = Friends.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
