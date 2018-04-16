//
//  BindingPhoneViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/10.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "BindingPhoneViewController.h"
#import "NewPhoneViewController.h"
#import "SPUserModel.h"


@interface BindingPhoneViewController ()
{
    SPUserModel *model;
    
}
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@property (weak, nonatomic) IBOutlet UIButton *yesBtn;


@end

@implementation BindingPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"绑定手机号";
    model = [SPUserModel getUserLoginModel];
    
    if (model) {
        _phoneNumber.text = [NSString stringWithFormat:@"你的手机号:%@",model.UserPhone];
    }
    
    _yesBtn.layer.masksToBounds = YES;
    _yesBtn.layer.cornerRadius = 3;

    
}

- (IBAction)yesClick:(id)sender {
    
    NewPhoneViewController *vc =[[NewPhoneViewController alloc]init];

    vc.block = ^(NSString *phonnum){
        if (phonnum.length > 0) {
            _phoneNumber.text = phonnum;
            
            [SPSVProgressHUD showSuccessWithStatus:@"更换成功"];
        }
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
