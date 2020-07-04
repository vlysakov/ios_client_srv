import UIKit
import WebKit

class LoginController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    
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
    }
    
    private func loginRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7506747"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
        ]
        return URLRequest(url: urlComponents.url!)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
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
        Session.instance.accessToken = params["access_token"]
        Session.instance.expiresIn = params["expires_in"]
        Session.instance.userId = params["user_id"]
        decisionHandler(.cancel)
    }


}

