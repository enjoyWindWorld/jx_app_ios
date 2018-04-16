//
//  JXShoppingItemTableViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/16.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"


@protocol JXShoppingItemTableViewCellDelegate <NSObject>

-(void)shopcar_numberButtnChange:(NSIndexPath*)indexPath  number:(NSInteger)number;

-(void)shopcar_selectBtnChange:(NSIndexPath*)inexPath select:(BOOL)select;

@end

@interface JXShoppingItemTableViewCell : UITableViewCell<PPNumberButtonDelegate>

@property (nonatomic,weak) id<JXShoppingItemTableViewCellDelegate> delegate ;

@property (nonatomic,strong) id model ;

@property (nonatomic,strong) NSIndexPath * index ;

@property (weak, nonatomic) IBOutlet PPNumberButton *countNumber;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIImageView *ico;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *costTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end
