# 【iOS Objective-C】ニフクラ mobile backend を体験しよう！
![画像1](/readme-img/001.png)

## 概要
* Xcode(Objective-C)で作成したiOSアプリから、[ニフクラ mobile backend](https://mbaas.nifcloud.com/)へデータ登録を行うサンプアプリです（Swift版は[こちら](https://github.com/natsumo/iOS-Swift_DB_DEMO)）
 * 「START DEMO」ボタンをタップするとクラウドにデータが上がります★
* 簡単な操作ですぐに [ニフクラ mobile backend](https://mbaas.nifcloud.com/)を体験いただけます

## ニフクラ mobile backendって何？？
スマートフォンアプリのバックエンド機能（プッシュ通知・データストア・会員管理・ファイルストア・SNS連携・位置情報検索・スクリプト）が**開発不要**、しかも基本**無料**(注1)で使えるクラウドサービス！今回はデータストアを体験します

注1：詳しくは[こちら](https://mbaas.nifcloud.com/price.htm)をご覧ください

![画像2](/readme-img/002.png)

## 動作環境
* Mac OS X 10.10(Yosemite)
* Xcode ver. 7.2.1
* Simulator ver. 9.2
 * iPhone6(iOS 9.2)

※上記内容で動作確認をしています。


## 手順
### 1. [ニフクラ mobile backend](https://mbaas.nifcloud.com/)の会員登録とログイン→アプリ作成

* 上記リンクから会員登録（無料）をします。登録ができたらログインをすると下図のように「アプリの新規作成」画面が出るのでアプリを作成します

![画像3](/readme-img/003.png)

* アプリ作成されると下図のような画面になります
* この２種類のAPIキー（アプリケーションキーとクライアントキー）はXcodeで作成するiOSアプリに[ニフクラ mobile backend](https://mbaas.nifcloud.com/)を紐付けるために使用します

![画像4](/readme-img/004.png)

* この後動作確認でデータが保存される場所も確認しておきましょう

![画像5](/readme-img/005.png)

#### 2. GitHubからサンプルプロジェクトのダウンロード
* 下記リンクをクリックしてプロジェクトをダウンロードをMacにダウンロードします
 * __[DB_Objective-C](https://github.com/NIFCLOUD-mbaas/iOS-Objective-C_DB_DEMO/archive/master.zip)__

### 3. Xcodeでアプリを起動
* ダウンロードしたフォルダを開き、「DB_Objective-C.xcworkspace」をダブルクリックしてXcode開きます(白い方です)

![画像09](/readme-img/009.png)

![画像6](/readme-img/006.png)

* 「DB_Objective-C.xcodeproj」（青い方）ではないので注意してください！
![画像08](/readme-img/008.png)

### 4. APIキーの設定

* `AppDelegate.m`を編集します
* 先程[ニフクラ mobile backend](https://mbaas.nifcloud.com/)のダッシュボード上で確認したAPIキーを貼り付けます

![画像07](/readme-img/007.png)

* それぞれ`YOUR_NCMB_APPLICATION_KEY`と`YOUR_NCMB_CLIENT_KEY`の部分を書き換えます
 * このとき、ダブルクォーテーション（`"`）を消さないように注意してください！
* 書き換え終わったら`command + s`キーで保存をします

### 5. 動作確認
* 左上の実行ボタン（さんかくの再生マーク）をクリックします

![画像12](/readme-img/012.png)

* シミュレーターが起動したら![画像13](/readme-img/013.png)ボタンをタップします
* 動作結果が画面に表示されます
 * 保存に成功した場合：「`保存に成功しました。objectId:******`」
 * 保存に失敗した場合：「`エラーが発生しました。エラーコード:******`」
* objectIdはデータを保存したときに自動で割り振られるIDです
* エラーが発生した場合は、[こちら](https://mbaas.nifcloud.com/doc/current/rest/common/error.html)よりエラー内容を確認いただけます
![画像1](/readme-img/001.png)

* 保存に成功したら、[ニフクラ mobile backend](https://mbaas.nifcloud.com/)のダッシュボードから「データストア」を確認してみましょう！
* `TestClass`という保存用クラスが作成され、その中にデータが確認できます

## 解説
サンプルプロジェクトに実装済みの内容のご紹介

#### SDKのインポートと初期設定
* ニフクラ mobile backend の[ドキュメント（クイックスタート）](https://mbaas.nifcloud.com/doc/current/introduction/quickstart_ios.html)をご覧ください
 * このDEMOアプリは「CocoaPods」を利用する方法でSDKをインポートしています

#### ロジック
 * `Main.storyboard`でデザインを作成し、`ViewController.m`にロジックを書いています
 * `testClass`オブジェクトに対してkey, value形式で値をセット（`setObject`）し、`saveInBackgroundWithBlock`メソッドを実行すると、非同期にてデータが保存されます

```objc
#import "ViewController.h"
#import "NCMB/NCMB.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *alertText;

@end

@implementation ViewController

- (IBAction)startBtn:(UIButton *)sender {
    // 保存先クラスの作成
    NCMBObject *obj = [NCMBObject objectWithClassName:@"TestClass"];
    // 値を設定
    [obj setObject:@"Hello,NCMB!" forKey:@"message"];
    // 保存を実施
    [obj saveInBackgroundWithBlock:^(NSError *error) {
        if (error){
            // 保存に失敗した場合の処理
            NSLog(@"エラーが発生しました。エラーコード：%ld", error.code);
            self.alertText.text = [NSString stringWithFormat:@"エラーが発生しました。エラーコード：%ld", error.code];
        } else {
            // 保存に成功した場合の処理
            NSLog(@"保存に成功しました。objectId：%@", obj.objectId);
            self.alertText.text = [NSString stringWithFormat:@"保存に成功しました。objectId：%@", obj.objectId];
        }
    }];
}

@end
```

## 参考
* 同じ内容の【Swift】版もご用意しています
 * https://github.com/NIFCLOUD-mbaas/iOS-Swift_DB_DEMO
