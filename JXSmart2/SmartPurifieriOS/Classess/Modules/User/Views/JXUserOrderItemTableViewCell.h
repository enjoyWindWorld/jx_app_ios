//
//  JXUserOrderItemTableViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/22.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXUserItemGroupView : UIView

@property (nonatomic,weak) IBOutlet UIImageView * ico ;

@property (nonatomic,strong) IBOutlet UILabel * titleLabel ;

@end
//



@interface JXUserOrderItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet JXUserItemGroupView *group_view1;

@property (weak, nonatomic) IBOutlet JXUserItemGroupView *group_view2;

@property (weak, nonatomic) IBOutlet JXUserItemGroupView *group_View3;

@property (weak, nonatomic) IBOutlet JXUserItemGroupView *group_view4;


@end
