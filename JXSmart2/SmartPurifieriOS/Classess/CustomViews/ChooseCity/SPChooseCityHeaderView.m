//
//  SPChooseCityHeaderView.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPChooseCityHeaderView.h"

@implementation SPChooseCityHeaderView


- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.titleLabel];
    }
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(10, 0, self.frame.size.width - 10, self.frame.size.height)];
}
#pragma mark - Getter
- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_titleLabel setTextColor:[UIColor colorWithHexString:@"777777"]];
    }
    return _titleLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
