//
//  ViewController.swift
//  amazonpay-mobile-sample_ios
//
//  Created by Uchiumi, Tetsuo on 2019/06/08.
//

import UIKit

class ViewController: UIViewController {

    var pickerView: UIPickerView = UIPickerView()
    let list: [String] = ["アプリで決済", "SFSafariViewで決済"]
    let modes: [String] = ["app", "safari"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // mode初期化
        Holder.mode = "app"
        
        // PickerView のサイズと位置
        pickerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
        pickerView.center.x = self.view.center.x
        pickerView.center.y = 100
        
        // Delegate設定
        pickerView.delegate = self
        pickerView.dataSource = self
        
        self.view.addSubview(pickerView)
    }
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Holder.mode = modes[row]
    }
}

