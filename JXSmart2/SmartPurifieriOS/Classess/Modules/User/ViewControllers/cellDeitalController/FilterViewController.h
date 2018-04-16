//
//  FilterViewController.h
//  SmartPurifieriOS
//
//  Created by Mray-mac on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *filterNumOne;
@property (weak, nonatomic) IBOutlet UILabel *filterNumTwo;
@property (weak, nonatomic) IBOutlet UILabel *filterNumThree;
@property (weak, nonatomic) IBOutlet UILabel *filterNumFour;
@property (weak, nonatomic) IBOutlet UILabel *filterNumFive;


@property (weak, nonatomic) IBOutlet UIView *lineOne;
@property (weak, nonatomic) IBOutlet UIView *lineTwo;
@property (weak, nonatomic) IBOutlet UIView *lineThree;
@property (weak, nonatomic) IBOutlet UIView *lineFour;
@property (weak, nonatomic) IBOutlet UIView *lineFive;

@property (nonatomic,retain) NSString *filterID;

@property (nonatomic,copy) NSString *filterTitle;
@property (nonatomic,copy) NSString *filterNumber;




@end
