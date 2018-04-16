//
//  JXMainTodayTradingCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/24.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXWaterQualityReportModel;

@interface JXMainTodayTradingCell : UICollectionViewCell

@property (nonatomic,strong) JXWaterQualityReportModel * model ;

@property (weak, nonatomic) IBOutlet UILabel *waterFirst;

@property (weak, nonatomic) IBOutlet UILabel *waterTwo;

@property (weak, nonatomic) IBOutlet UILabel *waterThree;


@property (weak, nonatomic) IBOutlet UILabel *reportFirst;

@property (weak, nonatomic) IBOutlet UILabel *reportTwo;

@property (weak, nonatomic) IBOutlet UILabel *reportThree;

@end
