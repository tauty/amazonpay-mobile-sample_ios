//
//  AppDelegate.swift
//  amazonpay-mobile-sample_ios
//
//  Created by Uchiumi, Tetsuo on 2019/06/08.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // Custom URL Scheme(ディープリンク)により起動されるメソッド.
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("AppDelegate#application")
        
        // parse URL parameters
        var urlParams = Dictionary<String, String>.init()
        for param in url.query!.components(separatedBy: "&") {
            let kv = param.components(separatedBy: "=")
            urlParams[kv[0]] = kv[1]
        }
        
        //　windowを生成
        self.window = UIWindow(frame: UIScreen.main.bounds)
        //　Storyboardを指定
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch url.host! {
        case "thanks":
            // Thanks画面を起動
            
            // token check
            if(isTokenNG(urlParams["token"]!, initial:urlParams["appToken"]!)) {
                return toError(storyboard);
            }
            
            // ViewControllerを指定(ThanksControllerのIdentity → Storyboard IDを参照)
            let vc = storyboard.instantiateViewController(withIdentifier: "ThanksVC")
            
            // tokenの設定
            (vc as? ThanksController)?.token = urlParams["token"]!
            if(urlParams["accessToken"] != nil) {
                (vc as? ThanksController)?.accessToken = urlParams["accessToken"]!
            }
            // rootViewControllerに入れる
            self.window?.rootViewController = vc
            // 表示
            self.window?.makeKeyAndVisible()
            return true
            
        case "ui-to-safari-view":
            print("AppDelegate#ui-to-safari-view")
            // SFSafariViewの購入フローを起動
            
            // 現在表示中の画面(UIWebViewController)を取得
            var vc = UIApplication.shared.keyWindow?.rootViewController
            while (vc!.presentedViewController) != nil {
                vc = vc!.presentedViewController
            }
            
            // callbackを起動
            (vc as? UIWebViewController)?.jsCallbackHandler(urlParams["token"]!)
            return true

        default:
            return true
        }
        
    }
    
    func isTokenNG(_ token:String, initial appToken:String) -> Bool {
        if(appToken != Holder.appToken!) {
            print("appToken doesn't match! app retained token:" + Holder.appToken! + ", conveyed token:" + appToken);
            return true;
        }
        if(token == appToken) {
            print("token has not been refreshed! token:" + token)
            return true;
        }
        return false
    }
    
    func toError(_ storyboard:UIStoryboard) -> Bool {
        // ViewControllerを指定(ThanksControllerのIdentity → Storyboard IDを参照)
        let vc = storyboard.instantiateViewController(withIdentifier: "ErrorVC")
        // rootViewControllerに入れる
        self.window?.rootViewController = vc
        // 表示
        self.window?.makeKeyAndVisible()
        return true;
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

