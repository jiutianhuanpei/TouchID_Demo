# TouchID_Demo
验证TouchID的一个小Demo

```object
_canEvaluate = [_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:nil];

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
```
