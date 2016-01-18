//
//  ViewController.m
//  TouchID_Demo
//
//  Created by 沈红榜 on 16/1/18.
//  Copyright © 2016年 沈红榜. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()

@end

@implementation ViewController {
    LAContext       *_context;
    __weak IBOutlet UILabel *_label;
    
    BOOL            _canEvaluate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _context = [[LAContext alloc] init];
    
    _canEvaluate = [_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil];
    if (_canEvaluate) {
        NSLog(@"Touch ID can be used");
    } else {
        NSLog(@"Touch ID can't be use");
    }
}
- (IBAction)chickTouchID:(id)sender {
    if (_canEvaluate) {
        [_context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"验证ID" reply:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (success) {
                    NSLog(@"success");
                    _label.text = @"Success";
                } else {
                    switch (error.code) {
                        case -1:
                            _label.text = @"三次未验证通过";
                            break;
                            case -2:
                            _label.text = @"用户点击了取消";
                            break;
                            case -3:
                            _label.text = @"在TouchID界面点击了输入密码";
                            break;
                            case -4:
                            _label.text = @"在TouchID显示界面被系统取消，如按的锁屏";
                            break;
                        default:
                            break;
                    }
                    
                    NSLog(@"failed___%@", error);
                }
            });
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
