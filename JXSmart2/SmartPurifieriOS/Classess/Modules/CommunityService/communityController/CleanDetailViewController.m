//
//  CleanDetailViewController.m
//  EBaby
//
//  Created by Mray-mac on 16/11/15.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "CleanDetailViewController.h"
//#import "CleansTableViewCell.h"
#import "SPComServiceModulesBusiness.h"
#import "ServiceModel.h"
#import "UIImageView+WebCache.h"

#import "UIButton+WEdgeInSets.h"
#import "JXCommunityDetailHeader.h"
#import "JXCommunityDetailSectionHeader.h"
#import "JXCommunityShopDetailTableViewCell.h"
#import "JXCommunityShopContentTableViewCell.h"
#import "JXCommunityInterviewBottomView.h"
#import <MessageUI/MessageUI.h>
#import "LMLReportController.h"
#import "SPUserModel.h"
#import "SPUserServiceElectricityEntrance.h"
#import "ReleaseViewController.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>



@interface CleanDetailViewController ()<UITableViewDelegate,UITableViewDataSource,MFMessageComposeViewControllerDelegate>


@property (nonatomic,strong) UITableView * myTableView;

@property (nonatomic,strong) SPComServiceModulesBusiness *  business ;

@property (nonatomic,strong) ServiceModel * detailModel ;

@property (nonatomic,strong) JXCommunityDetailHeader * header ;

@property (nonatomic,strong) UIWebView * webview ;

@property (nonatomic,strong)  JXCommunityInterviewBottomView * interView ;

@property (nonatomic,strong) CTCallCenter *callCenter;

@end

@implementation CleanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"详情";

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIBarButtonItem * btn_Item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back_left"] style:UIBarButtonItemStylePlain target:self action:@selector(viewGObACK)];
    
    self.navigationItem.leftBarButtonItems = @[btn_Item];

    [self initWithUI];
    
    [self initNetwork];
    
    [self detectCall];
    
    [self.myTableView addJXEmptyView];
}

-(void)viewGObACK{

    __block BOOL isok = NO ;
    
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if ([obj isKindOfClass:[ReleaseViewController class]]) {
            
            isok = YES ;
            
            *stop = YES ;
        }
    }];
    
    if (isok) {
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
    
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

//视图创建
-(void)initWithUI
{
    [self.view addSubview:self.myTableView];
    
}


#pragma mark  网络代理
-(void)initNetwork
{
    [SPSVProgressHUD show];
    
    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults] ;
    
    NSString * longitude = [[userdefault objectForKey:CPMMUNITYlongitude]  stringValue];
    
    NSString * latitude = [[userdefault objectForKey:CPMMUNITYlatitude] stringValue];
    
    if (!longitude) {
        
        longitude = @"0";
    }
    if (!latitude) {
        
        latitude = @"0";
    }

    NSDictionary * dic = @{@"pubId":self.pubId,@"userlong":longitude,@"userlat":latitude};
    
//    NSDictionary * dic = @{@"pubId":self.pubId};
    
    __weak typeof(self) weakself  = self ;
    
    [self.business communitydoultonDetails:dic success:^(id result) {
        
        
        weakself.myTableView.tableHeaderView = weakself.header;
        
        [weakself.interView.openCall addTarget:self action:@selector(phoneNumClick) forControlEvents:UIControlEventTouchUpInside];
        
        [weakself.interView.openMessage addTarget:self action:@selector(openMessageClick) forControlEvents:UIControlEventTouchUpInside];
      
        [SPSVProgressHUD dismiss];
        
        weakself.detailModel = result;
        
        weakself.header.liulanLabel.text = [NSString stringWithFormat:@"浏览 %@次 咨询 %@次",weakself.detailModel.traffic,weakself.detailModel.inquiries];
        
        weakself.header.mainBannerView.imageURLStringsGroup = [weakself.detailModel.url componentsSeparatedByString:@","];
        
        weakself.interView.pub_name.text = weakself.detailModel.pubName;
        
        [weakself.myTableView reloadData];
        
    } failer:^(NSString *error) {
      
        [SPSVProgressHUD dismiss];
  
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        
    }];

    
}

-(void)requesUpdateConsulting{

    if (!self.pubId) {
        
        return ;
    }
    
    [self.business updateCommunityConsulting:@{@"pubid":_pubId} success:^(id result) {
        
       
        
    } failer:^(NSString *error) {
        
        
    }];
    
}

#pragma mark - 举报接口
-(void)requestReportThisBusiness:(NSString*)reason{

    if (self.pubId && self.detailModel) {
        
        
        [self.business reportCommunityBusiness:@{@"pubid":_pubId,@"phone":[SPUserModel getUserLoginModel].UserPhone,@"rptname":self.detailModel.name,@"content":self.detailModel.content,@"cause":reason,@"phone":self.detailModel.phoneNum} success:^(id result) {
            
             [SPSVProgressHUD showSuccessWithStatus:@"举报成功,等待人工审核"];
            
        } failer:^(id error) {
            
            [SPSVProgressHUD showErrorWithStatus:error];
            
        }];
    }
    
}


#pragma  mark UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JXCommunityDetailSectionHeader * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JXCommunityDetailSectionHeader"];
    
    header.contentView.backgroundColor = [UIColor whiteColor];
    
    header.backgroundView = ({
    
        UIView * view = [UIView new];
        
        view.backgroundColor = [UIColor whiteColor];
        
        view;
    });
    
    header.right.hidden = YES;
    
    NSString * title = @"商家信息";
    
    if (section==1)
         title = @"服务内容";
    
    if (section==2) {
        
        title = @"举报商家";
        
        header.right.hidden = NO;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openReportView)];
        
        [header addGestureRecognizer:tap];
        
    }
    
    header.titleLabel.text = title;
    
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 45.f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
        
    return 10.f;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (!self.detailModel) {
        
        
        
        return 0;
    }
    
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return section == 2?0:1;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
       
        JXCommunityShopDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JXCommunityShopDetailTableViewCell"];
        
        cell.model = _detailModel;
        
        [cell.location addTarget:self action:@selector(forwardToMapView) forControlEvents:UIControlEventTouchUpInside ];
        
        return cell;
        
    }else if (indexPath.section == 1){
        
        JXCommunityShopContentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXCommunityShopContentTableViewCell"];
        
        cell.contLabel.text = _detailModel.content;
        
        return cell;
    }else{
    
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableView"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        
        cell.textLabel.textColor = [UIColor colorWithHexString:@"80828d"];
        
        cell.textLabel.numberOfLines = 0;
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        
        CGFloat hegiht  = [tableView fd_heightForCellWithIdentifier:@"JXCommunityShopDetailTableViewCell" configuration:^(JXCommunityShopDetailTableViewCell* cell) {
            
            cell.model = _detailModel;
            
         }];
        
        return hegiht;
    }
    
    if (indexPath.section==1) {
        
       CGFloat heght  = [tableView fd_heightForCellWithIdentifier:@"JXCommunityShopContentTableViewCell" configuration:^(JXCommunityShopContentTableViewCell* cell) {
           
           cell.contLabel.text = _detailModel.content;
            
        }];
        
        return heght <60?60 : heght;
    }
   
    return 80.f;
}

#pragma mark - 前往地图
-(void)forwardToMapView{
    
    if (!self.detailModel)
        return;
    
    
    UIViewController * vc  = [SPUserServiceElectricityEntrance  fethMAPViewForLocation:@[self.detailModel.merchantlat,self.detailModel.merchantlong,self.detailModel.address]];

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 拨打电话
-(void)phoneNumClick{
    
    if (!self.detailModel) {
        
        return ;
    }
    
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.detailModel.phoneNum]]]];
    
}

#pragma mark - 举报
-(void)openReportView{

    LMLReportController *report = [[LMLReportController alloc] initWithNibName:@"LMLReportController" bundle:nil];
    
    report.reasonInfo = @[@"色情低俗", @"广告骚扰", @"诱导分享", @"谣言", @"政治敏感", @"违法（暴力恐怖、违禁品等）", @"侵权", @"售假", @"其他"];
    
    __weak typeof(self) weakself = self ;
    
    report.complationBlock = ^(NSString *content) {
      
        if (content) {
            
            [weakself requestReportThisBusiness:content];
        }
        
    };
    
    [self.navigationController pushViewController:report animated:YES];
    
}
#pragma mark  - 发短信
-(void)openMessageClick{

    if (!self.detailModel) {
        
        return ;
    }
  
    [self showMessageView:@[_detailModel.phoneNum] title:@"新信息" body: [NSString stringWithFormat:@"您好，我对您在净喜智能发布的“%@”很感兴趣，想和您详细了解一下",_detailModel.name]];
}

-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body
{
    if( [MFMessageComposeViewController canSendText] )
    {
        MFMessageComposeViewController * controller = [[MFMessageComposeViewController alloc] init];
        
        controller.recipients = phones;
        
        controller.body = body;
        
        controller.messageComposeDelegate = self;
        
        [[[[controller viewControllers] lastObject] navigationItem] setTitle:title];//修改短信界面标题
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setFrame:CGRectMake(0, 0, 40, 20)];
        
        [button setTitle:@"取消" forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:17.0];
        
        [button addTarget:self action:@selector(messageComposeViewController:didFinishWithResult:) forControlEvents:UIControlEventTouchUpInside];
        
        [[controller viewControllers] lastObject].navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
      
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示信息"
                                                        message:@"该设备不支持短信功能"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
   
    switch (result) {
        case MessageComposeResultSent:
            //信息传送成功
            [self requesUpdateConsulting];
            break;
        case MessageComposeResultFailed:
            //信息传送失败
              [self requesUpdateConsulting];
            break;
        case MessageComposeResultCancelled:
            //信息被用户取消传送
              //[self requesUpdateConsulting];
            break;
        default:
             //[self requesUpdateConsulting];
            break;
    }
}


-(void)detectCall
{
    _callCenter = [[CTCallCenter alloc] init];
   
    __weak typeof(self) weakself = self ;
    
    _callCenter.callEventHandler = ^(CTCall* call) {
        
        
        if ([call.callState isEqualToString:CTCallStateDisconnected])
        {
            NSLog(@"挂断了电话咯");
            
            [weakself requesUpdateConsulting];
        }
        else if ([call.callState isEqualToString:CTCallStateConnected])
        {
            [weakself requesUpdateConsulting];
            
            NSLog(@"电话通了Call has just been connected");
        }
        else if([call.callState isEqualToString:CTCallStateIncoming])
        {
            NSLog(@"来电话了");
            
        }
        else if ([call.callState isEqualToString:CTCallStateDialing])
        {
            NSLog(@"正在拨出电话call is dialing");
        }
        else
        {
            NSLog(@"什么也没做Nothing is done");
        }
    };
}

-(UITableView *)myTableView{
    
    if (!_myTableView) {
        
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_H-StatusBar_H-45) style:UITableViewStyleGrouped];
        
        _myTableView.backgroundColor = [UIColor clearColor];
        
        _myTableView.delegate = self;
        
        _myTableView.dataSource = self;
        
        _myTableView.separatorStyle = 1;
        
        [self  compatibleAvailable_ios11:_myTableView];
        
        [_myTableView registerNib:[UINib nibWithNibName:@"JXCommunityDetailSectionHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"JXCommunityDetailSectionHeader"];
        
        [_myTableView registerNib:[UINib nibWithNibName:@"JXCommunityShopDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXCommunityShopDetailTableViewCell"];
        
        [_myTableView registerNib:[UINib nibWithNibName:@"JXCommunityShopContentTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXCommunityShopContentTableViewCell"];
        
        
    }
    
    return _myTableView;
}

-(SPComServiceModulesBusiness *)business{

    if (!_business) {
        
        _business = [[SPComServiceModulesBusiness alloc] init];
    }

    return _business;
}

-(UIWebView *)webview{

    if (!_webview) {
        
        _webview = [[UIWebView alloc] init];
        
//        [self.view addSubview:_webview];
    }
    
    return _webview;
}

-(JXCommunityDetailHeader *)header{

    if (!_header) {
        
        _header  = [[JXCommunityDetailHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.4)];
        
    }
    
    return _header ;
}

-(JXCommunityInterviewBottomView *)interView{

    if (!_interView) {
        
        _interView= [[[NSBundle mainBundle] loadNibNamed:@"JXCommunityInterviewBottomView" owner:self options:nil]lastObject];
        
        _interView.frame = CGRectMake(0,SCREEN_HEIGHT-NaviBar_H-StatusBar_H-45, SCREEN_WIDTH, 45);
        
        [self.view addSubview:_interView];
    }
    
    return _interView ;
}


@end
