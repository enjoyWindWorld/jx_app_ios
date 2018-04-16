//
//  JXDetailTableHeaderView.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/25.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXDetailTableHeaderView : UIView

@property (nonatomic,strong) NSArray * colorArr;

@property (nonatomic,strong) NSArray * priceArr ;

@property (nonatomic,copy) NSString * name ;

-(instancetype)initWithFrame:(CGRect)frame;

@end
