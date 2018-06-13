//
//  ReleaseViewController.m
//  EBaby
//
//  Created by Mray-mac on 16/11/15.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import "ReleaseViewController.h"
#import "ClassDeitalViewController.h"
#import "FillAddressViewController.h"
#import "SPComServiceModulesBusiness.h"
#import "SPUserModel.h"

#import <AVFoundation/AVFoundation.h>
#import "JXCommunityPushTableViewCell.h"
#import "JXCommunityTextTableViewCell.h"
#import "JXCommunityLabelTableViewCell.h"
#import "JXCommunityPushHeader.h"
#import "SPChooseDateView.h"
#import "JXCommunityGoPay.h"
#import "SPAppPayManger.h"
#import "SPHomePageElectricityEntrance.h"
#import "HMScannerController.h"
#import "SPSmartInterfaceEncryption.h"
#import "CleanDetailViewController.h"
#import "RxWebViewController.h"

@interface ReleaseViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UIScrollViewDelegate,JXCommunityTextTableViewCellDelegate>


@property (nonatomic,strong) UITableView * myTableView;

@property (nonatomic,strong) SPChooseDateView * DateView;

@property (nonatomic,strong) SPComServiceModulesBusiness * business;

//数据临时记录
@property (nonatomic,copy) NSString * class_address ; //地址
@property (nonatomic,copy) NSString * class_storeName ; //商家名称
@property (nonatomic,copy) NSString * class_promoteID ; //推广码
@property (nonatomic,copy) NSString * class_startTime; //开始时间
@property (nonatomic,copy) NSString * class_endTime ; //结束时间
@property (nonatomic,copy) NSString * class_telPhone ; //联系方式
@property (nonatomic,copy) NSString * class_contactP ; //联系人
@property (nonatomic,copy) NSString * class_categoryid ; //发布的分类id
@property (nonatomic,copy) NSString * class_serviceContent ; //发布的内容ID
@property (nonatomic,strong) NSArray * class_imageaRR; //发布的图片对象


@end

@implementation ReleaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"填写你发布的内容";
    
    
    [self initWithUI];
    
}

#pragma mark - 初始化UI

-(void)initWithUI
{

    self.view.backgroundColor = SPViewBackColor;
    
    [self.view addSubview:self.myTableView];
    
    UIView * backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    
    UIButton *returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    returnBtn.frame = CGRectMake(15, 0, SCREEN_WIDTH-30, 45);
    
    returnBtn.backgroundColor = SPNavBarColor;
    
    [returnBtn setTitle:@"发布" forState:UIControlStateNormal];
    
    [returnBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [returnBtn addTarget:self action:@selector(returnPubLishAction) forControlEvents:UIControlEventTouchUpInside];
    
    returnBtn.layer.masksToBounds = YES;
    
    returnBtn.layer.cornerRadius = 4;
    
    [backview addSubview:returnBtn];
    
    self.myTableView.tableFooterView = backview;
    
    [self  compatibleAvailable_ios11:_myTableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布须知" style:UIBarButtonItemStylePlain target:self action:@selector(fowwardPulishAgreent)];
    
}

-(void)fowwardPulishAgreent{

    RxWebViewController * vc = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:@"http://www.szjxzn.tech:8080/old_jx/4/5/071310460511831_publishagreement.pdf"]];
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)openAliPAY:(JXCommunityGoPay*)MODEL{

    
    [self.business fetchCommunityAliPAY:@{@"ord_no":MODEL.ord_no,@"seller":MODEL.seller,@"price":MODEL.price} success:^(id result) {
        
        [SPAppPayManger spAppManger:SP_AppPay_TypeAli param:result];
        
    } failer:^(id error) {
        
        
    }];
    
    
}

#pragma mark - 扫描二维码
-(void)openImagePickStartScaning{
    
    //jxsmart:// userid 加密
    
    if ([SPUserModel getUserLoginModel]) {
        
        
        NSString * useridEncry = [SPSmartInterfaceEncryption encryptionRequestWithParam:[SPUserModel getUserLoginModel].userid isEncrypation:YES url:nil];
        
        NSString * encryString = [NSString stringWithFormat:@"%@%@",INTERPROMOTION,useridEncry];
        
        __weak typeof(self) weakself = self;
 
        HMScannerController *scanner = [HMScannerController scannerWithCardName:encryString avatar:nil completion:^(NSString *stringValue) {
            
            weakself.class_promoteID = stringValue;
            
            [weakself.myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
            
            NSLog(@"扫描的  内容 %@",stringValue);
            
        }];
        
        [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
        
        [self showDetailViewController:scanner sender:nil];
        
    }
    

    
}

#pragma mark - 发布点击
-(void)returnPubLishAction{
    
    if ([self privateContentIsInvalid]) {
    
        [self requestAddPubContent];
    }
    
}

#pragma mark-网络请求
-(void)requestAddPubContent
{
    
    [SPSVProgressHUD showWithStatus:@"请稍候..."];
    

    NSUserDefaults * userdefault = [NSUserDefaults standardUserDefaults] ;
    
    NSString * longitude = [[userdefault objectForKey:CPMMUNITYlongitude]  stringValue];
    
    NSString * latitude = [[userdefault objectForKey:CPMMUNITYlatitude] stringValue];
    
    if (!longitude) {
        
        longitude = @"0";
    }
    if (!latitude) {
        
        latitude = @"0";
    }
    
    if (!_class_promoteID) {
        _class_promoteID = @"";
    }
    
    NSDictionary * dic = @{@"promoterid":_class_promoteID,@"phone":_class_telPhone,@"address":_class_address,@"sellername":_class_storeName,@"begintime":_class_startTime,@"endtime":_class_endTime,@"userName":_class_contactP,@"categoryid":_class_categoryid,@"content":_class_serviceContent,@"longitude":longitude,@"latitude":latitude};
    
    __weak typeof(self) weakself = self ;
    
    [self.business insertCommunityPublish:dic imageArr:self.class_imageaRR success:^(id result) {
        
        JXCommunityGoPay * model = result ;
        
        [SPSVProgressHUD dismiss];
        
        if (model && model.isPush == COMMUNITY_PushState_PushPay) {
            
            UIViewController * vc = [SPHomePageElectricityEntrance getPayDetailViewController:result];
            
            [self.navigationController pushViewController:vc animated:YES];

        }else{
        
            CleanDetailViewController * vc = [[CleanDetailViewController alloc] init];
            
            vc.pubId = model.pubid;
            
            [self.navigationController pushViewController:vc animated:YES];
        }

        
    } failer:^(id error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error makeView:weakself.view];
        
    }];

}


#pragma  mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 1 || section == 2) {
        
        JXCommunityPushHeader * header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JXCommunityPushHeader"];
        
        header.titleLabel.text = section == 1 ? @"选择服务类型" : @"选择服务时间段";
        
        header.contentView.backgroundColor = [UIColor whiteColor];
        
        header.backgroundView = ({
           
            UIView * view = [UIView new];
            
            view.backgroundColor = [UIColor whiteColor];
            
            view;
        });
        
        return header;
    }
   
    return nil;
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 1 || section == 2) {
        
        return 45.f;
    }
    
    return .1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.f;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       
        return 1;
  
    }else if (section == 1) {
    
        return 3;
    
    }else if (section == 2){
       
        return 4;
    
    }else{
    
        return 1;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        JXCommunityPushTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXCommunityPushTableViewCell"];
        
        cell.addressLabel.text = _class_address?_class_address:@"填写服务地址";
        
        cell.addressLabel.textColor = _class_address?HEXCOLOR(@"333333"):HEXCOLOR(@"B2B8C2");
        
        return cell;
    }else if (indexPath.section == 1){
    
        if (indexPath.row == 0) {
            
            JXCommunityLabelTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXCommunityLabelTableViewCell"];
            
            cell.leftLabel.text = @"选择分类";
            
            cell.contentLabel.text = _class_categoryid?@"查看已选内容":nil;
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
        }
        
        JXCommunityTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXCommunityTextTableViewCell"];
        
        cell.leftLabel.text = indexPath.row == 1?@"商家名称":@"推广码";
        
        cell.contentTextField.placeholder = indexPath.row == 1 ?@"请输入商家名称":@"请输入推广码";
        
        cell.contentTextField.text = indexPath.row == 1 ?_class_storeName:_class_promoteID;
        
        cell.indexpath = indexPath;
        
        cell.delegate = self;
        
        if (indexPath.row == 2) {
            
            cell.accessoryView = ({
            
                UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
                
                button.frame = CGRectMake(0, 0, 48, 48) ;
                
                [button setImage:[UIImage imageNamed:@"scanning"] forState:UIControlStateNormal];
                
                [button addTarget:self action:@selector(openImagePickStartScaning) forControlEvents:UIControlEventTouchUpInside];
                
                button;
            });
        }
        
        return cell;
    
    }else{
        
        if (indexPath.row == 0||indexPath.row==1) {
            
            JXCommunityLabelTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXCommunityLabelTableViewCell"];
            
            cell.leftLabel.text = indexPath.row == 0?@"开始时间":@"结束时间";
            
            cell.contentLabel.text = indexPath.row == 0 ? _class_startTime : _class_endTime;
            
            cell.contentLabel.textColor = HEXCOLOR(@"333333");
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
            
        }
    
        JXCommunityTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXCommunityTextTableViewCell"];
        
        cell.leftLabel.text = indexPath.row == 2?@"联系方式":@"联系人";
        
        cell.contentTextField.keyboardType = indexPath.row == 2 ?UIKeyboardTypePhonePad:UIKeyboardTypeDefault;
        
        cell.contentTextField.placeholder = indexPath.row == 2 ?@"请输入联系方式":@"请输入联系人";
        
        cell.contentTextField.text = indexPath.row == 2 ?_class_telPhone:_class_contactP;
        
        cell.indexpath = indexPath;
        
        cell.delegate = self;
    
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
    
        return 60.f;
    }
    
    return 50.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //地址
    //分类 商家名称 推广码
    //开始时间 结束时间 联系方式 联系人
    
    __weak typeof(self) weakself = self ;
    
    if (indexPath.section==0) {
        
        FillAddressViewController *vc = [[FillAddressViewController alloc]init];
        
        vc.block = ^(NSString *str){
          
            weakself.class_address = str;
            
            [_myTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        };
       
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    if (indexPath.section == 1 ) {
        
        if (indexPath.row == 0) {
            
            ClassDeitalViewController *vc = [[ClassDeitalViewController alloc]init];
            
            vc.categoryId = _class_categoryid;
            
            vc.imageArr = self.class_imageaRR;
            
            vc.serviceContent = _class_serviceContent;
            
            vc.complationBlock = ^(NSString *categoryId, NSString *content, NSArray *imageArr) {
              
                weakself.class_categoryid = categoryId;
                
                weakself.class_serviceContent =content;
                
                weakself.class_imageaRR = imageArr;
                
                [weakself.myTableView reloadData];
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    if (indexPath.section == 2 ) {
        
        if (indexPath.row == 0 || indexPath.row == 1) {
            
            [self.DateView setActionTime:^(NSString * time) {
                
                NSDateFormatter * formater  = [[NSDateFormatter alloc]init];
                
                [formater setDateStyle:NSDateFormatterMediumStyle];
                
                [formater setTimeStyle:NSDateFormatterShortStyle];
                //设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
                [formater setDateFormat:@"YYYY/MM/dd HH:mm"];
                
                NSDate * date = [formater  dateFromString:time];
                
                [formater setDateFormat:@"HH:mm"];
                
                NSString * time1  = [formater stringFromDate:date];
                
                if (indexPath.row == 0) {
                    
                    weakself.class_startTime = time1 ;
                }else{
                
                    weakself.class_endTime = time1;
                }
                
                [weakself.myTableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];

            }];
            
            [self.DateView dateViewShowAction];
            
        }
        
    }
    
}



#pragma mark - JXCommunityTextTableViewCellDelegate
-(void)cell_communityPushTextEndChange:(NSIndexPath *)index text:(NSString *)text{

    NSLog(@"  text  %@",text);
    
    if (index.section == 1) {
        
        if (index.row == 1)
           
            _class_storeName = text;
        else
            _class_promoteID = text;
        
    }else if (index.section == 2){
    
        if (index.row == 2)
            _class_telPhone = text;
        else
            _class_contactP = text;
        
    }
    
}


#pragma mark - 判断内容是否合法
-(BOOL)privateContentIsInvalid{

    BOOL isok = YES ;
    
    if (_class_address.length == 0) {
        
        [SPToastHUD makeToast:@"请填写服务地址" duration:3 position:nil makeView:self.view];
        
        return  NO;
    }
    if (_class_storeName.length == 0) {
        
        [SPToastHUD makeToast:@"请填写商家名称" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    
    if (_class_startTime.length == 0) {
        
        [SPToastHUD makeToast:@"请选择开始时间" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    if (_class_endTime.length == 0) {
        
        [SPToastHUD makeToast:@"请填写结束时间" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    if (_class_telPhone.length == 0) {
        
        [SPToastHUD makeToast:@"请填写联系方式" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    if (_class_contactP.length == 0) {
        
        [SPToastHUD makeToast:@"请填写联系人" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    
    if (_class_imageaRR.count == 0 ||_class_categoryid.length == 0 || _class_serviceContent.length ==0) {
        
        
         [SPToastHUD makeToast:@"请选择要发布的分类" duration:3 position:nil makeView:self.view];
       
        return NO;
    }
    
    
    if ([ShieldEmoji isContainsNewEmoji:_class_storeName]) {
        
         [SPToastHUD makeToast:@"内容不能包含表情" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    
    if ([ShieldEmoji isContainsNewEmoji:_class_telPhone]) {
        
         [SPToastHUD makeToast:@"内容不能包含表情" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    if ([ShieldEmoji isContainsNewEmoji:_class_contactP]) {
        
         [SPToastHUD makeToast:@"内容不能包含表情" duration:3 position:nil makeView:self.view];
        
        return NO;
    }
    
    return isok;
}


-(UITableView *)myTableView{

    if (!_myTableView) {
        
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NaviBar_H-StatusBar_H) style:UITableViewStyleGrouped];
        
        _myTableView.backgroundColor = [UIColor clearColor];
       
        _myTableView.delegate = self;
        
        _myTableView.dataSource = self;
        
        _myTableView.separatorStyle = 1;
        
        [_myTableView registerNib:[UINib nibWithNibName:@"JXCommunityPushTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXCommunityPushTableViewCell"];
        
        [_myTableView registerNib:[UINib nibWithNibName:@"JXCommunityLabelTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXCommunityLabelTableViewCell"];
        
        [_myTableView registerNib:[UINib nibWithNibName:@"JXCommunityTextTableViewCell" bundle:nil] forCellReuseIdentifier:@"JXCommunityTextTableViewCell"];
        
        [_myTableView registerNib:[UINib nibWithNibName:@"JXCommunityPushHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"JXCommunityPushHeader"];
        
    }
    
    return _myTableView;
}


-(SPChooseDateView *)DateView{
    
    if (_DateView == nil) {
        
        _DateView = [[SPChooseDateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) dataPickType:UIDatePickerModeTime dataPickHeght:SCREEN_HEIGHT*0.4];
        
        _DateView.datePicker.minimumDate =  nil;
        
    }
    
    return _DateView;
}

-(SPComServiceModulesBusiness *)business{

    if (!_business ) {
        
        _business = [[SPComServiceModulesBusiness alloc] init];
        
    }

    return _business;
}


@end
