//
//  JXPlayerCollectionViewCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/29.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXPlayerCollectionViewCell.h"
#import "Masonry.h"
#import "JXMovieListModel.h"

@implementation JXPlayerCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.topicImageView.userInteractionEnabled = YES;
    
    self.topicImageView.tag = 200;
    
    self.playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.playBtn setImage:[UIImage imageNamed:@"video_list_cell_big_icon"] forState:UIControlStateNormal];
    
    [self.playBtn addTarget:self action:@selector(play:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.topicImageView addSubview:self.playBtn];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self.topicImageView);
        
        make.width.height.mas_equalTo(50);
    }];

}


- (void)setModel:(JXMovieListModel *)model {
      
    [SPSDWebImage SPImageView:self.topicImageView imageWithURL:model.img placeholderImage:[UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage]];
    
    self.titleLabel.text = model.title;
}

- (void)play:(UIButton *)sender {
  
    if (self.playBlock) {
    
        self.playBlock(sender);
    }
}

@end
