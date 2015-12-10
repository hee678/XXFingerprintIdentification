//
//  ViewController.m
//  XXFingerprintIdentification
//
//  Created by LittleKin on 15/12/10.
//  Copyright © 2015年 LittleKin. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self evaluatePolicy];
}

- (void)evaluatePolicy
{
    //初始化上下文对象
    LAContext *context = [[LAContext alloc] init];
    //错误对象
    __block  NSString *msg;
    NSError *error;
    
    //首先使用判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        //支持指纹验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:NSLocalizedString(@"请指纹解锁", nil) reply:
         ^(BOOL success, NSError *authenticationError) {
             if (success) {
                 msg =[NSString stringWithFormat:NSLocalizedString(@"EVALUATE_POLICY_SUCCESS", nil)];
             } else {
                 msg = [NSString stringWithFormat:NSLocalizedString(@"EVALUATE_POLICY_WITH_ERROR", nil), authenticationError.localizedDescription];
             }
         }];
    }else{ //不支持指纹识别
        NSLog(@"你的手机不支持指纹解锁功能%@",error);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
