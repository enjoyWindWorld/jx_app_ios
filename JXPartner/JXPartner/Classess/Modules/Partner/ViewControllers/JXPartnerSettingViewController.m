//
//  JXPartnerSettingViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/16.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXPartnerSettingViewController.h"
#import "SPUserModel.h"
#import "QSHCache.h"
#import <GTSDK/GeTuiSdk.h>
#import "AppDelegate.h"
#import <UShareUI/UMSocialUIManager.h>
#import <UShareUI/UShareUI.h>

@interface JXPartnerSettingViewController ()

@property (nonatomic,strong) NSMutableArray * itemArr ;

@end

@implementation JXPartnerSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
}


#pragma mark - 退出登录
- (IBAction)loginOutAction:(id)sender {
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示"message:@"退出登录"preferredStyle:UIAlertControllerStyleAlert];
    
    __weak typeof(self) weakself = self ;
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        SPUserModel * model = [SPUserModel fetchPartnerModelDF] ;

        [QSHCache qsh_RemoveAllCache];
        
        [UIImageView cleanImage];
        
        [GeTuiSdk unbindAlias:model.partnerNumber andSequenceNum:model.partnerNumber andIsSelf:NO];
        
        [(AppDelegate*)[UIApplication sharedApplication].delegate setLoginVCWithRootViewController];
       
        [SPUserModel delCurrentPartnerModel];
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.itemArr.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
     
     cell.selectionStyle = UITableViewCellSelectionStyleNone ;
     
     if (self.itemArr.count > indexPath.row) {
         
         cell.textLabel.text = self.itemArr[indexPath.row];
         
         cell.accessoryType = indexPath.row == 2 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
         
     }
     return cell;

 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 3) {
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
    }
    
    if (indexPath.row == 1) {
        //清除缓存
        CGFloat yyCaCheSize = [QSHCache qsh_GetAllHttpCacheSize];
        
        CGFloat cacheSize = [[SDImageCache sharedImageCache] getSize]+yyCaCheSize;
        
        NSString *message = [NSString stringWithFormat:@"已清除%.2fB缓存", cacheSize];
        
        if (cacheSize > (1024 * 1024))
        {
            cacheSize = cacheSize / (1024 * 1024);
            message = [NSString stringWithFormat:@"已清除%.2fM缓存", cacheSize];
        }
        else if (cacheSize > 1024)
        {
            cacheSize = cacheSize / 1024;
            message = [NSString stringWithFormat:@"已清除%.2fKB缓存", cacheSize];
        }
        if (cacheSize == 0) {
            
            message = @"你没有缓存需要清除";
        }
        
        [QSHCache qsh_RemoveAllCache];
        
        [[SDImageCache sharedImageCache] clearDisk];
        
        [self makeToast:message];
    }
    
    if (indexPath.row == 0) {
        
        [self performSegueWithIdentifier:@"JXModifyPasswordViewController" sender:nil];
    }
    
}


- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //NSLog(@"formtype is %ld",platformType);
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    //NSString* thumbURL =  UMS_THUMB_IMAGE;
    
    //[image sd_setImageWithURL:[NSURL URLWithString:m.url] placeholderImage:[UIImage imageNamed:@"暂无图片1@2x"]];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用净喜" descr:@"欢迎使用净喜App" thumImage:[UIImage imageNamed:@"Icon"]];
    
    //设置网页地址
    shareObject.webpageUrl = @"https://itunes.apple.com/us/app/id1281842107";
    
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



#pragma mark - agetter setter
-(NSMutableArray *)itemArr{

    if (!_itemArr) {
        
        _itemArr = [NSMutableArray arrayWithObjects:@"修改密码",@"清除缓存",[NSString stringWithFormat:@"版本号(%@)",FETCHCURRENTVERSION],@"分享应用",nil];
    }
    
    return _itemArr ;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
