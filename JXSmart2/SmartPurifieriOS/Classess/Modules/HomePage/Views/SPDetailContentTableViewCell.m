//
//  SPDetailContentTableViewCell.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/18.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPDetailContentTableViewCell.h"
#import "SPPurifierModel.h"
#import "SPUserModel.h"
#define RectWithAttributeName(text, maxSize, font) [text length] > 0 ? [text boundingRectWithSize:CGSizeMake(maxSize, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading) attributes:@{ NSFontAttributeName : font } context:nil].size : CGSizeZero

@implementation SPDetailPriceTypeViewCell




@end

@implementation SPDetailColorCollectionViewCell




@end

@interface SPDetailContentTableViewCell ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>




@end


@implementation SPDetailContentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.MyCollectionView.alwaysBounceHorizontal = YES ;
    // Initialization code
}

-(void)setModel:(SPPurifierModel *)model{

    _model = model ;
    
//    [_MyCollectionView reloadData];
    
//    if (_model.PricceArr.count>0) {
//        
//        _yearFreeButton.selected = _model.costType==ClarifierCostType_YearFree?YES:NO;
//        
//        _trafficFreeButton.selected = _model.costType==ClarifierCostType_TrafficFree?YES:NO;
//        
//        for (SPProducePayTypePriceModel * Pricemodel in _model.PricceArr ) {
//            
//            NSString * free = [NSString stringWithFormat:@"%.2f",[Pricemodel.price floatValue]];
//           
//            if ((IS_IPHONE_5 || IS_IPHONE_4_OR_LESS)&&free.length>6) {
//                
//                _trafficFreeButton.titleLabel.font = [UIFont systemFontOfSize:14];
//                
//                _yearFreeButton.titleLabel.font = [UIFont systemFontOfSize:14];
//            }
//            
//            if (Pricemodel.paytype==ClarifierCostType_YearFree) {
//                
//                NSString * Trafree = [NSString stringWithFormat:@"包年费用:¥ %.2f元",[Pricemodel.price floatValue]];
//                
//                [_yearFreeButton setTitle:Trafree forState:UIControlStateNormal];
//                
//                [_yearFreeButton setTitle:Trafree forState:UIControlStateSelected];
//                
//                
//            }else if (Pricemodel.paytype==ClarifierCostType_TrafficFree){
//                
//                NSString * Trafree = [NSString stringWithFormat:@"流量预付:¥ %.2f元",[Pricemodel.price floatValue]];
//                
//                [_trafficFreeButton setTitle:Trafree forState:UIControlStateNormal];
//                
//                [_trafficFreeButton setTitle:Trafree forState:UIControlStateSelected];
//
//            }
//            
//        }
//    }
    
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (!_model) {
    
        return self.imageColorArr.count;
    }else{
    
        if ([SPUserModel getUserLoginModel]&&[[SPUserModel getUserLoginModel].userid isEqualToString:JX_TEST_USER_ID]) {
            
            return _model.PricceArr.count;
        }
        
        return 1;
//        return _model.PricceArr.count;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (!_model) {
        
        SPDetailColorCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELLid" forIndexPath:indexPath];
        
        SPProduceColorModel * model = self.imageColorArr[indexPath.row];
        
        cell.colorNameLabel.text = model.pic_color;
        
        cell.colorImageView.layer.masksToBounds = YES ;
        
        cell.colorImageView.layer.cornerRadius = cell.colorImageView.size.height/2;
        
        if (model.isSelect) {
            
            cell.colorImageView.image = [UIImage imageNamed:@"icon_selected"];
            
        }else{
            cell.colorImageView.image = [UIImage imageNamed:@"icon_default"];
        }
        
        NSString * colorstr = model.tone;
        
        if (colorstr.length==0) {
            
            return  cell;
        }
        
        //    cell.colorNameLabel.textColor = [UIColor colorWithHexString:colorstr];
        
        cell.colorImageView.backgroundColor = [UIColor colorWithHexString:colorstr];
        
        return cell ;
    }else{
        
        SPDetailPriceTypeViewCell * acell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELLFREE" forIndexPath:indexPath];
        
        SPProducePayTypePriceModel * Pricemodel   =  _model.PricceArr[indexPath.row];
        
        NSString * freeType = Pricemodel.paytype==ClarifierCostType_YearFree?@"包年费用:¥ ":@"流量预付:¥ ";
        
        NSString * free = [NSString stringWithFormat:@"%@%.2f",freeType,[Pricemodel.price floatValue]];
        
        [acell.priceButton setTitle:free forState:UIControlStateNormal];
        
        if (Pricemodel.isSelect) {
            
            [acell.priceButton setBackgroundImage:[UIImage imageNamed:@"OrangeChecked"] forState:UIControlStateNormal];
            
            [acell.priceButton setTitleColor:[UIColor colorWithHexString:@"FD6212"] forState:UIControlStateNormal];
            
        }else{
            [acell.priceButton setBackgroundImage:[UIImage imageNamed:@"OrangeCheck"] forState:UIControlStateNormal];
            
            [acell.priceButton setTitleColor:[UIColor colorWithHexString:@"777777"] forState:UIControlStateNormal];
            
        }
        
//        [acell.priceButton setTitle:free forState:UIControlStateSelected];
//        
//        acell.priceButton.selected = Pricemodel.isSelect;
        
        return acell;
    }
    

}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (!_model) {
    
        return CGSizeMake(40, 90);
    }
    
    SPProducePayTypePriceModel * Pricemodel   =  _model.PricceArr[indexPath.row];
    
    NSString * freeType = Pricemodel.paytype==ClarifierCostType_YearFree?@"包年费用:¥ ":@"流量预付:¥ ";
    
    NSString * free = [NSString stringWithFormat:@"%@%.2f",freeType,[Pricemodel.price floatValue]];
    
    CGSize size = RectWithAttributeName(free,SCREEN_WIDTH,[UIFont systemFontOfSize:15]);
    
    return CGSizeMake(size.width+10, 35);
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (!_model) {
        
        [self.imageColorArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SPProduceColorModel * model = obj;
            
            model.isSelect = NO ;
            
            if (idx == indexPath.row) {
                
                model.isSelect = YES ;
            }
            
        }];
        
    }else{
        
        [_model.PricceArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SPProducePayTypePriceModel * Pricemodel  = obj;
            
            Pricemodel.isSelect = NO ;
            
            if (idx == indexPath.row) {
                
                Pricemodel.isSelect = YES ;
            }
        }];
        
        SPProducePayTypePriceModel * Pricemodel   =  _model.PricceArr[indexPath.row];
        
        _model.costType = Pricemodel.paytype;
        
    }
    
    
    [collectionView reloadData];
    
    if (_chooseHandler) {
        
        _chooseHandler(indexPath);
    }
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//    return CGSizeMake(SCREEN_WIDTH, 40);
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
