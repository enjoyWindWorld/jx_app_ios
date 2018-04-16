//
//  SPDetailContentTableViewCell.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/18.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPPurifierModel;


@interface SPDetailPriceTypeViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *priceButton;

@end


@interface SPDetailColorCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *colorNameLabel;


@property (weak, nonatomic) IBOutlet UIImageView *colorImageView;

@property (weak, nonatomic) IBOutlet UIButton *priceButton;

@end



@interface SPDetailContentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *bottomLine;

@property (weak, nonatomic) IBOutlet UILabel *subContentLabel;

@property (weak, nonatomic) IBOutlet UICollectionView *MyCollectionView;

@property (weak, nonatomic) IBOutlet UIButton *yearFreeButton;

@property (weak, nonatomic) IBOutlet UIButton *trafficFreeButton;

@property (nonatomic,strong) SPPurifierModel * model ;

@property (nonatomic,strong) NSMutableArray * imageColorArr;

@property (nonatomic,copy) void(^chooseHandler)(NSIndexPath*indexPath);

@end

