//
//  JXModifyPasswordViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXModifyPasswordViewController.h"
#import "SPUserModel.h"
#import "NSString+Verification.h"
#import "SPMainLoginBusiness.h"
#import "AppDelegate.h"
#import <GTSDK/GeTuiSdk.h>

@interface JXModifyPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldText;

@property (weak, nonatomic) IBOutlet UITextField *newdText;

@property (weak, nonatomic) IBOutlet UITextField *againText;

@property (weak, nonatomic) IBOutlet UIButton *changeBtn;



@end

@implementation JXModifyPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.title = @"修改密码";
    
    _oldText.layer.cornerRadius = 2;
    _newdText.layer.cornerRadius = 2;
    _againText.layer.cornerRadius = 2;
    
    _againText.secureTextEntry = YES;
    _newdText.secureTextEntry = YES;
    _oldText.secureTextEntry = YES;
    
    _newdText.layer.borderWidth = 1;
    _newdText.layer.borderColor = [UIColor colorWithHexString:@"d4d4d8"].CGColor;
    
    _oldText.layer.borderWidth = 1;
    _oldText.layer.borderColor = [UIColor colorWithHexString:@"d4d4d8"].CGColor;
    
    _againText.layer.borderWidth = 1;
    _againText.layer.borderColor = [UIColor colorWithHexString:@"d4d4d8"].CGColor;
    
    _changeBtn.layer.cornerRadius = 3;

    
    // Do any additional setup after loading the view.
}


- (IBAction)changePwdAction:(id)sender {
    
    if (_oldText.text.length == 0) {
        
        [self makeToast:@"请输入旧密码"];
        
        return ;
    }
    if (_newdText.text.length == 0) {
        
        [self makeToast:@"请输入新密码"];
        
        return ;
    }
    
    if (_againText.text.length == 0) {
        
        [self makeToast:@"请再次输入新密码"];
        
        return ;
    }
    
    if (![_newdText.text isEqualToString:_againText.text]) {
        
        [self makeToast:@"你的新密码输入不一致"];
        
        return ;
    }
    
    if (![_newdText.text predicateStringWithPassword] ) {
        
        [self makeToast:@"密码过于简单,请确认为6-20位字母与数字的组合"];
        
        return ;
    }
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示"message:@"是否确定?"preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self requestChangePasswd];
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

-(void)requestChangePasswd{

    NSString * password = _newdText.text ;
    
    SPUserModel * model  = [SPUserModel fetchPartnerModelDF];
    
    NSDictionary * dic = @{@"username":model.partnerNumber,@"newPwd":password,@"oldPwd":_oldText.text};
    
    __weak typeof(self) weakslef = self ;
    
    [self showWithStatus:@"正在请求中..."];
    
    SPMainLoginBusiness * business = [[SPMainLoginBusiness alloc] init];
    
    [business userForgetPassword:dic success:^(id result) {
        
        [weakslef showSuccessWithStatus:@"修改成功"];
        
        [SPUserModel delCurrentPartnerModel];
        
        [GeTuiSdk unbindAlias:model.partnerNumber andSequenceNum:model.partnerNumber andIsSelf:false];
        
        [(AppDelegate*)[UIApplication sharedApplication].delegate setLoginVCWithRootViewController];
        
    } failer:^(NSString *error) {
        
        [UIViewController dismiss];
        
        [weakslef makeToast:error];
        
    }];
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
