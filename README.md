# Amazon Pay モバイル サンプルアプリ iOS(iPhone, iPad)版
下記のiOSアプリの実装です。
https://github.com/tauty/amazonpay-mobile-sample_server

## Native版
通常のiOSアプリ向けの実装サンプルです。  
アプリ側で商品の購入数を選んで受注情報を作成し、SFSafariViewを起動してAmazon Payへのログイン・住所＆支払い方法の選択・購入を実施し、またアプリ側に戻って購入完了画面を表示します。  

### 動作環境
Apple iOS バージョン11.2以降: Safari Mobile 11以降  
[参考] https://pay.amazon.com/jp/help/202030010

### 画面動作
![native_flow](img/ios_native.gif)

### 詳細フロー
[flow-ios.xlsx](./flow-ios.xlsx)の「Native」タブ参照。  
※ 同flowには各処理のURL, 処理するClass名、HTMLテンプレート名なども記載されているので、サンプルコードを読む時にもご参照ください。

## WebView版
WebView(アプリ内ブラウザ)を使ったアプリ向けの実装サンプルです。  
基本的な流ればNative版と同じで、WebView内で商品の購入数を選んで受注情報を作成し、SFSafariViewを起動してAmazon Payへのログイン・住所＆支払い方法の選択・購入を実施し、またアプリ側に戻って購入完了画面を表示します。  
※ Amazon Payではセキュリティ確保のため、URLを隠したり偽装したりできてしまうWebView上でのログイン処理を原則禁止しております。そのため、本サンプルのようにSFSafariViewへ処理を飛ばす必要があります。

### 動作環境
Apple iOS バージョン11.2以降: Safari Mobile 11以降  
[参考] https://pay.amazon.com/jp/help/202030010

### 画面動作
![webview_flow](img/ios_webview.gif)

### 詳細フロー
[flow-ios.xlsx](./flow-ios.xlsx)の「WebView」タブ参照。  
※ 同flowには各処理のURL, 処理するClass名、HTMLテンプレート名なども記載されているので、サンプルコードを読む時にもご参照ください。

# iOS版サンプルアプリのインストール

## プロジェクトのclone
まずは、clientのiOS(iPhone, iPad)側にあたる本プロジェクトをcloneしてください。  
```
git clone https://github.com/tauty/amazonpay-mobile-sample_ios.git
```

## プロジェクトのOpenとサンプルアプリの起動
本プロジェクトは、Mac上の[Xcode](https://developer.apple.com/jp/xcode/)で開きます。そのほかの環境での開き方は、ここでは扱いません。  
※ ここではversion 10.2.1を使用しています。  
まずはXcodeを立ち上げます。  
![androidstudio-welcome](img/xcode_open.png)
「Open another project」で、cloneしたプロジェクトを選択して、「Open」  
プロジェクトが開いたら、Menuの「Product」→「Run」か、画面上部の「Run」ボタンより、applicationを起動してください。
![androidstudio-project](img/xcode_project.png)
Simulatorが立ち上がり、サンプルアプリが起動します。(1〜2分かかります。)  
<img src="img/simu_start.png" width="300">

## 自己証明書のインストール
今回のサンプルでは、server側のSSL証明書に自己証明書が使用されているため、サンプルアプリを正しく動作させるためにはその自己証明書をiOS側にInstallする必要があります。  
ここでは、起動したSimulatorへのInstall方法を説明します。
※ 以下はiOS12.2で実施しておりますが、iOSのバージョンによっては手順が若干違う場合があります。

1. SSL自己証明書のDownload  
Safariを立ち上げ、下記のURLにアクセスします。(Chrome等の他のブラウザだとうまくいかないことがあるので、必ずSafariをご使用ください。)  
https://localhost:8443/crt/sample.crt  
下記のように警告が出るので、「Show Details」  
<img src="img/simu_warn.png" width="300">  
「visit this website」のリンクをタップし、表示されたダイアログで再度「Visit Website」をタップ  
<img src="img/simu_warn-detail.png" width="300">  
「Allow」をタップし、で開いたダイアログで「Close」をタップ  
<img src="img/simu_allow-download.png" width="300">  

2. SSL自己証明書のInstall  
Safariを閉じて、「Settings」 →　「General」 → 「Profile」  
今ダウンロードされた「localhost」をタップ  
<img src="img/simu_profile.png" width="300">  
「Install」をタップし、開いたダイアログで再度「Install」をタップ  
<img src="img/simu_install-profile.png" width="300">  
Installが完了します。  
<img src="img/simu_success.png" width="300">  

3. SSL自己証明書の有効化  
「Settings」 →　「General」 → 「About」で下記を開いて、「Certificate Trust Settings」  
<img src="img/simu_about.png" width="300">  
先ほどInstallした「localhost」をONにし、表示されたダイアログで「Continue」をタップして有効化します。  
<img src="img/simu_trust.png" width="300">  

あとはSimulator上でサンプルアプリを立ち上げて動作をご確認ください。
iOSのNativeのアプリからAmazonPayで購入するサンプルと、WebViewからAmazonPayで購入するサンプルの、両方の動作をご確認いただけます。

# Login with Amazonと会員連携について
今回のサンプルで提示した方式を応用することで、Amazon Accountを用いた会員連携も実現できます。
実装イメージは、[flow-ios-login.xlsx](./flow-ios-login.xlsx)をご参照ください。
※ 参考 - Login with Amazonの詳細: https://developer.amazon.com/ja/docs/login-with-amazon/web-docs.html
