//
//  JXCommunityTextTableViewCell.h
//  SmartPurifieriOS
//
//  Created by Wind on 2017/6/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXCommunityTextTableViewCellDelegate <NSObject>

-(void)cell_communityPushTextEndChange:(NSIndexPath*)index text:(NSString*)text;

@end

@interface JXCommunityTextTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

@property (nonatomic,strong) NSIndexPath *  indexpath;

@property (nonatomic,weak) id<JXCommunityTextTableViewCellDelegate> delegate;


@end
