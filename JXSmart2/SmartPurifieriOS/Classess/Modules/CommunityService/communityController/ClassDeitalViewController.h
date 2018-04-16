//
//  ClassDeitalViewController.h
//  EBaby
//
//  Created by Mray-mac on 16/11/15.
//  Copyright © 2016年 ming yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPBaseViewController.h"

@interface ClassDeitalViewController : SPBaseViewController

@property (nonatomic, copy) void (^complationBlock)(NSString *categoryId,NSString* content,NSArray*imageArr);

@property (nonatomic,strong) NSArray * imageArr ;

@property (nonatomic,copy) NSString * categoryId ;

@property (nonatomic,copy) NSString * serviceContent ;

@end
