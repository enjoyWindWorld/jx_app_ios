//
//  MAddImageCell.h
//  newElementHospital
//
//  Created by Wind on 2015/11/21.
//  Copyright © 2016年 szxys.com. All rights reserved.
//

#import "MAddImageCell.h"

@implementation MAddImageCell

@synthesize addButton;

- (void)awakeFromNib {
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}


//-(void)mInit
//{
//    addButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addButton setBackgroundImage:[UIImage imageNamed:@"icon_addpic.png"] forState:UIControlStateNormal];
//    addButton.frame = CGRectMake(0, 0, 70, 70);
//    [self addSubview:addButton];
//    
//    messLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 155, 20)];
//    messLabel.font = [UIFont systemFontOfSize:14];
//    messLabel.textColor = KAuxiliaryTextColor;
//    messLabel.textAlignment = NSTextAlignmentCenter;
//    messLabel.text = @"添加图片(最多添加8张)";
//    [self addSubview:messLabel];
//    
//}
//-(void)setAddButtonFramePoint:(CGPoint)point
//{
//    addButton.frame = CGRectMake(point.x, point.y, addButton.width, addButton.height);
//    if (point.x==0) {
//        messLabel.hidden = YES;
//        self.frame = CGRectMake(self.x, self.y, addButton.width, addButton.height);
//        
//    }else{
//        messLabel.hidden = NO;
//        messLabel.frame = CGRectMake(0, addButton.y+addButton.height+5, messLabel.width, messLabel.height);
//        self.frame = CGRectMake(self.x, self.y, messLabel.width, addButton.y+addButton.height+messLabel.height);
//    }
//}
@end
