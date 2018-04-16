//
//  JXPlayerCollectionViewCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/29.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXMovieListModel;

@interface JXPlayerCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;

@property (nonatomic, strong) UIButton *playBtn;
/** model */
@property (nonatomic, strong) JXMovieListModel *model;
/** 播放按钮block */
@property (nonatomic, copy  ) void(^playBlock)(UIButton *);


@end
