//
//  ShareBindingViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/2.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "ShareBindingViewController.h"
#import "SPUserModulesBusiness.h"

@interface ShareBindingViewController ()<UITextFieldDelegate>
{
    
    UITextField *field;
}

@end

@implementation ShareBindingViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"分享绑定";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 44)];
    backV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backV];
    
    field = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-30, 44)];
    field.clearButtonMode = UITextFieldViewModeWhileEditing;
    field.placeholder = @"请输入对方手机号";
    field.font = [UIFont systemFontOfSize:16];
    [field setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    field.backgroundColor = [UIColor clearColor];
    field.delegate = self;
    field.keyboardType=UIKeyboardTypeNumberPad;
    field.leftViewMode = UITextFieldViewModeAlways;
    [field addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [backV addSubview:field];
    
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(15, 84, SCREEN_WIDTH-30, 0.0634*SCREEN_HEIGHT);
    returnBtn.backgroundColor = SPNavBarColor;
    [returnBtn setTitle:@"确定" forState:UIControlStateNormal];
    [returnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    
    returnBtn.layer.masksToBounds = YES;
    returnBtn.layer.cornerRadius = 4;
    [self.view addSubview:returnBtn];
}

-(void)returnClick{
    
    [self initNetWork];
}

-(void)initNetWork
{
    
    //[SPSVProgressHUD showWithStatus:@"正在绑定中"];
    NSDictionary * dic = @{@"targetNum":field.text};
    
    [[[SPUserModulesBusiness alloc]init] getSharePhoneNum:dic success:^(id result) {
        //[SPSVProgressHUD dismiss];
        
        [SPSVProgressHUD showSuccessWithStatus:@"分享成功"];
        
    } failer:^(NSString *error) {
        [SPSVProgressHUD dismiss];
        __weak typeof(self) weakself  = self ;
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        
    }];
}



#pragma textFieldDelegate
- (void) textFieldDidChange:(id) sender {
    
    UITextField *_field = (UITextField *)sender;
    
    
}

@end
