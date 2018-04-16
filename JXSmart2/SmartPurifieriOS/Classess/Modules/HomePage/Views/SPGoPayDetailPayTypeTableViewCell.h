//
//  SPGoPayDetailPayTypeTableViewCell.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SPHomeGoPayDeatailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *PayDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *payCostLabel;

@end


@interface SPGoPayDetailPayTypeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *typeName;

@property (weak, nonatomic) IBOutlet UIImageView *isCheckIco;

@property(nonatomic,assign) BOOL isCheck ;

@end
