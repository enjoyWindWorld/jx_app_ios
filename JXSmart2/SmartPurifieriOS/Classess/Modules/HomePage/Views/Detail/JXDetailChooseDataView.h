//
//  JXDetailChooseDataView.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/25.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPPurifierModel;

typedef NS_ENUM(NSInteger,ButtonActionType){
    
    ButtonActionType_ADDSHOPCAR = 10,
    
    ButtonActionType_RIGHTPAY = 20,
};

@protocol JXDetailChooseDataViewDelegate <NSObject>


-(void)dataview_datachangewithPrice:(NSString*)price url:(NSString*)url number:(NSInteger)number  ppdnumber:(NSInteger)ppdnumber costpay:(NSInteger)costpay color:(NSString*)color actionType:(ButtonActionType)actionType;

@end

@interface JXDetailChooseDataView : UIView

@property (nonatomic,strong) SPPurifierModel * model ;

@property (nonatomic,weak) id <JXDetailChooseDataViewDelegate>delegate ;

-(void)show;

-(void)dissMiss;

@end
