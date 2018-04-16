//
//  JXNewAfterTableViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/11/8.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAddImageCollectionView.h"

@interface JXNewAfterTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *left_label;

@property (weak, nonatomic) IBOutlet UILabel *right_label;


@property (weak, nonatomic) IBOutlet MAddImageCollectionView *addImage;

@end
