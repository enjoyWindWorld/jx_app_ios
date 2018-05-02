//
//  RegTableViewCell.m
//  JXPartner
//
//  Created by Wind on 2018/5/2.
//  Copyright © 2018年 windpc. All rights reserved.
//

#import "RegTableViewCell.h"
#import "ChooseLocationView.h"

@implementation RegTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _contentText.delegate = self ;
    // Initialization code
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_delegate && [_delegate respondsToSelector:@selector(cell_RegTextChange:index:)]) {
        
        [_delegate cell_RegTextChange:textField.text index:_indexPath];
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if (_indexPath.row == 6) {
        
        [_vc.view endEditing:YES];
        
        ChooseLocationView * chac = [[ChooseLocationView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.5)];
        
        [chac setChooseFinish:^(NSArray *arrData) {
            
            NSMutableString * astring = [[NSMutableString alloc] initWithCapacity:0];
            
            for (NSString * string in arrData) {
                
                if (string.length == 0 ) {
                    continue ;
                }
                
                [astring appendFormat:@"%@-",string];

            }
            
            NSString* addressStr = [astring substringToIndex:astring.length-1];
            
            if (_chooseFinish) {
                
                _chooseFinish(arrData);
            }
            
            if (_delegate && [_delegate respondsToSelector:@selector(cell_RegTextChange:index:)]) {
                
                [_delegate cell_RegTextChange:addressStr index:_indexPath];
            }
        }];
        
        
        [chac showInView:_vc.view];
        
        
        return NO ;
    }
    
    
    return YES;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
