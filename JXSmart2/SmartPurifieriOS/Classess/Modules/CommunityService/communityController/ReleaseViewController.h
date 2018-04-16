//
//  ReleaseViewController.h
//  EBaby
//
//  Created by Mray-mac on 16/11/15.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"

@interface ReleaseViewController : SPBaseViewController

//@property (nonatomic,copy) NSString * categoryid;

@property (nonatomic, copy) void (^block)(BOOL isRefresh);

@end
