//
//  JFCityTableViewCell.m
//  JFFootball
//
//  Created by 张志峰 on 2016/11/21.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFCityTableViewCell.h"

#import "Masonry.h"
#import "JFCityCollectionFlowLayout.h"
#import "JFCityCollectionViewCell.h"
#import "SPUserModel.h"

#define JFRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

NSString * const JFCityTableViewCellDidChangeCityNotification = @"JFCityTableViewCellDidChangeCityNotification";

static NSString *ID = @"cityCollectionViewCell";

@interface JFCityTableViewCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation JFCityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        NSString *SubLocality = _cityNameArray[0];
        //判断是选择的市还是区县
        if ([SubLocality isEqualToString:@"全城"]) {
            _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 16, self.frame.size.width, self.frame.size.height) collectionViewLayout:[[JFCityCollectionFlowLayout alloc] init]];
        }else{
            _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[JFCityCollectionFlowLayout alloc] init]];
        }
        
        [_collectionView registerClass:[JFCityCollectionViewCell class] forCellWithReuseIdentifier:ID];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        
    }
    return _collectionView;
}

- (void)setCityNameArray:(NSArray *)cityNameArray {
    _cityNameArray = cityNameArray;
    [_collectionView reloadData];
}

#pragma mark UICollectionViewDataSource 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _cityNameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JFCityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.title = _cityNameArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SPUserModel *usermodel = [SPUserModel getUserLoginModel];
    
    NSString *cityName = _cityNameArray[indexPath.row];
    
    NSString *SubLocality = _cityNameArray[0];
    //判断是选择的市还是区县
    if ([SubLocality isEqualToString:@"全城"]) {
        //点击的是区县内容
        NSDictionary *cityNameDic = @{@"SubLocality":cityName};
        
        if ([cityName isEqualToString:@"全城"]) {
            //当选择了全城的时候不保存区县
            usermodel.SubLocality = nil;
            
            [usermodel saveUserLoginModel];
        }else{
            usermodel.SubLocality = cityName;
            
            [usermodel saveUserLoginModel];
        }
    
        if (usermodel.city.length > 0) {
            
            //这里是为了没选择城市也有全城的情况不进行通知
             [[NSNotificationCenter defaultCenter] postNotificationName:JFCityTableViewCellDidChangeCityNotification object:self userInfo:cityNameDic];
        }
       
        
    }else{
        //点击的是城市内容
        NSDictionary *cityNameDic = @{@"cityName":cityName};
        
        if (![cityName isEqualToString:@"正在定位..."]) {
            //这里定位没有成功也进行通知
            usermodel.city = cityName;
            
            usermodel.SubLocality = nil;
            
            [usermodel saveUserLoginModel];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:JFCityTableViewCellDidChangeCityNotification object:self userInfo:cityNameDic];
        }
    }

}


@end
