//
//  MyClarifierWriteCostTableViewCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyClarifierWriteCostTableViewCell.h"

@implementation MyClarifierWriteCostTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



+(void)configcellWith:(SPClarifierWirtePayModel*)model cell:(MyClarifierWriteCostTableViewCell*)cell{
    
    if (!model.addressName) {
        
        cell.addressLabel.text = @"地址不存在";
        
    }else{
        
        NSString * name = model.addressName ;
        
        NSString * phone = model.phone ;
        
        NSString * detail = model.detail ;
        
        NSString * address  = [NSString stringWithFormat:@"%@    %@\n%@",name,phone,detail];
        
        NSRange range = [address rangeOfString:[NSString stringWithFormat:@"%@    %@",name,phone]];
        
        NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc] initWithString:address];
        
        NSMutableParagraphStyle   *paragraphStyle   = [[NSMutableParagraphStyle alloc] init];
        
        //行间距
        [paragraphStyle setLineSpacing:5.0];
        
        
        [attstr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, address.length)];
        
        [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:range];
        
        range = [address rangeOfString:[NSString stringWithFormat:@"%@",detail]];
        
        [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
        
        [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"777777"] range:range];
        
        cell.addressLabel.attributedText = attstr;
    }
    
}

+(MyClarifierWriteCostTableViewCell*)tableView:(UITableView*)tableView CellWithIndex:(NSIndexPath*)indexPath itemModel:(SPClarifierWirtePayModel*)model{
    
    
    if (indexPath.section==0) {
       
        MyClarifierWriteCostTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELLNOaddress" forIndexPath:indexPath];
        
        [[self class] configcellWith:model cell:cell];
        
        return cell;
        
    }
    
    NSString * cellid = [NSString stringWithFormat:@"CELL%ld",indexPath.row];
    
    MyClarifierWriteCostTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    
    if (indexPath.row==1) {
        
        cell.productName.text = [NSString stringWithFormat:@"%@(%@)",model.proname,model.proColor];
       
        [SPSDWebImage SPImageView:cell.productICO imageWithURL:model.prourl placeholderImage:[UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage]];
        
    }
    else if (indexPath.row==3){
        
        cell.productYearfree.text = model.yearfree;
        
        if (model.type == ClarifierCostType_YearFree) {
            
            cell.yearfreeICO.image = [UIImage imageNamed:@"CheckedBlue"];
            
        }else{
        
            cell.yearfreeICO.image = [UIImage imageNamed:@"CheckNormal"];
        }
        
        
    }else if (indexPath.row==4){
        
        cell.productTrafficfree.text = model.trafficfree;
        
        if (model.type == ClarifierCostType_YearFree) {
            
            cell.trafficIco.image = [UIImage imageNamed:@"CheckNormal"];
            
        }else{
            
            cell.trafficIco.image = [UIImage imageNamed:@"CheckedBlue"];
        }
    }
    
    return cell;
    
}


+(CGFloat)tableView:(UITableView*)tableView heightForIndex:(NSIndexPath*)indexPath itemModel:(id)model{
    
    if (indexPath.section==0) {
        
        if (!model) {
            
            return 60;
        }

        CGFloat heght = [tableView fd_heightForCellWithIdentifier:@"CELLNOaddress" configuration:^(MyClarifierWriteCostTableViewCell* cell) {
            
            [MyClarifierWriteCostTableViewCell configcellWith:model cell:cell];
        }];
        
        return  heght+20;
        
    }
    
    if (indexPath.row==0||indexPath.row==2) return 35;
    
    if (indexPath.row==1) return 80;
    
    return 50.f;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
