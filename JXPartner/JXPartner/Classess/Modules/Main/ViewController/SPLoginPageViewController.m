//
//  SPLoginPageViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPLoginPageViewController.h"
#import "AppDelegate.h"
#import "SPMainLoginBusiness.h"
#import "SPUserModel.h"
#import <GTSDK/GeTuiSdk.h>

/**
 登录页面
 */
@interface SPLoginPageViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *icoConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textfieldTopConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textfieldHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginBTConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LoginBTHeightConstraint;

@property (weak, nonatomic) IBOutlet UIImageView *backGView;

@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property(nonatomic,strong) SPMainLoginBusiness * buessiness;

@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;

@end

@implementation SPLoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if(IS_IPHONE_6P){
        
        _backGView.image = [UIImage imageNamed:@"LoginBGI1242*2208.png"];
    }
    else if (IS_IPHONE_6) {
        
        _backGView.image = [UIImage imageNamed:@"LoginBGI750*1334.png"];
    
    }else if (IS_IPHONE_5){
    
        _backGView.image = [UIImage imageNamed:@"LoginBGI640*1136.png"];
    }else if (IS_IPHONE_4_OR_LESS){
    
        _backGView.image = [UIImage imageNamed:@"LoginBGI640*960.png"];
    }else{

        _backGView.image = [UIImage imageNamed:@"LoginBG1125*2536.png"];
    }
    
    _registerButton.layer.borderWidth= 1.f;
    
    _registerButton.layer.borderColor = [UIColor colorWithHexString:@"1bb6ef"].CGColor ;
    

    
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    SPUserModel * model = [SPUserModel fetchPartnerModelDF];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if (model) {
        
        _phoneText.text = model.partnerNumber;
    }
}


#pragma mark - 点击登录
- (IBAction)loginAction:(id)sender {
    
    
//    AppDelegate * dele = (AppDelegate*)[UIApplication sharedApplication].delegate ;
//    
//    [dele setTabbarWithRootViewC];
//    
//    return ;
    
    if (_phoneText.text.length==0) {
        
        [self makeToast:@"请输入创客代码"];
        
        return ;
    }
    if (_passwordText.text.length==0) {
        
        
        [self makeToast:@"请输入密码"];
        
        return ;
    }
    
    [self privateRequestLogin];

    

}

#pragma mark - 点击注册（已隐藏）
- (IBAction)registerAction:(id)sender {
    
    
    [self performSegueWithIdentifier:@"SPRegisiterViewController" sender:nil];
    
}

#pragma mark - 忘记密码
- (IBAction)forgetPasswordAction:(id)sender {
    
    [self performSegueWithIdentifier:@"SPFindPasswordViewController" sender:nil];
    
}

#pragma mark - 私有方法 登录
-(void)privateRequestLogin{

    NSDictionary * dic = @{@"username":_phoneText.text,@"password":_passwordText.text};
    
    __weak typeof(self) weakself  = self ;
    
    [self showWithStatus:@"正在登录..."];
    
    [self.buessiness userLogin:dic success:^(id result) {
        
        SPUserModel * model = result ;
        
        model.timeout = [[NSDate date] timeIntervalSince1970];
        
        [model saveCurrentPartnerModel];

        [GeTuiSdk bindAlias:model.partnerNumber andSequenceNum:model.partnerNumber];
        
        [weakself showSuccessWithStatus:@"登录成功"];
        
        AppDelegate * dele = (AppDelegate*)[UIApplication sharedApplication].delegate ;
        
        [dele setPartnerVCWithRootViewController];
       
        if (model.originalpassword) {
            
            NSLog(@"当前为默认密码");
            [UIViewController showWithStatus:@"当前密码为初始密码,建议及时修改密码！" dismissAfter:10 styleName:STATETYPE_FAILERE];
        }else if (model.unboundedalipay) {
            
            NSLog(@"支付宝没有绑定");
            [UIViewController showWithStatus:@"支付宝当前没有绑定,建议及时绑定！" dismissAfter:10 styleName:STATETYPE_FAILERE];
        }
        
        
    } failer:^(NSString *error) {
        
        [UIViewController dismiss];

        [weakself makeToast:error];
        
    }];
    
    
}


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
