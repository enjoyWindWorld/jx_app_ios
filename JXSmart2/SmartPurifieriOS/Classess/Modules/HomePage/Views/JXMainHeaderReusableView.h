//
//  JXMainHeaderReusableView.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXMainHeaderReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UIView *colorView;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (weak, nonatomic) IBOutlet UIButton *descBtn;
@end
