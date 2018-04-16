//
//  JFLocation.m
//  Football
//
//  Created by 张志峰 on 16/6/7.
//  Copyright © 2016年 zhangzhifeng. All rights reserved.
//

#import "JFLocation.h"

#import <CoreLocation/CoreLocation.h>
#define KCURRENTCITYINFODEFAULTS [NSUserDefaults standardUserDefaults]

@interface JFLocation ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation JFLocation

- (instancetype)init {
    if (self = [super init]) {
        [self startPositioningSystem];
    }
    return self;
}

- (void)startPositioningSystem {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(locating)]) {
            [self.delegate locating];
        }
    });
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            
            NSString * city  = placemark.locality;
            
            if (city.length==0) {
                
                city = placemark.administrativeArea;
            }
            
            if ([city isEqual:[NSNull null]]|| [city isEqualToString:@"(null)"]) {
                
                continue;
            }
            NSString * subLocality  = placemark.subLocality;
            
            if (subLocality.length==0) {
                
                subLocality = @"";
            }
            
            //+22.60729250,+113.83773806
            NSLog(@"**  %f  %f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude);
            
            
            
            NSDictionary *location =@{@"City":city,@"subLocality":subLocality};
            
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                if (self.delegate && [self.delegate respondsToSelector:@selector(currentLocation:)]) {
                    
                    [KCURRENTCITYINFODEFAULTS  setObject:@(placemark.location.coordinate.latitude) forKey:CPMMUNITYlatitude];
                    [KCURRENTCITYINFODEFAULTS setObject:@(placemark.location.coordinate.longitude) forKey:CPMMUNITYlongitude];
                    [KCURRENTCITYINFODEFAULTS synchronize];
                    
                    [self.delegate currentLocation:location];
                }
            });
        }
    }];
    [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code] == kCLErrorDenied) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(refuseToUsePositioningSystem:)]) {
            [self.delegate refuseToUsePositioningSystem:@"已拒绝使用定位系统"];
        }
    }
    if ([error code] == kCLErrorLocationUnknown) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            if (self.delegate && [self.delegate respondsToSelector:@selector(locateFailure:)]) {
                [self.delegate locateFailure:@"无法获取位置信息"];
            }
        });
    }
}

@end
