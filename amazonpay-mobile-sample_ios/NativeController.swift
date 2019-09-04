//
//  NativeController.swift
//  amazonpay-mobile-sample_ios
//
//  Created by Uchiumi, Tetsuo on 2019/06/10.
//

import UIKit
import SafariServices


/// ViewControllerから起動される、NATIVEサンプル用Controller.
/// Kindle Fire HD8とKindle Fire HD10の購入個数を指定して「購入手続きへ」ボタンをクリックすると受注が作成されて、
/// AmazonPayボタンでSFSafariViewの購入フローが起動する.
class NativeController : UIViewController {
    
    let numericRegex = try! NSRegularExpression(pattern: "\\A(0|[1-9][0-9]*)\\z")
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var hd8Text: UITextField!
    @IBOutlet weak var hd10Text: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var amznPayButton: UIButton!
    
    var token:String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hd8Text.keyboardType = UIKeyboardType.numberPad
        hd10Text.keyboardType = UIKeyboardType.numberPad
        amznPayButton.isHidden = true
    }
    
    @IBAction func onRegisterButtonClick(_ sender: Any) {
        if !isNumeric(hd8Text.text!) || !isNumeric(hd10Text.text!) {
            warnLabel.text = "不正な数値です！"
            return
        }
        if hd8Text.text == "0" && hd10Text.text == "0" {
            warnLabel.text = "せめて一つは買ってください！"
            return
        }
        registerButton.isHidden = true
        warnLabel.text = ""
        register()
        
        hd8Text.isEnabled = false
        hd10Text.isEnabled = false
        amznPayButton.isHidden = false
    }

    func isNumeric(_ text:String) -> Bool {
        let range = NSRange(location: 0, length: text.utf16.count)
        return numericRegex.firstMatch(in: text, options: [], range: range) != nil
    }
    
    func register() {
        let url = URL(string: Config.shared.baseUrl + "ios/create_order_rest")
        var request = URLRequest(url: url!)
        // POSTを指定
        request.httpMethod = "POST"
        // POSTするデータをBodyとして設定
        let httpBody = "hd8=" + hd8Text.text! + "&hd10=" + hd10Text.text!
        request.httpBody = httpBody.data(using: .utf8)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if error == nil, let data = data, let response = response as? HTTPURLResponse {
                print("statusCode: \(response.statusCode)")
                self.token = String(data: data, encoding: .utf8)
            }
        }.resume()
    }
    
    @IBAction func onAmazonPayButtonClick(_ sender: Any) {
        if token != nil {
            let safariView = SFSafariViewController(url: NSURL(string: Config.shared.baseUrl
                + "button?token=" + token! + "&mode=" + Holder.mode)! as URL)
            Holder.appToken = token
            present(safariView, animated: true, completion: nil)
        }
    }
    
}
