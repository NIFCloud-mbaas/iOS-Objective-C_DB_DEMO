//
//  ViewController.m
//  DB_Objective-C
//
//  Created by Natsumo Ikeda on 2016/04/13.
//  Copyright 2020 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
