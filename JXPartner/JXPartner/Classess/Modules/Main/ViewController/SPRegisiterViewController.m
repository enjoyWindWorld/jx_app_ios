//
//  SPRegisiterViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPRegisiterViewController.h"
#import "SPMainLoginBusiness.h"
#import "SPResetPasswordViewController.h"
#import "UIButton+TimerClass.h"
@interface SPRegisiterViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backGView;

@property(nonatomic,strong) SPMainLoginBusiness * buessiness;

@property (weak, nonatomic) IBOutlet UIButton *smsButton; //获取验证码的按钮

@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UITextField *smsCodeText;


@property (weak, nonatomic) IBOutlet UIButton *regisButton;

//@property(nonatomic,copy) NSString * smscodeStr;

@end

@implementation SPRegisiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (IS_IPHONE_6) {
        
        _backGView.image = [UIImage imageNamed:@"LoginBGI750*1334.png"];
        
    }else if (IS_IPHONE_5){
        
        _backGView.image = [UIImage imageNamed:@"LoginBGI640*1136.png"];
    }else if (IS_IPHONE_4_OR_LESS){
        
        _backGView.image = [UIImage imageNamed:@"LoginBGI640*960.png"];
    }else{
        _backGView.image = [UIImage imageNamed:@"LoginBGI1242*2208.png"];
    }
    
//    [self setNavBarTitle:@"注册"];
    
    [self.smsButton addTarget:self action:@selector(requestRegisiterCode:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setNavBarLeftBtn:[STNavBarView createImgNaviBarBtnByImgNormal:@"nav_back" imgHighlight:@"nav_back_highlighted" target:self action:@selector(viewGoPop)]];
    
    [self.regisButton addTarget:self action:@selector(requestRegisiter:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}


/**
 视图返回
 */
-(void)viewGoPop{

    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 请求注册
-(void)requestRegisiter:(UIButton*)bt{

    NSString * phoneText = _phoneText.text ;
    
    if (phoneText.length==0) {
        
//        [SPToastHUD makeToast:@"请输入手机号" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    if (_smsCodeText.text.length==0) {
        
//        [SPToastHUD makeToast:@"请输入验证码" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
   ////校验验证码
//      [SPSVProgressHUD showWithStatus:@"请稍后..."];
    
    __weak typeof(self) weakself = self ;
    
    [self.buessiness userCheckSMSCode:@{@"phoneNum":phoneText,@"code":_smsCodeText.text} success:^(id result) {
       
//        [SPSVProgressHUD dismiss];
        
        [weakself performSegueWithIdentifier:@"SPResetPasswordViewController" sender:nil];
        
    } failere:^(NSString *error) {
        
//        [SPSVProgressHUD dismiss];
        
//        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
    }];
    

    


}


#pragma mark - 请求发送验证码
-(void)requestRegisiterCode:(UIButton*)bt{
    
    NSString * phoneText = _phoneText.text ;
    
    if (phoneText.length==0) {
        
//        [SPToastHUD makeToast:@"请输入手机号" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if (![phoneText predicateStringWithPhone]) {
        
//        [SPToastHUD makeToast:@"手机号格式错误" duration:3 position:nil makeView:self.view];
       
        return ;
    }
    
    [bt statrTimerWithDefaultTime:60 block:nil];
    
    [self privateRequestRegisiterCode];

}


#pragma mark - PRIVATE METHOD

-(void)privateRequestRegisiterCode{

    __weak typeof(self) weakslef = self ;
//    type=0表示注册，type=1表示找回密码
    NSDictionary * dic = @{@"phoneNum":_phoneText.text,@"type":@"0"};
    
    [self.buessiness userRegisterSMSCode:dic success:^(id result) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dic in result) {
                
               NSString * smsCode  = [dic objectForKey:@"code"];
                
//                _smscodeStr = smsCode ;
            }
            
//            [SPToastHUD makeToast:@"发送成功" duration:3 position:nil makeView:weakslef.view];
            
        }
        
    } failer:^(NSString *error) {
        
//        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakslef.view];
    }];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"SPResetPasswordViewController"]) {
        
        SPResetPasswordViewController  * vc= segue.destinationViewController ;
        
        vc.type = SPResetPwdType_RegisiterPWD;
        
        vc.phoneText = _phoneText.text ;
        
    }


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
