//
//  JXDetailTableHeaderView.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/25.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXDetailTableHeaderView.h"
#import "SDCycleScrollView.h"
#import "SPPurifierModel.h"


#define PROCELABELHEGHT 55.f

@interface JXDetailTableHeaderView ()

@property (nonatomic,strong) SDCycleScrollView * newcolorImageView;

@property (nonatomic,strong) UILabel * priceLabel ;

@property (nonatomic,strong) UILabel * productDesc ;


@end

@implementation JXDetailTableHeaderView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self initUI];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)initUI{
    
    
    _newcolorImageView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.4) delegate:nil placeholderImage:nil];
    
    _newcolorImageView.scrollDirection = UICollectionViewScrollDirectionHorizontal ;
    
    _newcolorImageView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    
    _newcolorImageView.currentPageDotColor = SPNavBarColor;
    
    _newcolorImageView.imageURLStringsGroup =@[];
    
    _newcolorImageView.backgroundColor = [UIColor whiteColor];
    
    _newcolorImageView.autoScroll = NO ;
    


    UILabel * price = [[UILabel alloc] initWithFrame:CGRectMake(0, _newcolorImageView.bottom, SCREEN_WIDTH, PROCELABELHEGHT)];
    
    price.textColor = [UIColor whiteColor];
    
    price.font = [UIFont systemFontOfSize:28];
    
    price.backgroundColor = HEXCOLOR(@"f22e70");
    
    [self addSubview:price];
    
    UILabel * productDesc = [[UILabel alloc] initWithFrame:CGRectMake(15, price.bottom, SCREEN_WIDTH-30, PROCELABELHEGHT)];
    
    productDesc.textColor =HEXCOLOR(@"0f0f0f");
    
    productDesc.font = [UIFont systemFontOfSize:20.f];
    
    productDesc.backgroundColor = [UIColor whiteColor];
    
    NSString * valuestring = @"壁挂式净水机";
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:valuestring];
    
    NSDictionary *attributeDict =[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont systemFontOfSize:15.f], NSFontAttributeName,
                                  nil];
    
    [string addAttributes:attributeDict range:[valuestring rangeOfString:@"净喜智能"]];
    
    productDesc.attributedText = string;
    
    [self addSubview:price];
    
    [self addSubview:productDesc];
    
    _priceLabel = price;
    
    _productDesc = productDesc;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom-1, SCREEN_WIDTH, 1)];
    
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self addSubview:view];
    
    [self addSubview:_newcolorImageView];
    
}


#pragma mark - 设置name;
-(void)setName:(NSString *)name{

    _name = name;

    _productDesc.text = [NSString stringWithFormat:@"%@",name];
}

#pragma mark -
-(void)setColorArr:(NSArray *)colorArr{
    
    _colorArr = colorArr ;
    
    __block  NSMutableArray * imgURLMore = @[].mutableCopy;
    
    [colorArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SPProduceColorModel * colorModel = obj ;

        NSArray* imgURL = [colorModel.url componentsSeparatedByString:@","];
        
        [imgURL enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [imgURLMore addObject:obj];
            
        }];

    }];
    
    _newcolorImageView.imageURLStringsGroup = imgURLMore;
    
}

-(void)setPriceArr:(NSArray *)priceArr{

    _priceArr = priceArr;
    
    NSMutableArray * newpriceArr = [NSMutableArray arrayWithCapacity:0];
    
    [priceArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SPProducePayTypePriceModel * model = obj;
        
        NSString* price  = model.pay_price;
        
        [newpriceArr addObject:price];
        
    }];
    
    CGFloat maxValue = [[newpriceArr valueForKeyPath:@"@max.floatValue"] floatValue];
   
    CGFloat minValue = [[newpriceArr valueForKeyPath:@"@min.floatValue"] floatValue];
    
    NSString * valuestring = @"";
    
    if (maxValue==minValue) {
        
        valuestring = [NSString stringWithFormat:@"  ￥%.2f",maxValue];
        
    }else{
    
        valuestring = [NSString stringWithFormat:@"  ￥%.2f-%.2f",minValue,maxValue];
    }
    
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc] initWithString:valuestring];
    
    NSDictionary *attributeDict =[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont systemFontOfSize:18], NSFontAttributeName,
                                  nil];
    
    [string addAttributes:attributeDict range:[valuestring rangeOfString:@"￥"]];
    
    NSMutableAttributedString * astring = [[NSMutableAttributedString alloc] initWithString:@"(三年服务费)"];
    
    attributeDict =[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont systemFontOfSize:15], NSFontAttributeName,
                                  nil];
    
    [astring addAttributes:attributeDict range:[valuestring rangeOfString:@"(三年服务费)"]];
    [string appendAttributedString:astring ];
    
    _priceLabel.attributedText = string;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
