//
//  JXCommunityTopItemView.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/8.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PushBtnModel;
@interface JXCommunityTopItemView : UIView

-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray*)dataArr;

-(void)showComunityView:(NSString*)chooseIdentifier  animated:(BOOL)animated completion:(void (^ __nullable)(PushBtnModel*Model))completion;

-(void)dissMissWithAnimated:(BOOL)animated;


@end



#pragma mark - JXCommunityTopMenuview

@interface JXCommunityTopMenuView: UIView

-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray*)dataArr;

@property (nonatomic,strong) NSArray * datas ;

@property (nonatomic,copy)  void(^complationHandle)(PushBtnModel*model);

-(void)chooseIdentifier:(NSString*)identifier;

@end
