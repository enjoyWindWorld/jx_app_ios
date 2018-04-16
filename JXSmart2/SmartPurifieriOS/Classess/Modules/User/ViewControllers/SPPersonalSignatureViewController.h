//
//  SPPersonalSignatureViewController.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/18.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseViewController.h"
/**
 个人签名
 */
@interface SPPersonalSignatureViewController : SPBaseViewController
@property (nonatomic,retain) NSString *titleStr;
@property (nonatomic,retain) NSString *userid;
@property (nonatomic,retain) NSString *textStr;

@property (nonatomic, copy) void (^contentBlock)(NSString *content);
@property (nonatomic, copy) void (^titleBlock)(NSString *title);
@property (nonatomic, copy) void (^optionBlock)(BOOL option);

@end
