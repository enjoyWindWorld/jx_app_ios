//
//  JXDetailDataParameterForCostTypeCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/27.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"

@protocol JXDetailDataParameterForCostTypeCellDelegate <NSObject>

- (void)cell_pp_numberButton:(__kindof UIView *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus item:(NSInteger)item;

- (void)cell_costTypeChange:(NSInteger)item;


@end

@interface JXDetailDataParameterForCostTypeCell : UICollectionViewCell<PPNumberButtonDelegate>

@property (weak, nonatomic) IBOutlet PPNumberButton *numberBtn;

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;


@property (nonatomic,assign) NSInteger item ;

@property (nonatomic,weak) id <JXDetailDataParameterForCostTypeCellDelegate> delegate;

@end
