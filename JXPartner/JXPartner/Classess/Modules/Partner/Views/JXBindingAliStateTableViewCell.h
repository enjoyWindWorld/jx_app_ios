//
//  JXBindingAliStateTableViewCell.h
//  JXPartner
//
//  Created by windpc on 2017/8/18.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JXBindingAliStateTableViewCellDelegate <NSObject>

-(void)cell_BindingAliStatetTextChange:(NSString*)text index:(NSIndexPath*)index;

@end


@interface JXBindingAliStateTableViewCell : UITableViewCell<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UILabel *cellLabel;

@property (weak, nonatomic) IBOutlet UITextField *cellText;

@property (nonatomic,strong) NSIndexPath * indexPath ;

@property (nonatomic,weak) id<JXBindingAliStateTableViewCellDelegate> delegate ;

@end
