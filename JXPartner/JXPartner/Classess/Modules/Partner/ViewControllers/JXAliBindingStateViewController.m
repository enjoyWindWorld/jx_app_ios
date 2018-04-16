//
//  JXAliBindingStateViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/17.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXAliBindingStateViewController.h"
#import "JXPartnerBusiness.h"
#import "SPUserModel.h"

@interface JXAliBindingStateViewController ()

@property (weak, nonatomic) IBOutlet UIView *NotBindingView;

@property (weak, nonatomic) IBOutlet UIView *BindingView;

@property (weak, nonatomic) IBOutlet UIButton *agreeAgreeBtn;


@property (weak, nonatomic) IBOutlet UIButton *bingstateBtn;


@property (weak, nonatomic) IBOutlet UITextField *aliactText;

@property (weak, nonatomic) IBOutlet UITextField *alirealnameText;


@property (weak, nonatomic) IBOutlet UILabel *bingingAliactLabel;

@property (weak, nonatomic) IBOutlet UILabel *bingingAlinameLabel;


@property (nonatomic,strong) JXPartnerBusiness * business ;


@end

@implementation JXAliBindingStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor  groupTableViewBackgroundColor];
    
    
    [self loadViewForAliState:_aliState];
    
    [self  requestFetchAliBindState];
    // Do any additional setup after loading the view.
}

-(void)requestFetchAliBindState{
    
    
    SPUserModel * mdoel = [SPUserModel fetchPartnerModelDF];
    

    [self.business fetchBindingAliInformation:@{@"safetyMark":mdoel.safetyMark} success:^(id result) {
        
        
        
    } failer:^(id error) {
        
    }];
    
}

-(void)requestBingingAliData{

    SPUserModel * mdoel = [SPUserModel fetchPartnerModelDF];

    [self.business  bindingAliInformation:@{} success:^(id result) {
        
        
    } failer:^(id error) {
        
        
    }];
    
}

-(void)requestUnBindingAliData{

    
    SPUserModel * mdoel = [SPUserModel fetchPartnerModelDF];
    
    [self.business  unbundlingAliInformation:@{} success:^(id result) {
        
        
    } failer:^(id error) {
        
        
    }];
}


-(void)loadViewForAliState:(AliBindingState)state{

    if (state == AliBindingState_Binded) {
        //已绑定
        _NotBindingView.hidden = YES ;
        
        _BindingView.hidden = NO ;
        
        [_bingstateBtn setTitle:@"解绑" forState:UIControlStateNormal];
        
    }else if (state == AliBindingState_Notbind){
        //未绑定
    
        _NotBindingView.hidden = NO ;
        
        _BindingView.hidden = YES ;
        
        [_bingstateBtn setTitle:@"绑定" forState:UIControlStateNormal];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{


    [self loadViewForAliState:!_aliState];
    
}


-(JXPartnerBusiness *)business{

    if (!_business) {
        
        _business = [[JXPartnerBusiness alloc] init];
    }

    return _business ;
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
