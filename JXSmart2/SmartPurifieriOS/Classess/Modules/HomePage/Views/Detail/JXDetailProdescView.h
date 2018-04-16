//
//  JXDetailProdescView.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/5.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPPurifierModel;
@interface JXDetailProdescView : UIView

@property (nonatomic,strong) SPPurifierModel * model;

-(void)show;

-(void)dissMiss;

@end
