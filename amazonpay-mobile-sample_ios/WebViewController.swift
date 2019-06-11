//
//  WebViewController.swift
//  amazonpay-mobile-sample_ios
//
//  Created by Uchiumi, Tetsuo on 2019/06/09.
//

import UIKit
import WebKit
import SafariServices

class WebViewController : UIViewController {
    
    var webView: WKWebView!
    
    @IBOutlet weak var topButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("WebViewController#viewDidLoad")
        
        // WebViewの画面サイズの設定
        var webViewPadding: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            webViewPadding = window!.safeAreaInsets.top
        }
        let webViewHeight = topButton.frame.origin.y - webViewPadding
        let rect = CGRect(x: 0, y: webViewPadding, width: view.frame.size.width, height: webViewHeight)

        // JavaScript側からのCallback受付の設定
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "jsCallbackHandler")
        let webConfig = WKWebViewConfiguration();
        webConfig.userContentController = userContentController
        
        // WebViewの生成、orderページの読み込み
        webView = WKWebView(frame: rect, configuration: webConfig)
        let webUrl = URL(string: "https://localhost:8443/order.html")!
        let myRequest = URLRequest(url: webUrl)
        webView.load(myRequest)
        
        // 生成したWebViewの画面への追加
        self.view.addSubview(webView)
    }
}

extension WebViewController: WKScriptMessageHandler {
    
    // JavaScript側からのCallback. 
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("WebViewController#userContentController")
        switch message.name {
        case "jsCallbackHandler":
            print("jsCallbackHandler")
            if let token = message.body as? String {
                let safariView = SFSafariViewController(url: NSURL(string: "https://localhost:8443/button?token=" + token)! as URL)
                present(safariView, animated: true, completion: nil)
            }
        default:
            return
        }
    }
}
