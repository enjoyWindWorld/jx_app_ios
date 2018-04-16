//
//  SPHomeDetailHeaderFooterView.h
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPHomeDetailHeaderFooterView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *headerContent;

@property(nonatomic,assign) NSInteger sectionIndex ;


@end
