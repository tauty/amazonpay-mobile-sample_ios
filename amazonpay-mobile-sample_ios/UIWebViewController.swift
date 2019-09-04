//
//  UIWebViewController.swift
//  amazonpay-mobile-sample_ios
//
//  Created by Uchiumi, Tetsuo on 2019/07/27.
//

import UIKit
import WebKit
import SafariServices

class UIWebViewController : UIViewController {
    
    var webView : UIWebView!

    @IBOutlet weak var topButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("UIWebViewController#viewDidAppear")
        
        if webView == nil {
            
            // WebViewの画面サイズの設定
            var webViewPadding: CGFloat = 0
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                webViewPadding = window!.safeAreaInsets.top
            }
            let webViewHeight = topButton.frame.origin.y - webViewPadding
            let rect = CGRect(x: 0, y: webViewPadding, width: view.frame.size.width, height: webViewHeight)
            
            webView = UIWebView(frame: rect);
            let webUrl = URL(string: Config.shared.baseUrl + "ios-ui/order")!
            let myRequest = URLRequest(url: webUrl)
            webView.loadRequest(myRequest)
            
            // 生成したWebViewの画面への追加
            self.view.addSubview(webView)
        }
    }
    
    func jsCallbackHandler(_ token:String) {
        print("UIWebViewController#jsCallbackHandler")
        
        let safariView = SFSafariViewController(url: NSURL(string: Config.shared.baseUrl
            + "button?token=" + token + "&mode=" + Holder.mode)! as URL)
        Holder.appToken = token
        present(safariView, animated: true, completion: nil)
    }
}

