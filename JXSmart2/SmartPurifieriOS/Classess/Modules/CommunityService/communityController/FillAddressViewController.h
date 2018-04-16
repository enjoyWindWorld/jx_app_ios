//
//  FillAddressViewController.h
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/23.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"

@interface FillAddressViewController : SPBaseViewController

@property (nonatomic, copy) void (^block)(NSString *str);

- (BOOL) isBlankString:(NSString *)string;


@end
