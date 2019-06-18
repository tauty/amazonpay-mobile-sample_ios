//
//  ThanksController.swift
//  amazonpay-mobile-sample_ios
//
//  Created by Uchiumi, Tetsuo on 2019/06/09.
//

import UIKit
import WebKit

class ThanksController : UIViewController {
    
    var token:String?
    var webView: WKWebView!

    @IBOutlet weak var thanksLabel: UILabel!
    @IBOutlet weak var topButton: UIButton!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ThanksController#viewDidAppear")
        print(token!)

        if webView == nil {
            //　画面サイズを指定してWebViewを生成
            let webViewPadding = thanksLabel.frame.origin.y + thanksLabel.frame.size.height
            let webViewHeight = topButton.frame.origin.y - webViewPadding
            let rect = CGRect(x: 0, y: webViewPadding, width: view.frame.size.width, height: webViewHeight)
            let webConfig = WKWebViewConfiguration();
            webView = WKWebView(frame: rect, configuration: webConfig)
            
            // Thenks画面を開く
            let webUrl = URL(string: Config.shared.baseUrl + "thanks?token=" + token!)!
            var myRequest = URLRequest(url: webUrl)
            myRequest.httpMethod = "POST"
            // myRequest.httpBody = ("token=" + token!).data(using: .utf8)! // Note: WKWebViewにはbodyが消えてしまうバグがあるらしいので、URLパラメータで指定。
            webView.load(myRequest)
            
            self.view.addSubview(webView)
        }
    }
}
