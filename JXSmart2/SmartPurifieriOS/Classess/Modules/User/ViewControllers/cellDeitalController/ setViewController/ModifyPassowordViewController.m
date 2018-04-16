//
//  ModifyPassowordViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/12.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "ModifyPassowordViewController.h"
#import "SPMainLoginBusiness.h"
#import "SPUserModel.h"
#import "AppDelegate.h"

@interface ModifyPassowordViewController (){
    SPUserModel *model;
    
}
@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UITextField *againPassword;

@property (weak, nonatomic) IBOutlet UIButton *modifyBtn;


@end

@implementation ModifyPassowordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    // Do any additional setup after loading the view from its nib.
    
    _oldPassword.layer.cornerRadius = 2;
    _password.layer.cornerRadius = 2;
    _againPassword.layer.cornerRadius = 2;
    _oldPassword.secureTextEntry = YES;
     _password.secureTextEntry = YES;
     _againPassword.secureTextEntry = YES;
    
    _password.layer.borderWidth = 1;
    _password.layer.borderColor = [UIColor colorWithHexString:@"d4d4d8"].CGColor;
    
    _oldPassword.layer.borderWidth = 1;
    _oldPassword.layer.borderColor = [UIColor colorWithHexString:@"d4d4d8"].CGColor;
    
    _againPassword.layer.borderWidth = 1;
    _againPassword.layer.borderColor = [UIColor colorWithHexString:@"d4d4d8"].CGColor;
    
    _modifyBtn.layer.cornerRadius = 3;
}

- (IBAction)modifyClick:(id)sender {
    
    NSString * password = _password.text ;
    
    model = [SPUserModel getUserLoginModel];
    
    if (![_password.text isEqualToString:_againPassword.text]){

        [SPToastHUD makeToast:@"你的新密码输入不一致" duration:2.5 position:nil makeView:self.view];
        
    }else if (![password predicateStringWithPassword]||![_againPassword.text predicateStringWithPassword]) {
        
        [SPToastHUD makeToast:@"密码输入错误" duration:2.5 position:nil makeView:self.view];
        
        return ;
    }else if ([_password.text isEqualToString:_oldPassword.text]){
        
        [SPToastHUD makeToast:@"修改密码和旧密码不能一样" duration:2.5 position:nil makeView:self.view];
        
    }else{
        
        
        NSDictionary * dic = @{@"phoneNum":model.UserPhone,@"newPwd":password,@"oldPwd":_oldPassword.text};
        
        __weak typeof(self) weakslef = self ;
        
        [SPSVProgressHUD showWithStatus:@"正在请求中..."];
        
        [[SPMainLoginBusiness alloc] userForgetPassword:dic success:^(id result) {
            
            [SPSVProgressHUD showSuccessWithStatus:@"修改成功"];
            
            model = [SPUserModel getUserLoginModel];
            
            [model delUserLoginModel];
            
            [(AppDelegate*)[UIApplication sharedApplication].delegate setLoginVCWithRootViewC];

            
            //[weakslef.navigationController popToRootViewControllerAnimated:YES];
            
        } failer:^(NSString *error) {
            
            [SPSVProgressHUD dismiss];
            
            [SPToastHUD makeToast:error duration:3 position:nil makeView:weakslef.view];
        }];
    }
    
}

@end
