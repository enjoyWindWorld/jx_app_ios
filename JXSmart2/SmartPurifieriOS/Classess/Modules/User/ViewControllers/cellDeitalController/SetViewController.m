//
//  SetViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SetViewController.h"
#import "AboutViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UMSocialUIManager.h>
#import "AppDelegate.h"
#import "SPUserModel.h"
#import <UShareUI/UMSocialUIManager.h>
#import <UShareUI/UShareUI.h>
#import "BindingPhoneViewController.h"
#import "AccountSecurityTableViewController.h"
#import "SPUserModulesBusiness.h"
#import "UIImageView+WebCache.h"
#import "QSHCache.h"
#import "GeTuiSdk.h"
#import "SPSDWebImage.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIAlertViewDelegate>
{
    UITableView *tableV;
    
    NSArray *temArr;
    
    UIAlertView *alert;
    
    UIAlertView *clearAlert;
    
    NSString *apkurl;
    
    NSString *content;

    NSString *imgurl;

    NSString *title;
    
    CGFloat cacheSize;

}


@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
    
    title = @"欢迎使用净喜";
    
    content = @"欢迎使用净喜App";
    
    imgurl = @"净喜Logo";
    
    apkurl = @"http://www.szjxzn.cn/index.php";
    
    temArr = [NSArray arrayWithObjects:@"账户安全",@"版本更新",@"软件分享",@"关于净喜",@"清除缓存", nil];
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewCellFocusStyleCustom];
    tableV.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorStyle = YES;
    [self.view addSubview:tableV];
    
    [self  compatibleAvailable_ios11:tableV];
    
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, tableV.frame.size.width, 1)];
    clearView.backgroundColor= [UIColor colorWithHexString:@"efeff4"];
    [tableV setTableFooterView:clearView];
    
    
    alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    clearAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

    [self initNetWork];
}

-(void)initNetWork
{
    [[[SPUserModulesBusiness alloc]init] getUserShare:nil success:^(id result) {

        NSArray *dics = result;
        if ([result isKindOfClass:[NSArray class]] || result != NULL) {
            for (NSDictionary *dic in dics) {
                apkurl = dic[@"apkurl"];
                content = dic[@"content"];
                imgurl = dic[@"imgurl"];
                title = dic[@"title"];
            }
 
        }
        

    } failer:^(NSString *error) {

        
    }];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGFloat sectionHeaderHeight = 0;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y> 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }else
        if(scrollView.contentOffset.y >= sectionHeaderHeight){

            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
}

#pragma  mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor clearColor];

    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return 10;
    }else{
        return 10.f;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return .7f ;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return temArr.count;
    }else{
        return 1;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];

    
    if (indexPath.section == 0) {
        if (indexPath.row != 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@",temArr[indexPath.row]];
            
            cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
            
            cell.textLabel.font = [UIFont systemFontOfSize:16];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        
    }else{
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, SCREEN_WIDTH, cell.contentView.frame.size.height);
        label.text = @"退出登录";
        label.textColor = [UIColor redColor];
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
        
    }
   
    
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
  
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell高度代理
    if (indexPath.row == 1) {
        return 0;
    }else{
        return 44;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableV deselectRowAtIndexPath:indexPath animated:YES];
    //cell点击事件
    if (indexPath.section == 0) {
        
        if(indexPath.row==4){
            CGFloat yyCaCheSize = [QSHCache qsh_GetAllHttpCacheSize];
            
            cacheSize = [[SDImageCache sharedImageCache] getSize]+yyCaCheSize;
            
            NSString *message = [NSString stringWithFormat:@"你有%.2fB缓存需要清除!", cacheSize];
            
            if (cacheSize > (1024 * 1024))
            {
                cacheSize = cacheSize / (1024 * 1024);
                message = [NSString stringWithFormat:@"你有%.2fM缓存需要清除!", cacheSize];
            }
            else if (cacheSize > 1024)
            {
                cacheSize = cacheSize / 1024;
                message = [NSString stringWithFormat:@"你有%.2fKB缓存需要清除!", cacheSize];
            }
            
            if (cacheSize == 0) {
                message = @"你没有缓存需要清除";
            }
            clearAlert.message = message;
            [clearAlert show];
            
        }
        else if (indexPath.row == 3) {
            
            AboutViewController *vc = [[AboutViewController alloc]initWithNibName:nil bundle:nil];
            
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 2){
            
            [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
            [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
            
            [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
                //在回调里面获得点击的
                if (platformType == UMSocialPlatformType_UserDefine_Begin+2) {
                    NSLog(@"点击演示添加Icon后该做的操作");
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                    });
                }else{
                    
                    [self shareWebPageToPlatformType:platformType];
                }
            }];


        }else if (indexPath.row == 1){
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
           // [app VersionButton];
        }else if (indexPath.row == 0){
            
            
            AccountSecurityTableViewController *vc = [[AccountSecurityTableViewController alloc]init];
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
    }else if (indexPath.section==1) {
        //退出按钮
        
        [alert show];
        
        
    }
    
}

#pragma mark - UIalertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        if (alertView == alert) {
            //退出事件
            SPUserModel *model = [SPUserModel getUserLoginModel];
            
            [model delUserLoginModel];
            
            [QSHCache qsh_RemoveAllCache];
            
            [[SDImageCache sharedImageCache]clearMemory];
            
            [[SDImageCache sharedImageCache] cleanDisk];
            
            [GeTuiSdk unbindAlias:model.userid andSequenceNum:model.userid];
            
            [(AppDelegate*)[UIApplication sharedApplication].delegate setLoginVCWithRootViewC];

        }else{
            //清除缓存
            CGFloat yyCaCheSize = [QSHCache qsh_GetAllHttpCacheSize];
            
            cacheSize = [[SDImageCache sharedImageCache] getSize]+yyCaCheSize;

            NSString *message = [NSString stringWithFormat:@"你已清除%.2fB缓存。", cacheSize];
            
            if (cacheSize > (1024 * 1024))
            {
                cacheSize = cacheSize / (1024 * 1024);
                message = [NSString stringWithFormat:@"你已清除%.2fM缓存。", cacheSize];
            }
            else if (cacheSize > 1024)
            {
                cacheSize = cacheSize / 1024;
                message = [NSString stringWithFormat:@"你已清除%.2fKB缓存。", cacheSize];
            }
            
            if (cacheSize > 0) {
                
                [SPSVProgressHUD showSuccessWithStatus:message];
                
                //[FTIndicator showSuccessWithMessage:message];
            }
            [QSHCache qsh_RemoveAllCache];
            
            [SPSDWebImage clearDiskImages];
        }
        
    }else{
        
    }
}

#pragma mark - share

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //NSLog(@"formtype is %ld",platformType);
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    //NSString* thumbURL =  UMS_THUMB_IMAGE;
    
    //[image sd_setImageWithURL:[NSURL URLWithString:m.url] placeholderImage:[UIImage imageNamed:@"暂无图片1@2x"]];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:[UIImage imageNamed:@"净喜Logo"]];

    //设置网页地址
    shareObject.webpageUrl = apkurl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //[self alertWithError:error];
    }];
}


- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}

@end
