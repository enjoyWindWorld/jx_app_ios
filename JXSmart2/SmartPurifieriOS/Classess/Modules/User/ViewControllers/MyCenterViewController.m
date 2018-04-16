//
//  MyCenterViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/12/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyCenterViewController.h"
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
#import "SPUserDataMsgViewController.h"
#import "UIImageView+WebCache.h"
#import "SPUserModel.h"
//#import "UINavigationController+FDFullscreenPopGesture.h"
#import "LXFButton.h"
#import "CustomMyClarifierViewController.h"
#import "JXShopingCarViewController.h"
#import "CustomMyOrderListViewController.h"
#import "JXUserOrderItemTableViewCell.h"
#import "RDVTabBarItem.h"
#import "CustomAfterSalesViewController.h"

#define MinIconWH  0.0  // 用户头像最小的头像

@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
{
    NSString *itemImgKey;
    NSString *itemContentKey;
    
    CGFloat MaxIconWH;
    
    UILabel *titleLabel;
    
    UIImageView *navView;
    
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic ,strong) NSMutableArray * itemDataArr ;

@property (nonatomic,strong) SPUserServiceHeaderView * headerView;

@property (nonatomic,strong) UIButton *messageButton;

@end

@implementation MyCenterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemDataArr = [NSMutableArray array];
    
    [self getItemArrData];

     // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    
    self.tableView.tableHeaderView = self.headerView;
    
    [self.view addSubview:self.tableView];

    [self.view addSubview:self.messageButton];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SPUserModel * model = [SPUserModel getUserLoginModel];
    
    self.headerView.userModel = model;
    
    [self reuestNotReadMessageCountData];
    
    //控制器即将进入的时候调用
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


-(void)getItemArrData{
    itemImgKey = @"itemImgKey";
    itemContentKey = @"itemContentKey";
    
    [self.itemDataArr addObject:@[@{itemImgKey:@"mypages_one",itemContentKey:@"我的订单"},@{itemImgKey:@"mypages_one",itemContentKey:@"我的订单"}]];
    
    [self.itemDataArr addObject:@[@{itemImgKey:@"mypages_two",itemContentKey:@"家庭地址"},@{itemImgKey:@"user-submitshop",itemContentKey:@"我的发布"},@{itemImgKey:@"mypages_five",itemContentKey:@"我的净水机"},@{itemImgKey:@"mypages_six",itemContentKey:@"我的推广"},@{itemImgKey:@"mypages_six",itemContentKey:@"售后与评价"}]];
//        [self.itemDataArr addObject:@[@{itemImgKey:@"mypages_two",itemContentKey:@"家庭地址"},@{itemImgKey:@"user-submitshop",itemContentKey:@"我的发布"},@{itemImgKey:@"mypages_five",itemContentKey:@"我的净水机"},@{itemImgKey:@"mypages_six",itemContentKey:@"我的推广"}]];

    [self.itemDataArr addObject:@[@{itemImgKey:@"mypages_thven",itemContentKey:@"分享"},@{itemImgKey:@"user-seting",itemContentKey:@"设置"},@{itemImgKey:@"mypages_eight",itemContentKey:@"意见反馈"}]];
    
}
-(void)reuestNotReadMessageCountData{
    
    __weak typeof(self) weakself = self ;
    
    SPUserModulesBusiness  * all = [[SPUserModulesBusiness alloc] init];
    
    [all getNotReadMessageCount:@{} success:^(id result) {
        
         NSInteger count = [result  integerValue];
        
            count  =  MIN(99, count);
     
        _messageButton.badgeView.badgeValue = count;
        
        [[weakself rdv_tabBarItem] setBadgeValue:[NSString stringWithFormat:@"%ld",count]];
        
        [SPTabbarViewController setTabbarbadgeValueWith:2 badgeShow:count];
        
        [_messageButton.badgeView setPosition:MGBadgePositionTopRight];

        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: MIN(99, count)];
        
    } failer:^(NSString *error) {
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}

#pragma mark - 前往消息界面
-(void)messageViewAction{
    
    UIStoryboard * sb= [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    MyClarifierMessageViewController * vc  =  [sb instantiateViewControllerWithIdentifier:@"MyClarifierMessageViewControllerxib"];
    
//    __weak typeof(self) weakself = self;
//    [vc setDidHander:^{
//       
//        [weakself reuestNotReadMessageCountData];
//        
//    }];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
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
    
    
    if (indexPath.section==0&&indexPath.row==1) {
        
        JXUserOrderItemTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXUserOrderItemTableViewCell"];
        
        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forwardGoOrderViiew:)];
        UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forwardGoOrderViiew:)];
        UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forwardGoOrderViiew:)];
        UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forwardGoOrderViiew:)];
        cell.group_view1.tag = 1;
        cell.group_view2.tag= 2;
        cell.group_View3.tag = 3;
        cell.group_view4.tag = 4;
        
        [cell.group_view1 addGestureRecognizer:tap1];
        [cell.group_view2 addGestureRecognizer:tap2];
        [cell.group_View3 addGestureRecognizer:tap3];
        [cell.group_view4 addGestureRecognizer:tap4];
        
        
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray * arrData = self.itemDataArr[indexPath.section];
    
    NSDictionary * itemDic = arrData[indexPath.row];
    
    cell.textLabel.text = itemDic[itemContentKey];
    
    cell.textLabel.textColor = HEXCOLOR(@"333333");
    
    cell.textLabel.font = [UIFont fontWithName:@"AppleGothic" size:16];
    
    cell.imageView.image = [UIImage imageNamed:itemDic[itemImgKey]];
    
    if (indexPath.section==0&&indexPath.row==0)
       
        cell.detailTextLabel.text = @"全部订单";
        cell.detailTextLabel.textColor = HEXCOLOR(@"666666");
        cell.detailTextLabel.font = [UIFont fontWithName:@"AppleGothic" size:16];
    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10.f;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return .1f ;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0&&indexPath.row==1) return 80.f;
    
    return 44.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
        //我的订单
            
            CustomMyOrderListViewController * vc = [[CustomMyOrderListViewController alloc]init];
            
            vc.title = @"我的订单";
            
            vc.selectIndex = 0;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        ///购物车
 
        //已付款 已绑定 未续费 已续费
    }else if (indexPath.section==1){
    
        //家庭地址 我的发布 我的水机 推广人
        
        if (indexPath.row==0) {
            
            UIStoryboard * story = [UIStoryboard storyboardWithName:@"User" bundle:nil];
            
            UIViewController * vc  = [story instantiateViewControllerWithIdentifier:@"SPUserAddressListViewControllerXBID"];
            
            [self.navigationController pushViewController:vc animated:YES];

        }
        
        if (indexPath.row==1) {
            
            MerchantViewController*vc = [[MerchantViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.row==2) {
            
            CustomMyClarifierViewController * vc = [[CustomMyClarifierViewController alloc] init];
            
            vc.title = @"我的净水机";
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.row == 3) {
            
            [self forwardTuiguang];
        }
        
        if (indexPath.row == 4) {
            
            [self forwardAftersSales];
        }
        
        
    }else{
    
        //分享 设置  意见反馈
        if (indexPath.row==0) {
            
            ShareBindingViewController *vc = [[ShareBindingViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        if (indexPath.row==1) {
            
            SetViewController *vc = [[SetViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.row==2) {
            
            SPPersonalSignatureViewController *vc =[[SPPersonalSignatureViewController alloc]init];
            
            vc.titleStr = @"意见反馈";
            
            vc.contentBlock = ^(NSString *content){
                
                
            };
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    }

}

#pragma mark - 前往订单
-(void)forwardGoOrderViiew:(UITapGestureRecognizer*)tap{

    CustomMyOrderListViewController * vc = [[CustomMyOrderListViewController alloc]init];
    
    vc.title = @"我的订单";
    
    vc.selectIndex = (int)tap.view.tag;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(void)forwardGoShoppingCar{

    UIStoryboard * story = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    UIViewController * vc  = [story instantiateViewControllerWithIdentifier:@"JXShopingCarViewControllerXBID"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)forwardTuiguang{
     
    UIStoryboard * sb= [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    UIViewController * vc  =  [sb instantiateViewControllerWithIdentifier:@"JXMyMarketingViewControllerXBID"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)forwardAftersSales{
    
    CustomAfterSalesViewController * vc = [[CustomAfterSalesViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -头部点击
-(void)headerClick:(UITapGestureRecognizer*)tap{

    UIStoryboard * sb= [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    UIViewController * vc  =  [sb instantiateViewControllerWithIdentifier:@"SPUserDataMsgViewControllerxbid"];
 
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}


#pragma mark - getter setter

- (UITableView *)tableView{
    
    if (!_tableView) {
        
        CGRect  frame = self.view.bounds;
        
        frame.size.height -= StatusBar_H ;
        
        if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS||IS_IPHONE_6) {
            
            frame.size.height -= NaviBar_H ;
        }
        
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        
        [self compatibleAvailable_ios11:_tableView];
        
        _tableView.dataSource = self;
        
        _tableView.delegate = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        _tableView.bounces = YES;
        
        _tableView.separatorStyle = YES;

        [_tableView registerNib:[UINib nibWithNibName:@"JXUserOrderItemTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXUserOrderItemTableViewCell"];

    }
    return _tableView;
}



#pragma mark - 未读消息
-(UIButton *)messageButton{
    if (_messageButton == nil) {
        
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_messageButton setBackgroundColor:[UIColor clearColor]];
        
        [_messageButton setImage:[UIImage imageNamed:@"nav_news"] forState:UIControlStateNormal];
        
        [_messageButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 10, 0)];
        
        _messageButton.frame = CGRectMake(SCREEN_WIDTH-59, 30, 24+35, 35);
        
        [_messageButton addTarget:self action:@selector(messageViewAction) forControlEvents:UIControlEventTouchUpInside];
        
        [_messageButton.badgeView setOutlineWidth:0.];
        
        [_messageButton.badgeView setHorizontalOffset:-15.];
        
        [_messageButton.badgeView setVerticalOffset:3.];
        
        [_messageButton.badgeView setPosition:MGBadgePositionTopRight];
        
        [_messageButton.badgeView setFont:[UIFont systemFontOfSize:10]];
        
        [_messageButton.badgeView setOutlineColor:[UIColor redColor]];
        
        [_messageButton.badgeView setBadgeColor:[UIColor redColor]];
        
        [_messageButton.badgeView setTextColor:[UIColor whiteColor]];
        
    }
    
    return _messageButton;
}

-(SPUserServiceHeaderView *)headerView{
    
    if (_headerView == nil) {
        
        _headerView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SPUserServiceHeaderView class]) owner:self options:nil]lastObject];
        
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.4);
        
        _headerView.userImage.layer.masksToBounds = YES;
        
        _headerView.userImage.layer.borderWidth = 2;
        
        _headerView.userImage.layer.borderColor = SPViewBackColor.CGColor;

        _headerView.userImage.layer.cornerRadius = _headerView.userImage.width/2;
        
        [_headerView.shoppingcar addTarget:self action:@selector(forwardGoShoppingCar) forControlEvents:UIControlEventTouchUpInside];
        
        [_headerView.answer addTarget:self action:@selector(forwardGoShoppingCar) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerClick:)];
        
        [_headerView addGestureRecognizer:tap];
    }
    return _headerView ;
}


@end
