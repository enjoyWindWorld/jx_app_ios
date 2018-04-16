//
//  JXDetailDataColoCostTypeCell.h
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/27.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JXDetailDataColoCostTypeCellDelegate <NSObject>

-(void)cell_colorChange:(NSString*)tone;

@end

@interface JXDetailDataColoCostTypeCell : UICollectionViewCell

@property (nonatomic,weak) id  model ;

@property (nonatomic,weak) id<JXDetailDataColoCostTypeCellDelegate> delegate ;

@property (weak, nonatomic) IBOutlet UIButton *btn;


@end
