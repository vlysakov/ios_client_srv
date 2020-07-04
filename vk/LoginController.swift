import UIKit
import WebKit
import Alamofire

class LoginController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var afterSignIn: (() -> ())?
    
    override func loadView() {
        super.loadView()
        self.view = UIView()
        self.view.backgroundColor = .systemBackground
        webView = WKWebView()
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        webView.fillSuperview()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.load(loginRequest())
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    private func loginRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
//            URLQueryItem(name: "client_id", value: "7506747"),
            URLQueryItem(name: "client_id", value: "7522714"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.110")
        ]
        return URLRequest(url: urlComponents.url!)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if webView.estimatedProgress == 1.0 {
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            print("error")
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        guard let userId = params["user_id"], let accessToken = params["access_token"], let expiresIn = params["expires_in"] else {
            decisionHandler(.cancel)
            return
        }
        Session.instance.set(userId: userId, accessToken: accessToken, expiresIn: expiresIn)
        decisionHandler(.cancel)
        afterSignIn?()
    }

}

