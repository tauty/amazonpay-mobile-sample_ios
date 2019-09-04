//
//  ThanksController.swift
//  amazonpay-mobile-sample_ios
//
//  Created by Uchiumi, Tetsuo on 2019/06/09.
//

import UIKit
import WebKit


/// 購入完了後に表示されるController.
/// 受注の情報と取得した購入者情報などを表示する.
class ThanksController : UIViewController {
    
    var token:String?
    var accessToken:String?
    var path = "thanks"
    var webView: WKWebView!

    @IBOutlet weak var topButton: UIButton!

    /// WebViewでThanks画面を表示.
    /// viewDidLoadのタイミングだと画面に配置されたLabelなどの座標がまだ入っておらず、
    /// ちょうど良いWebViewのサイズが計算できないため、viewDidAppearで処理する.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ThanksController#viewDidAppear")

        if webView == nil {
            //　画面サイズを指定してWebViewを生成
            var webViewPadding: CGFloat = 0
            if #available(iOS 11.0, *) {
                let window = UIApplication.shared.keyWindow
                webViewPadding = window!.safeAreaInsets.top
            }
            let webViewHeight = topButton.frame.origin.y - webViewPadding
            let rect = CGRect(x: 0, y: webViewPadding, width: view.frame.size.width, height: webViewHeight)
            let webConfig = WKWebViewConfiguration();
            webView = WKWebView(frame: rect, configuration: webConfig)
            
            // 画面を開く
            let query = "?token=" + token! + (accessToken == nil ? "" : "&accessToken=" + accessToken!);
            let webUrl = URL(string: Config.shared.baseUrl + path + query)!
            var myRequest = URLRequest(url: webUrl)
            myRequest.httpMethod = "POST"
            // myRequest.httpBody = ("token=" + token!).data(using: .utf8)! // Note: WKWebViewにはbodyが消えてしまうバグがあるらしいので、URLパラメータで指定。
            webView.load(myRequest)
            
            self.view.addSubview(webView)
        }
    }
}
