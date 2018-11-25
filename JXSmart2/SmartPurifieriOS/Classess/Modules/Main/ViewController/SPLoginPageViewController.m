//
//  SPLoginPageViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPLoginPageViewController.h"
#import "SPTabbarViewController.h"
#import "AppDelegate.h"
#import "RadiusButton.h"
#import "SPMainLoginBusiness.h"
#import "SPUserModel.h"
#import "GeTuiSdk.h"

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

@property (weak, nonatomic) IBOutlet RadiusButton *registerButton;

@property(nonatomic,strong) SPMainLoginBusiness * buessiness;

@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UITextField *passwordText;


@property (weak, nonatomic) IBOutlet UIImageView *logo;

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
        _backGView.image = [UIImage imageNamed:@"LoginBG 1125 2536.png"];
    }
    
    _registerButton.layer.borderWidth= 1.f;
    
    _registerButton.layer.borderColor = [UIColor colorWithHexString:@"1bb6ef"].CGColor ;
    
    [AppDelegate jx_privateMethod_FullScreenView];
    
    
#ifdef SmartPurifierHostURL_For_Release
    
#else
    
    UITapGestureRecognizer * debugtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(presentChangeURL)];
    
    debugtap.numberOfTapsRequired = 5 ;
    
    self.logo.userInteractionEnabled = YES;
    
    [self.logo addGestureRecognizer:debugtap];
    
 
#endif
    
    
//    [self loadViewDataSource];
    // Do any additional setup after loading the view.
}

-(void)presentChangeURL{
    
    NSLog(@"tap");
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"请求地址更改"message:@""preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = [SPBaseNetWorkRequst shareRequst].requestUrl ;
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString * url  = alertController.textFields.firstObject.text ;
        
        if (url) {
            
            NSUserDefaults * st = [NSUserDefaults standardUserDefaults];
            
            [st setObject:url forKey:@"SmartPurifierHostURL"];
            
            [st synchronize];
            
            [SPSVProgressHUD showSuccessWithStatus:@"更新成功重新启动"];
            

        }

    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    SPUserModel * model = [SPUserModel getUserLoginModel];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    if (model) {
        
        _phoneText.text = model.UserPhone ;
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
        
        [SPToastHUD makeToast:@"请输入手机号" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    if (_passwordText.text.length==0) {
        
        [SPToastHUD makeToast:@"请输入密码" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    [self privateRequestLogin];

    

}

#pragma mark - 点击注册
- (IBAction)registerAction:(id)sender {
    
    
    [self performSegueWithIdentifier:@"SPRegisiterViewController" sender:nil];
    
}

- (IBAction)forgetPasswordAction:(id)sender {
    
    [self performSegueWithIdentifier:@"SPFindPasswordViewController" sender:nil];
    
}

-(void)privateRequestLogin{

    NSDictionary * dic = @{@"phoneNum":_phoneText.text,@"password":_passwordText.text};
    
    __weak typeof(self) weakself  = self ;
    
    [SPSVProgressHUD showWithStatus:@"正在登录..."];
    
    [self.buessiness userLogin:dic success:^(id result) {
        
        SPUserModel * model = result ;
        
        model.UserPhone = _phoneText.text ;
        
        model.password = _passwordText.text;
        
        [model saveUserLoginModel];

         [GeTuiSdk bindAlias:model.userid andSequenceNum:model.userid];
        
        [SPSVProgressHUD showSuccessWithStatus:@"登录成功"];
        
        AppDelegate * dele = (AppDelegate*)[UIApplication sharedApplication].delegate ;
        
        [dele setTabbarWithRootViewC];
    
    } failer:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
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
