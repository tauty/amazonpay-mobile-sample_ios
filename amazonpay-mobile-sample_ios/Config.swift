//
//  Config.swift
//  amazonpay-mobile-sample_ios
//
//  Created by Uchiumi, Tetsuo on 2019/06/19.
//  Copyright © 2019 Uchiumi, Tetsuo. All rights reserved.
//

import Foundation

struct Config {
    static let shared = Config()

    private let config: [AnyHashable: Any] = {
        let path = Bundle.main.path(forResource: "Info", ofType: "plist")!
        let plist = NSDictionary(contentsOfFile: path) as! [AnyHashable: Any]
        return plist["AppConfig"] as! [AnyHashable: Any]
    }()
    
    let baseUrl: String
    
    private init() {
        baseUrl = config["BaseUrl"] as! String
    }
}
