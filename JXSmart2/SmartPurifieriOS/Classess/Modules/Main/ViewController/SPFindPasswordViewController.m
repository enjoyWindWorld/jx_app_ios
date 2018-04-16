//
//  SPFindPasswordViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPFindPasswordViewController.h"
#import "SPMainLoginBusiness.h"
#import "SPToastHUD.h"
#import "SPResetPasswordViewController.h"
#import "UIButton+TimerClass.h"

@interface SPFindPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneText;

@property (weak, nonatomic) IBOutlet UITextField *smscodeText;

@property (weak, nonatomic) IBOutlet UIButton *smsButton;

@property(nonatomic,strong) SPMainLoginBusiness * buessiness;

@end

@implementation SPFindPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self setNavBarTitle:nil];
    
    [self setNavBarLeftBtn:[STNavBarView createImgNaviBarBtnByImgNormal:@"nav_back" imgHighlight:@"nav_back_highlighted" target:self action:@selector(viewGoPop)]];
    
    [self.smsButton addTarget:self action:@selector(requestRegisiterCode:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view.
}


-(void)viewGoPop{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - 点击下一步
- (IBAction)nextAction:(id)sender {
    
    NSString * phoneText = _phoneText.text ;
    
    if (phoneText.length==0) {
        
        [SPToastHUD makeToast:@"请输入手机号" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if (![phoneText predicateStringWithPhone]) {
        
        [SPToastHUD makeToast:@"手机号格式错误" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if (_smscodeText.text.length==0) {
        
        [SPToastHUD makeToast:@"请输入验证码" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    [SPSVProgressHUD showWithStatus:@"请稍后..."];
    
    //校验验证码
    __weak typeof(self) weakself = self ;
    
    [self.buessiness userCheckSMSCode:@{@"phoneNum":phoneText,@"code":_smscodeText.text} success:^(id result) {
        
       [SPSVProgressHUD dismiss];
        
        [weakself performSegueWithIdentifier:@"SPResetPasswordViewController" sender:nil];
        
    } failere:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
    }];
    
}

#pragma mark - 请求发送验证码
-(void)requestRegisiterCode:(UIButton*)bt{
    
    NSString * phoneText = _phoneText.text ;
    
    if (phoneText.length==0) {
        
        [SPToastHUD makeToast:@"请输入手机号" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    if (![phoneText predicateStringWithPhone]) {
        
        [SPToastHUD makeToast:@"手机号格式错误" duration:3 position:nil makeView:self.view];
        
        return ;
    }
    
    [bt statrTimerWithDefaultTime:10 block:nil];
    
    [self privateRequestRegisiterCode];
    
}


#pragma mark - PRIVATE METHOD

-(void)privateRequestRegisiterCode{
    
    __weak typeof(self) weakslef = self ;
    //    type=0表示注册，type=1表示找回密码
    NSDictionary * dic = @{@"phoneNum":_phoneText.text,@"type":@"1"};
    
    [self.buessiness userRegisterSMSCode:dic success:^(id result) {
        
        if ([result isKindOfClass:[NSArray class]]) {
            
            for (NSDictionary *dic in result) {
                
                NSString * smsCode  = [dic objectForKey:@"code"];
                
//                _smscodeStr = smsCode ;
            }
            
            [SPToastHUD makeToast:@"发送成功" duration:3 position:nil makeView:weakslef.view];
            
        }
        
    } failer:^(NSString *error) {
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakslef.view];
    }];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"SPResetPasswordViewController"]) {
        
        SPResetPasswordViewController * vc = segue.destinationViewController;
        
        vc.type = SPResetPwdType_ForgetPWD;
        
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
