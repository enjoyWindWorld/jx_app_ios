//
//  SPResetPasswordViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPResetPasswordViewController.h"

#import "SPMainLoginBusiness.h"

#import "NSString+Verification.h"
#import "SPToastHUD.h"
#import "AppDelegate.h"
#import "SPUserModel.h"

@interface SPResetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@property(nonatomic,strong) SPMainLoginBusiness * buessiness;

@end

@implementation SPResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_type ==SPResetPwdType_RegisiterPWD) {
        
        _titleLabel.text = @"填写密码";
        
    }
    
    [self setNavBarTitle:nil];
    
    [self setNavBarLeftBtn:[STNavBarView createImgNaviBarBtnByImgNormal:@"nav_back" imgHighlight:@"nav_back_highlighted" target:self action:@selector(viewGoPop)]];
    // Do any additional setup after loading the view.
}

-(void)viewGoPop{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark - 点击确定
- (IBAction)resetPasswordAction:(id)sender {
    
    NSString * password = _passwordText.text;
    
    if (password.length == 0) {
        
        [SPToastHUD makeToast:@"请输入密码" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    //？？
    if (![password predicateStringWithPassword]) {
        
        [SPToastHUD makeToast:@"密码不符合规则,请重新输入" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if (_type ==SPResetPwdType_RegisiterPWD) {
        
        //注册
        [self requestRegisiter];
        
    }else if (_type==SPResetPwdType_ForgetPWD){
    
        [self requestForgetPWD];
    }
    
}

#pragma mark - 设置新密码
-(void)requestForgetPWD{
    
    
    NSString * password = _passwordText.text ;
    
    NSDictionary * dic = @{@"phoneNum":_phoneText,@"newPwd":password,@"oldPwd":@"qqqqxxxxpppp"};
    
    __weak typeof(self) weakslef = self ;
    
    [SPSVProgressHUD showWithStatus:@"正在请求中..."];
    
    [self.buessiness userForgetPassword:dic success:^(id result) {
        
        [SPSVProgressHUD showSuccessWithStatus:@"找回成功"];
        
        SPUserModel * user  = [SPUserModel getUserLoginModel];
        
        if (!user) {
            user = [[SPUserModel alloc] init];
        }
        
        user.UserPhone = _phoneText;
        
        [user saveUserLoginModel];
        
        [weakslef.navigationController popToRootViewControllerAnimated:YES];
        
    } failer:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakslef.view];
    }];
    
}
#pragma mark - 请求注册
-(void)requestRegisiter{

    NSString * password = _passwordText.text ;
    
    NSDictionary * dic = @{@"phoneNum":_phoneText,@"password":password};
    
    __weak typeof(self) weakslef = self ;
    
    [SPSVProgressHUD showWithStatus:@"正在注册.."];
    
    [self.buessiness userRegister:dic success:^(id result) {
        
//        [weakslef requestLogin];
        
        [SVProgressHUD dismiss];
        
        SPUserModel * user  = [SPUserModel getUserLoginModel];
        
        if (!user) {
            user = [[SPUserModel alloc] init];
        }
        
        user.UserPhone = _phoneText;
        
        [user saveUserLoginModel];
        
        [weakslef.navigationController popToRootViewControllerAnimated:YES];
   
    } failer:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakslef.view];
    }];
    
}
//#pragma mark - 请求登录
//-(void)requestLogin{
//    
//      __weak typeof(self) weakslef = self ;
//
//    NSDictionary * dic = @{@"phoneNum":_phoneText,@"password":_passwordText.text};
//    
//    [self.buessiness userLogin:dic success:^(id result) {
//        
//        [SPSVProgressHUD showSuccessWithStatus:@"注册成功"];
//        
//        SPUserModel * model = result ;
//        
//        
//        
//        model.UserPhone = _phoneText ;
//        
//        [model saveUserLoginModel];
//        
//        [weakslef.navigationController popToRootViewControllerAnimated:YES];
//        
////        AppDelegate * dele = (AppDelegate*)[UIApplication sharedApplication].delegate ;
////        
////        [dele setTabbarWithRootViewC];
//        
//    } failer:^(NSString *error) {
//        
//        [SPSVProgressHUD dismiss];
//        
//        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakslef.view];
//    }];
//}




-(SPMainLoginBusiness *)buessiness{
    
    if (_buessiness == nil) {
        
        _buessiness = [[SPMainLoginBusiness alloc] init];
        
    }
    
    return _buessiness ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
