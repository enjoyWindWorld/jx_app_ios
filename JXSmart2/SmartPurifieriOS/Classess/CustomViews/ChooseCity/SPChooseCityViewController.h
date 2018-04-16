//
//  SPChooseCityViewController.h
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPChooseCityDelegate.h"

@interface SPLocationManger : NSObject

@property (nonatomic ,copy) void(^locationEndBlock)(NSMutableArray*locationModel);


+(instancetype)defaultManager;

-(void)locationStart;

@end


@interface SPChooseCityViewController : UITableViewController

@property (nonatomic, assign) id <SPChooseCityDelegate> delegate;
/*
 *  定位城市id
 */
@property (nonatomic, strong) NSString *locationCityID;

/*
 *  常用城市id数组,自动管理，也可赋值
 */
@property (nonatomic, strong) NSMutableArray *commonCitys;

/*
 *  热门城市id数组
 */
@property (nonatomic, strong) NSArray *hotCitys;


/*
 *  城市数据，可在Getter方法中重新指定
 */
@property (nonatomic, strong) NSMutableArray *cityDatas;

@end
