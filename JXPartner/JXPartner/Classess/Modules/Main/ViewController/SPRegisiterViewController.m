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

@property(nonatomic,strong) SPMainLoginBusiness * buessiness;

@property (weak, nonatomic) IBOutlet UIButton *regisButton;

//@property(nonatomic,copy) NSString * smscodeStr;

@end

@implementation SPRegisiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarTitle:@"注册"];

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

   
    
   ////校验验证码
//      [SPSVProgressHUD showWithStatus:@"请稍后..."];
    
    __weak typeof(self) weakself = self ;
    
    [self.buessiness requestUserRegister:@{} success:^(id result) {
        
        
    } failer:^(id error) {
        
    }];
    

    


}


#pragma mark - 请求发送验证码
-(void)requestRegisiterCode:(UIButton*)bt{
    
   
    
    [bt statrTimerWithDefaultTime:60 block:nil];
    
    [self privateRequestRegisiterCode];

}


#pragma mark - PRIVATE METHOD

-(void)privateRequestRegisiterCode{

//    __weak typeof(self) weakslef = self ;
////    type=0表示注册，type=1表示找回密码
//    NSDictionary * dic = @{@"phoneNum":_phoneText.text,@"type":@"0"};
//
//    [self.buessiness userRegisterSMSCode:dic success:^(id result) {
//
//        if ([result isKindOfClass:[NSArray class]]) {
//
//            for (NSDictionary *dic in result) {
//
//               NSString * smsCode  = [dic objectForKey:@"code"];
//
////                _smscodeStr = smsCode ;
//            }
//
////            [SPToastHUD makeToast:@"发送成功" duration:3 position:nil makeView:weakslef.view];
//
//        }
//
//    } failer:^(NSString *error) {
//
////        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakslef.view];
//    }];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"SPResetPasswordViewController"]) {
        
        SPResetPasswordViewController  * vc= segue.destinationViewController ;
        
        vc.type = SPResetPwdType_RegisiterPWD;
        
//        vc.phoneText = _phoneText.text ;
        
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
