//
//  UserServiceViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "UserServiceViewController.h"
#import "JSWave.h"
#import "SPUserServiceHeaderView.h"
#import "FilterViewController.h"
#import "MyOrderViewController.h"
#import "SetViewController.h"
#import "MyClarifierViewController.h"
#import "MerchantViewController.h"
#import "SPUserModel.h"
#import "ShareBindingViewController.h"
#import "SPPersonalSignatureViewController.h"
#import "UIView+MGBadgeView.h"
#import "SPUserModulesBusiness.h"
#import "MyClarifierMessageViewController.h"
#import "SPClarifierMessageModel.h"
#import "SPTabbarViewController.h"

NSString *const itemImgKey = @"itemImgKey";
NSString *const itemContentKey = @"itemContentKey";
@interface UserServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) JSWave *headerView;

@property (nonatomic, strong) UIImageView *iconImageView;

@property(nonatomic,strong)UIImageView *iconImageview;

@property(nonatomic,strong)UIView *NavView;//导航栏

@property (nonatomic ,strong) NSMutableArray * itemDataArr ;

@property (nonatomic,strong) UIButton * messageButton ;

@end

@implementation UserServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIView *)NavView{
    
    if (!_NavView) {
        
        _NavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
        _NavView.backgroundColor = [UIColor redColor];
        _NavView.alpha=0;
        
    }
    return _NavView;
}
-(void)getItemArrData{
    
    [self.itemDataArr addObject:@[@{itemImgKey:@"user-myPurifier",itemContentKey:@"我的净水机"},@{itemImgKey:@"user-order",itemContentKey:@"我的订单"},@{itemImgKey:@"user-submitshop",itemContentKey:@"我的发布"}]];
    
    [self.itemDataArr addObject:@[@{itemImgKey:@"user-feedback",itemContentKey:@"意见反馈"},@{itemImgKey:@"share@2x",itemContentKey:@"分享"},@{itemImgKey:@"user-seting",itemContentKey:@"设置"}]];
    
}

- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(self.view.bounds.size.width/1.5, 0, 0, 0);
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        _tableView.sectionFooterHeight = 0.01;
        _tableView.contentSize = CGSizeMake(0, 0);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = YES;//showsHorizontalScrollIndicator
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.sectionFooterHeight = 0;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
        
        [self.view addSubview:self.tableView];
        
        
    }
    return _tableView;
}

- (JSWave *)headerView{
    
    if (!_headerView) {
        
        
        
        //        _headerView = [[JSWave alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        _headerView = [[JSWave alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.width/3/2. + self.iconImageview.bounds.size.height/2.)*0.95)];
        
        _headerView.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.width/1.5/2.+(self.iconImageview.bounds.size.height - self.headerView.bounds.size.height)/2.);
        
        _headerView.realWaveColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"关于-视频背景"]];
        _headerView.backgroundColor = [UIColor clearColor];
        
        
        [_headerView addSubview:self.iconImageView];
        __weak typeof(self)weakSelf = self;
        _headerView.waveBlock = ^(CGFloat currentY){
            CGRect iconFrame = [weakSelf.iconImageView frame];
            iconFrame.origin.y = CGRectGetHeight(weakSelf.headerView.frame)-CGRectGetHeight(weakSelf.iconImageView.frame)+currentY-weakSelf.headerView.waveHeight;
            
            weakSelf.iconImageView.frame  =iconFrame;
        };
        [_headerView startWaveAnimation];
    }
    return _headerView;
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.itemDataArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray * arr = self.itemDataArr[section];
    
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"
                                                            forIndexPath:indexPath];
    
    NSArray * arrData = self.itemDataArr[indexPath.section];
    
    NSDictionary * itemDic = arrData[indexPath.row];
    
    cell.textLabel.text = itemDic[itemContentKey];
    
    cell.imageView.image = [UIImage imageNamed:itemDic[itemImgKey]];
    
//    cell.itemImage.image = [UIImage imageNamed:itemDic[itemImgKey]];
//    
//    cell.itemContent.text = itemDic[itemContentKey];
    
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.f;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return .1f ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            MyClarifierViewController *vc = [[MyClarifierViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 1){
            
            MyOrderViewController *vc = [[MyOrderViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            
            MerchantViewController*vc = [[MerchantViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }else if (indexPath.section == 1){
        
        if (indexPath.row == 2) {
            SetViewController *vc = [[SetViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 1){
            ShareBindingViewController *vc = [[ShareBindingViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (indexPath.row == 0){
            
            SPPersonalSignatureViewController *vc =[[SPPersonalSignatureViewController alloc]init];
            
            NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
            [defaults setObject:@"意见反馈" forKey:@"userInfo"];
            [defaults synchronize];
            
            vc.titleStr = @"意见反馈";
            vc.contentBlock = ^(NSString *content){
                
                
            };
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }
}


@end
