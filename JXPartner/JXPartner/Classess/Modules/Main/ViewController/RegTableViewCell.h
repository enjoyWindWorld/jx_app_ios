//
//  RegTableViewCell.h
//  JXPartner
//
//  Created by Wind on 2018/5/2.
//  Copyright © 2018年 windpc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXRegTableViewCellTableViewCellDelegate <NSObject>

-(void)cell_RegTextChange:(NSString*)text index:(NSIndexPath*)index;

@end

@interface RegTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;

@property (weak, nonatomic) IBOutlet UITextField *contentText;

@property (nonatomic,strong) NSIndexPath * indexPath ;

@property (nonatomic,strong) UIViewController * vc ;

@property (nonatomic, copy) void(^chooseFinish)(NSArray*addressInfo);


@property (nonatomic,weak) id<JXRegTableViewCellTableViewCellDelegate> delegate ;@end
