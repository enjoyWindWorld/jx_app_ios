//
//  SPWritePayTableViewCell.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/29.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPWritePayTableViewCell.h"
#import "SPWirtePayModel.h"

#define RectWithAttributeName(text, maxSize, font) [text length] > 0 ? [text boundingRectWithSize:CGSizeMake(maxSize, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading) attributes:@{ NSFontAttributeName : font } context:nil].size : CGSizeZero

@implementation SPWritePayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(void)configcellWith:(SPWirtePayModel*)model cell:(SPWritePayTableViewCell*)cell{
    
    if (!model.addressModel) {
        
        cell.chooseAddressLabel.text = @"选择家庭地址";
        
    }else{
        
        NSString * name = model.addressModel.name ;
        
        NSString * phone = model.addressModel.phone ;
        
        NSString * area = model.addressModel.area ;
        
        NSString * detail = model.addressModel.detail ;
        
        NSString * address  = [NSString stringWithFormat:@"%@    %@\n%@%@",name,phone,area,detail];
        
        NSRange range = [address rangeOfString:[NSString stringWithFormat:@"%@    %@",name,phone]];
        
        NSMutableAttributedString * attstr = [[NSMutableAttributedString alloc] initWithString:address];
        
        NSMutableParagraphStyle   *paragraphStyle   = [[NSMutableParagraphStyle alloc] init];
        
        //行间距
        [paragraphStyle setLineSpacing:5.0];
        
        
        [attstr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, address.length)];
        
        [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:range];
        
        range = [address rangeOfString:[NSString stringWithFormat:@"%@%@",area,detail]];
        
        [attstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
        
        [attstr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"777777"] range:range];
        
        cell.chooseAddressLabel.attributedText = attstr;
    }
    
}

+(SPWritePayTableViewCell*)tableView:(UITableView*)tableView CellWithIndex:(NSIndexPath*)indexPath itemModel:(SPWirtePayModel*)model{


    if (indexPath.section==0) {
        SPWritePayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELLNOaddress" forIndexPath:indexPath];
        
        [[self class] configcellWith:model cell:cell];
        
        return cell;
        
    }
    
    NSString * cellid = [NSString stringWithFormat:@"CELL%ld",indexPath.row];
    
    SPWritePayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    
    if (indexPath.row==1) {

        NSString * imgUrl = @"";
        
        NSString * proDuName = @"" ;
        
        for (SPProduceColorModel * corlor in model.payPurifierModel.colorArr) {
            
            if (corlor.isSelect) {
                
                imgUrl = [[corlor.url componentsSeparatedByString:@","] firstObject];
                
                proDuName = corlor.pic_color;
            }
            
        }

        [SPSDWebImage SPImageView: cell.choosePDICO imageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"productplaceholderImage"]];
        
        cell.choosrPDName.text = [NSString stringWithFormat:@"%@(%@)",model.payPurifierModel.name,proDuName];
        
        NSString * freedetail = model.payPurifierModel.costType==ClarifierCostType_YearFree?@"包年费用":@"流量预付";
        
        NSString * money = nil;
        
        for (SPProducePayTypePriceModel * PriceModel in model.payPurifierModel.PricceArr) {
            
            if (PriceModel.paytype ==model.payPurifierModel.costType) {
                
                money = [NSString stringWithFormat:@"¥%@元",PriceModel.price];
            
            }
        
        }
    
        
        cell.choosePDCost.text = [NSString stringWithFormat:@"%@：%@",freedetail,money];
 
    }
    else if (indexPath.row==2) {
        
        //PM
        cell.choosePMText.text = model.payPmCode;
        
        
    }else if (indexPath.row==3){
        
        NSString * string =model.payTime;
        
        cell.chooseTimeLabel.text = string;
        
        if ([string isEqualToString:@"选择安装时间"]) {
            
            cell.chooseTimeLabel.textColor = [UIColor colorWithHexString:@"B2B8C2"];
            
        }else{
            cell.chooseTimeLabel.textColor = [UIColor colorWithHexString:@"333333"];
        }
        
    }else if (indexPath.row==4){
        
//        cell.chooseMoneyType.text = model.payPurifierModel.costType==ClarifierCostType_YearFree?@"包年费用":@"流量预付";
        
        cell.chooseMoneyType.text = @"支付费用";
        
        cell.chooseMoneyLabel.text = [[self class]getMoneyStringModel:model];
    }
    
    return cell;

}


+(NSString*)getMoneyStringModel:(SPWirtePayModel*)model{

    NSString * moneyFeree = @"";
    
    for (SPProducePayTypePriceModel * PriceModel in model.payPurifierModel.PricceArr) {
        
        if (PriceModel.paytype ==model.payPurifierModel.costType) {
            
            if ([PriceModel.pay_pledge floatValue]>0) {
                
                CGFloat producePrice = [PriceModel.price floatValue] +[PriceModel.pay_pledge floatValue];
                
                moneyFeree = [NSString stringWithFormat:@"¥%.2f元(含押金%@元)",producePrice,PriceModel.pay_pledge];
                
            }else{
            
                moneyFeree = [NSString stringWithFormat:@"¥%@元",PriceModel.price];

            }
            


        }
        
    }
    return moneyFeree;
}





+(CGFloat)tableView:(UITableView*)tableView heightForIndex:(NSIndexPath*)indexPath itemModel:(SPWirtePayModel*)model{

    if (indexPath.section==0) {
        
        if (!model.addressModel) {
            
            return 60;
        }
        
        NSString * area = model.addressModel.area ;
        
        NSString * detail = model.addressModel.detail ;
        
        NSString * address  = [NSString stringWithFormat:@"%@%@",area,detail];
//
        CGFloat heght = [tableView fd_heightForCellWithIdentifier:@"CELLNOaddress" configuration:^(SPWritePayTableViewCell* cell) {
            
            [SPWritePayTableViewCell configcellWith:model cell:cell];
        }];
        
//        CGSize size  = RectWithAttributeName(address, SCREEN_WIDTH-52, [UIFont systemFontOfSize:14]);
       
        return  heght+20;
        
    }
    
    if (indexPath.row==0) return 35;
    
    if (indexPath.row==1) return 80;
    
    return 50.f;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
