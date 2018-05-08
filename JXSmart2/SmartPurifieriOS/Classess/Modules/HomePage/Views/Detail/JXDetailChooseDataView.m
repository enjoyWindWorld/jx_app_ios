//
//  JXDetailChooseDataView.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/25.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXDetailChooseDataView.h"
#import "SPSDWebImage.h"
#import "JXLabelReusableView.h"
#import "JXDetailDataParameterForCostTypeCell.h"
#import "JXCountNumberCell.h"
#import "JXDetailDataColoCostTypeCell.h"
#import "SPPurifierModel.h"
#import "JXDetailDataSelectColorTypeCell.h"
#import "UIButton+WEdgeInSets.h"
#import "SPUserModel.h"

#define VIEWMARGIN 10
#define DataCellMiniItemSpace 0
#define DataCellMiniLineSpace 0
#define DataCellMiniNumber 3
#define DATAHEADERSIZE  CGSizeMake(SCREEN_WIDTH, 30);
#define PRODUCTICOHEIGHT 100

#define DATAHEADERTITLEARR @[@"类型",@"颜色",@"交易类型",@"购买数量"]




@interface JXDetailChooseDataView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,JXDetailDataParameterForCostTypeCellDelegate,PPNumberButtonDelegate,JXDetailDataColoCostTypeCellDelegate>

@property (nonatomic,strong) UIView * backView ;

@property (nonatomic,strong) UIImageView * ico ;

@property (nonatomic,strong) UILabel * priceLabel ;

@property (nonatomic,strong) UILabel * dataLabel ;

@property (nonatomic,strong) UIButton * btn  ;

@property (nonatomic,strong) UIButton * rightPaybtn ;

@property (nonatomic,strong) UICollectionView * dataCollection ;

@property (nonatomic,strong) NSMutableArray * costpayArr ;

//用来记录参数
@property (nonatomic,assign) NSInteger ppdnumber ;

@property (nonatomic,assign) NSInteger  number ;

@property (nonatomic,assign) NSInteger costtype ;

@property (nonatomic,copy) NSString * price ;

@property (nonatomic,copy) NSString * url ;

@property (nonatomic,copy) NSString * color ;

@end


@implementation JXDetailChooseDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"232323" alpha:0.5];
        
        self.userInteractionEnabled = YES;
        
        [self initWithUI];
    }
    return self;
}




-(void)initWithUI{
    
    [self addSubview:self.backView];

    [self.backView addSubview:self.ico];
    
    [self.backView addSubview:self.btn];
    
    [self.backView addSubview:self.rightPaybtn];
    
    [self.backView addSubview:self.priceLabel];
    
    [self.backView addSubview:self.dataLabel];
    
    
    UIButton * exit  = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [exit setImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
    
    [exit addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    
    exit.frame = CGRectMake(self.backView.width-30, self.priceLabel.top, 22, 22);
    
    [self.backView addSubview:exit];
    
    //line
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, self.ico.bottom+VIEWMARGIN-1, self.backView.width, 1)];
    
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.backView addSubview:line];
    
    [self.backView addSubview:self.dataCollection];
}

#pragma mark - 点击展示大图
-(void)showAllImage:(UITapGestureRecognizer*)tap{

    
}




#pragma mark - 添加购物车动画
- (void)addShopCarAnimal:(UIButton*)btn
{
    
    btn.enabled = NO;
    
    UIImageView *anImage = [[UIImageView alloc]initWithFrame:self.ico.bounds];
    
    anImage.image = _ico.image;
    
    [self.backView addSubview:anImage];
    
    CABasicAnimation* rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 15];
    
    rotationAnimation.duration = 1.0;
    
    rotationAnimation.cumulative = YES;
    
    rotationAnimation.repeatCount = 0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [anImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    });
    
    [UIView animateWithDuration:1.0 animations:^{
        
        anImage.frame = CGRectMake(self.backView.width - 55, - (self.backView.height - CGRectGetHeight(self.backView.frame) - 40), 0, 0);
    } completion:^(BOOL finished) {
        btn.enabled = YES;
        
        if (_delegate  && [_delegate respondsToSelector:@selector(dataview_datachangewithPrice:url:number:ppdnumber:costpay:color:actionType:)]) {
            
            [_delegate dataview_datachangewithPrice:_price url:_url number:_number ppdnumber:_ppdnumber costpay:_costtype color:_color actionType:btn.tag];
        }
        
        // 动画完成后弹框消失
        [self dissMiss];
        
    }];
}

#pragma mark- 添加
-(void)show{

    [[[[UIApplication sharedApplication]delegate]window] addSubview:self];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:3 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        //self.size.height*0.3
        
        self.backView.frame = CGRectMake(0, self.size.height*0.3, self.width, self.height*0.7);
        
    } completion:^(BOOL finished) {
        
    }];
 
}

#pragma mark- 影藏
-(void)dissMiss{
    

    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:3 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        //self.size.height*0.3
        self.backView.frame = CGRectMake(0, SCREEN_HEIGHT+25, self.width, self.height*0.7);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
        
    }];
    
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section==1)  return self.model.colorArr.count;
    
    
    if (section==2)
        
//        return self.model.PricceArr.count;
        
        if ([SPUserModel getUserLoginModel]&&[[SPUserModel getUserLoginModel].userid isEqualToString:JX_TEST_USER_ID]) {
            
            return self.model.PricceArr.count;
        }

    return 1;
   
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==2) {
        //交易类型
        JXDetailDataParameterForCostTypeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXDetailDataParameterForCostTypeCell" forIndexPath:indexPath];
        
        SPProducePayTypePriceModel * model  = self.model.PricceArr[indexPath.item];
        
        cell.numberBtn.isTouch = model.isSelect;
        
        cell.numberBtn.editing = NO ;
        
        cell.numberBtn.currentNumber = 1;

        cell.selectBtn.selected = model.isSelect;
       
        [cell.selectBtn setTitle:[model fetchPayTypeName] forState:UIControlStateNormal];
        
        [cell.selectBtn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsImageStyleLeft imageTitlespace:5];
        
        cell.delegate = self;
        
        cell.item = indexPath.item;
        return cell;
    }else if (indexPath.section==3){
    
        //购买数量
        JXCountNumberCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXCountNumberCell" forIndexPath:indexPath];
        
        cell.numberBtn.currentNumber = 1;
    
        cell.numberBtn.delegate = self;
        
        return cell;

    }else if (indexPath.section==0){
    
        JXDetailDataSelectColorTypeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXDetailDataSelectColorTypeCell" forIndexPath:indexPath];
        
        [cell.btn setTitle:self.model.name forState:UIControlStateNormal];
        
         cell.btn.titleLabel.adjustsFontSizeToFitWidth = YES;
       
        return cell;
   
    }else{
    
        //颜色
        JXDetailDataColoCostTypeCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"JXDetailDataColoCostTypeCell" forIndexPath:indexPath];
 
        if (self.model.colorArr.count>indexPath.row) {
            
            cell.model = self.model.colorArr[indexPath.row];
        }
        cell.delegate = self;
    
        cell.btn.adjustsImageWhenHighlighted = NO;
        
        return cell;
        
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        JXLabelReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"JXLabelReusableView" forIndexPath:indexPath];
        
        header.titleDesc.text = DATAHEADERTITLEARR[indexPath.section];
        
        return header;
    }
    
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    if (section<3) {
        
        return DATAHEADERSIZE;
    }
    
    return CGSizeZero;
}


#pragma mark -UICollectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2 ||indexPath.section==3) {
        
        return CGSizeMake(SCREEN_WIDTH, 45);
    }
    
    if (indexPath.section==0) {
        
        return CGSizeMake(SCREEN_WIDTH, 45);
    }
    
    CGFloat miniWidth = (SCREEN_WIDTH-DataCellMiniItemSpace*(DataCellMiniNumber-1))/DataCellMiniNumber ;
    
    return CGSizeMake(miniWidth, 45);
}

#pragma mark - didSelect
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{


}


#pragma mark - 倍数的改变
-(void)cell_pp_numberButton:(__kindof UIView *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus item:(NSInteger)item{
    
    _ppdnumber = number;
}

#pragma mark - 交易方式的改变
-(void)cell_costTypeChange:(NSInteger)item{
    
    [self.model.PricceArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SPProducePayTypePriceModel * model = obj;
        
        model.isSelect = NO;
        
        if (idx == item) {
            
            model.isSelect = YES;
        
        }
    }];
    
     _costtype = item;
    
    [self loadViewData];
    
    [self.dataCollection reloadSections:[NSIndexSet indexSetWithIndex:2]];
}

#pragma mark - 数量的改变
-(void)pp_numberButton:(__kindof UIView *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus{

    
    _number = number;
}

#pragma mark - 颜色更改
#pragma mark - JXDetailDataColoCostTypeCellDelegate
-(void)cell_colorChange:(NSString *)tone{

    [self.model.colorArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SPProduceColorModel * model = obj;
        
        model.isSelect = NO;
        
        if ([model.tone isEqualToString:tone]) {
            
            model.isSelect = YES;
            
            _color = model.pic_color;
        }
    }];
    
    [self loadViewData];
    
    [_dataCollection reloadSections:[NSIndexSet indexSetWithIndex:1]];
    
}


-(void)setModel:(SPPurifierModel *)model{

    _model = model;
    _number =1;
    _ppdnumber=3;
   
    
    
    [self loadViewData];
    
    [self.dataCollection reloadData];
    
 
}


-(void)loadViewData{
    
    //更新图片
    //更新金额
    //更新描述
    
    __block NSString * color = @"";
    __block NSString * costpay = @"";
    
    [self.model.colorArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SPProduceColorModel * colorModel = obj ;
        
        if (colorModel.isSelect) {
            
            color = colorModel.pic_color;
            
            NSArray* imgURL = [colorModel.url componentsSeparatedByString:@","];
            
            _url = imgURL.firstObject;
            
             [SPSDWebImage SPImageView:_ico imageWithURL:imgURL.firstObject placeholderImage:[UIImage imageNamed:@""]];
            
            *stop = YES;
        }

    }];
    
    [self.model.PricceArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SPProducePayTypePriceModel * model = obj ;
        
        if (model.isSelect) {
            
            costpay = [model  fetchPayTypeName];
         
            _costtype = model.paytype;
            
            _price = model.price;
            
             _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.price];
            
            *stop = YES;
        }
    }];
    
    _color = color;
    
    
    _dataLabel .text = [NSString stringWithFormat:@"%@ %@ %@",self.model.name,color,costpay];
    
}


#pragma mark - GETTER SETTER

-(UIView *)backView{

    if (_backView==nil) {
        
        //self.size.height*0.3
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, self.width, self.height*0.7)];
        
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(UIImageView *)ico{

    if (_ico ==nil) {
        
        _ico  = [[UIImageView alloc] initWithFrame:CGRectMake(15, -25, PRODUCTICOHEIGHT, PRODUCTICOHEIGHT)];
        
        _ico.backgroundColor = [UIColor whiteColor];
        
        _ico.layer.masksToBounds = YES;
        
        _ico.layer.borderWidth = 1;
        
        _ico.layer.borderColor = [UIColor colorWithRGB:177 G:177 B:177].CGColor;
        
        _ico.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAllImage:)];
        
        [_ico addGestureRecognizer:tap];
        
//        [SPSDWebImage SPImageView:_ico imageWithURL:@"http://data.jx-inteligent.tech:15010/jx/11168e8cf9e2202a88c1318d57e4549c.png" placeholderImage:[UIImage imageNamed:@""]];
    }
    
    return _ico;
}




-(UILabel *)priceLabel{

    if (_priceLabel == nil) {
        
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ico.right+VIEWMARGIN, 15, self.backView.width-self.ico.right-25, 35)];
        
        _priceLabel.text = @"￥3980.00";
        
        _priceLabel.font = [UIFont systemFontOfSize:25];
        
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        
        _priceLabel.textColor = [UIColor colorWithHexString:@"f23030"];
        
    }
  return _priceLabel;
}

-(UILabel *)dataLabel{

    if (_dataLabel == nil) {
     
        _dataLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.ico.right+VIEWMARGIN, self.priceLabel.bottom-5, self.priceLabel.width, 30)];
        
        _dataLabel.text = @"壁挂式 珍珠白 流量购买";
        
        _dataLabel.textColor = [UIColor colorWithHexString:@"909295"];
        
        _dataLabel.font = [UIFont systemFontOfSize:16];
        
        _dataLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return _dataLabel;
}

-(UIButton *)btn{

    if (_btn ==nil) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_btn setTitle:@"加入购物车" forState:UIControlStateNormal];
        
        _btn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [_btn setBackgroundColor:[UIColor colorWithHexString:@"F49F28"]];
        
        _btn.frame = CGRectMake(0,self.backView.height-PRODUCTICOHEIGHT/2, SCREEN_WIDTH/2, PRODUCTICOHEIGHT/2);
        
        _btn.tag = ButtonActionType_ADDSHOPCAR;
        
        [_btn addTarget:self action:@selector(addShopCarAnimal:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn;
}


-(UIButton *)rightPaybtn{
    
    if (_rightPaybtn ==nil) {
        
        _rightPaybtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_rightPaybtn setTitle:@"立即购买" forState:UIControlStateNormal];
        
        _rightPaybtn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [_rightPaybtn setBackgroundColor:[UIColor colorWithHexString:@"F23030"]];
        
        _rightPaybtn.tag = ButtonActionType_RIGHTPAY;
        
        _rightPaybtn.frame = CGRectMake(SCREEN_WIDTH/2,self.backView.height-PRODUCTICOHEIGHT/2, SCREEN_WIDTH/2, PRODUCTICOHEIGHT/2);
        
        [_rightPaybtn addTarget:self action:@selector(addShopCarAnimal:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightPaybtn;
}


-(UICollectionView *)dataCollection{

    if (_dataCollection ==  nil) {

        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = DataCellMiniItemSpace;
        //最小两行之间的间距
        layout.minimumLineSpacing = DataCellMiniLineSpace;
        
        _dataCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.ico.bottom+VIEWMARGIN, SCREEN_WIDTH,self.backView.height- self.ico.bottom-VIEWMARGIN-self.btn.height) collectionViewLayout:layout];
        
        _dataCollection.alwaysBounceVertical=YES;
        
        _dataCollection.backgroundColor=[UIColor whiteColor];
        
        _dataCollection.delegate=self;
        
        _dataCollection.dataSource=self;
        
        [_dataCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        
        [_dataCollection registerNib:[UINib nibWithNibName:@"JXDetailDataParameterForCostTypeCell" bundle:nil] forCellWithReuseIdentifier:@"JXDetailDataParameterForCostTypeCell"];
        
        [_dataCollection registerNib:[UINib nibWithNibName:@"JXCountNumberCell" bundle:nil] forCellWithReuseIdentifier:@"JXCountNumberCell"];
        
        [_dataCollection registerNib:[UINib nibWithNibName:@"JXDetailDataColoCostTypeCell" bundle:nil] forCellWithReuseIdentifier:@"JXDetailDataColoCostTypeCell"];
        
        [_dataCollection registerNib:[UINib nibWithNibName:@"JXDetailDataSelectColorTypeCell" bundle:nil] forCellWithReuseIdentifier:@"JXDetailDataSelectColorTypeCell"];
        
        [_dataCollection registerNib:[UINib nibWithNibName:@"JXLabelReusableView" bundle:nil]forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JXLabelReusableView"];
        

    }
    return _dataCollection;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
