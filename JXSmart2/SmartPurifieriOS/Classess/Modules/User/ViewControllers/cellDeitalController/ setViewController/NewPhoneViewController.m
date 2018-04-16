//
//  NewPhoneViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/10.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "NewPhoneViewController.h"
#import "NSString+Verification.h"
#import "UIButton+TimerClass.h"
#import "SPMainLoginBusiness.h"
#import "SPUserModel.h"
#import "AppDelegate.h"
#import "QSHCache.h"
#import "SPSDWebImage.h"

@interface NewPhoneViewController ()
{
    NSString *identify;
    
}
@property (weak, nonatomic) IBOutlet UITextView *identifyText;
@property (weak, nonatomic) IBOutlet UIButton *identifyBtn;
@property (weak, nonatomic) IBOutlet UITextView *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *bindingBtn;
@property(nonatomic,strong) SPMainLoginBusiness * buessiness;

@end

@implementation NewPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"绑定新手机号";

    _identifyBtn.layer.cornerRadius = 3;
    
    _phoneText.layer.cornerRadius = 3;
    _phoneText.layer.borderWidth = 0.5;
    _phoneText.layer.borderColor = SPNavBarColor.CGColor;
    
    _identifyText.layer.cornerRadius = 3;
    _identifyText.layer.borderWidth = 0.5;
    _identifyText.layer.borderColor = SPNavBarColor.CGColor;
    
    _bindingBtn.layer.cornerRadius = 3;
}

- (IBAction)bindingClick:(id)sender {
    if (_identifyText.text.length == 0) {
        [SPToastHUD makeToast:@"请输入验证码" duration:3 position:nil makeView:self.view];
    }else if (_phoneText.text.length == 0||![_phoneText.text predicateStringWithPhone]) {
        [SPToastHUD makeToast:@"你输入的手机不正确" duration:3 position:nil makeView:self.view];
    }else if ([identify isEqualToString:_identifyText.text]) {
        [SPSVProgressHUD showWithStatus:@"绑定中..."];
        
        SPUserModel *m = [SPUserModel getUserLoginModel];
        
        [self.buessiness userCheckSMSCode:@{@"code":identify,@"phoneNum":m.UserPhone} success:^(id result) {
            
            [SPSVProgressHUD dismiss];
            
            [[[SPUserModulesBusiness alloc]init] getModifyPhoneNum:@{@"newNum":_phoneText.text} success:^(id result) {
                self.block(_phoneText.text);
                
                //退出到登录界面
                SPUserModel *model = [SPUserModel getUserLoginModel];
                
                [model delUserLoginModel];
                
                [QSHCache qsh_RemoveAllCache];
                
                [[SDImageCache sharedImageCache]clearMemory];
                
                [[SDImageCache sharedImageCache] cleanDisk];
                
                [(AppDelegate*)[UIApplication sharedApplication].delegate setLoginVCWithRootViewC];
                //[self.navigationController popViewControllerAnimated:YES];
                
            } failer:^(NSString *error) {
                
                [SPSVProgressHUD dismiss];
                
                [SPToastHUD makeToast:error duration:3 position:nil makeView:self.view];
                
            }];

            
        } failere:^(NSString *error) {
            
            [SPSVProgressHUD dismiss];
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:self.view];
        }];
    }else{
        [SPSVProgressHUD showErrorWithStatus:@"验证失败"];
        
    }
    
}

- (IBAction)identifyClick:(id)sender {
    //获取验证码
    NSString *phoneNum = _phoneText.text;
    if (_phoneText.text.length == 0) {
        [SPToastHUD makeToast:@"请输入手机号" duration:3 position:nil makeView:self.view];
    }else if (![phoneNum predicateStringWithPhone]) {
        [SPToastHUD makeToast:@"手机号输入错误" duration:3 position:nil makeView:self.view];
    }else{
        
        [_identifyBtn statrTimerWithDefaultTime:10 block:nil];
        
        [self privateRequestRegisiterCode];
    }
}

-(void)privateRequestRegisiterCode{
    
    __weak typeof(self) weakslef = self ;
    //    type=0表示注册，type=1表示找回密码
    SPUserModel *m = [SPUserModel getUserLoginModel];
    NSDictionary * dic = @{@"phoneNum":m.UserPhone,@"type":@"1"};
    
    [self.buessiness userRegisterSMSCode:dic success:^(id result) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dic in result) {
                
                identify = [dic objectForKey:@"code"];
                
                //                _smscodeStr = smsCode ;
            }
            
            [SPToastHUD makeToast:@"发送成功" duration:3 position:nil makeView:weakslef.view];
            
        }
        
    } failer:^(NSString *error) {
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakslef.view];
    }];
    
}

-(SPMainLoginBusiness *)buessiness{
    
    if (_buessiness == nil) {
        
        _buessiness = [[SPMainLoginBusiness alloc] init];
        
    }
    
    return _buessiness ;
}

@end
