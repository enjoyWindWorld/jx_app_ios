//
//  ChooseLocationView.h
//  ChooseLocation
//
//  Created by Sekorm on 16/8/22.
//  Copyright © 2016年 HY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseLocationView : UIView

@property (nonatomic, copy) NSString * address;

//ChooseLocationView * chac = [[ChooseLocationView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
//
//[chac setChooseFinish:^(NSArray *arrData) {
//    
//    NSLog(@"数据为  %@",arrData);
//}];
//
//
//[chac showInView:self.view];
/**
 一个包含省市区的组
 */
@property (nonatomic, copy) void(^chooseFinish)(NSArray*addressInfo);

@property (nonatomic,copy) NSString * areaCode;


-(void)showInView:(UIView*)maskView;

-(void)disMiss;

@end
