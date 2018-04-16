//
//  SPMapAroundInfoViewController.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/17.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPBaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@class SPAddressInfoModel;

@interface SPMapAroundInfoViewController : SPBaseViewController

@property (nonatomic,copy) void(^handleAction)(SPAddressInfoModel*model);

@property (nonatomic,assign)  CLLocationCoordinate2D endPoint;

@property (nonatomic,copy) NSString * addressname ;

@end
