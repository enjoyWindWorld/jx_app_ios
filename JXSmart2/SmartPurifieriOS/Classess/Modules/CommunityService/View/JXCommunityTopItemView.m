//
//  JXCommunityTopItemView.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/5/8.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXCommunityTopItemView.h"
#import "PushBtnModel.h"
#import "JXCommunityDetailCollectionViewCell.h"

#define TitlelabelLeft 15
#define TitlelabelTop 0
#define TitlelabelSize CGSizeMake(100, 20)
#define TopItemCellMiniItemSpace 10
#define TopItemCellMiniLineSpace 10
#define TopItemCellMiniNumber 3
#define MINIHEGHT 45

@interface JXCommunityTopItemView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) JXCommunityTopMenuView * bottomView;       //底层视图

@end

@implementation JXCommunityTopItemView

-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)dataArr{

    self  = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
   
    if (self) {
        
        self.userInteractionEnabled = YES ;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        
        self.bottomView = [[JXCommunityTopMenuView alloc] initWithFrame:CGRectMake(0, -SCREEN_HEIGHT, SCREEN_WIDTH,frame.size.height) andData:dataArr];
        
        self.bottomView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.bottomView];
        
    }
    
    return self;
}



-(void)showComunityView:(NSString*)chooseIdentifier  animated:(BOOL)animated completion:(void (^ __nullable)(PushBtnModel*Model))completion{
    
    
    [self.bottomView chooseIdentifier:chooseIdentifier];
    
    if (completion) {
        
        self.bottomView.complationHandle = completion;
    }
    

    CGRect frame = self.bottomView.frame ;
    
    if (animated == NO) {
        
        
        [self.bottomView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height)];
        
        return ;
    }
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            

                        
                            [self.bottomView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, frame.size.height)];
                            
                        }completion:^(BOOL finished) {
                            
                            
                        }];
}

-(void)dissMissWithAnimated:(BOOL)animated{
    

    CGRect frame = self.bottomView.frame ;
    
    if (animated ==NO) {
        
        [self removeFromSuperview];
        
        return ;
    }
    
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self.bottomView setFrame:CGRectMake(0, -SCREEN_HEIGHT,SCREEN_WIDTH, frame.size.height)];
  
    }completion:^(BOOL finished) {
    
        [self removeFromSuperview];
    
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if (self.bottomView.complationHandle) {
        
        self.bottomView.complationHandle(nil);
    }
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@interface JXCommunityTopMenuView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (nonatomic,strong) UICollectionView * collectionView;

@property (nonatomic,strong) UILabel * titleLabel;


@end


@implementation JXCommunityTopMenuView


-(instancetype)initWithFrame:(CGRect)frame andData:(NSArray *)dataArr{

    if (self = [super initWithFrame:frame]) {
       
        self.datas = dataArr;
        
        NSInteger remain  = self.datas.count%3 ;
        
        CGFloat contentHeght = ((remain>0?1:0)+ self.datas.count/3) *(MINIHEGHT+TopItemCellMiniLineSpace) + TitlelabelSize.height;
        
        CGFloat height = contentHeght>frame.size.height?frame.size.height:contentHeght;
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, height+10);
        
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.collectionView];
        
    }
    
    return self ;
}

-(void)chooseIdentifier:(NSString*)identifier{

    [self.datas enumerateObjectsUsingBlock:^(PushBtnModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj.dataIdentifier isEqualToString:identifier]) {
            
            obj.isSelect = YES;
            
        }else{
            
            obj.isSelect= NO;
        }
    }];
    
    [self.collectionView reloadData];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.datas.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JXCommunityDetailCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"JXCommunityDetailCollectionViewCell" forIndexPath:indexPath];
    
    cell.itemLabel.font = [UIFont systemFontOfSize:15];
    cell.itemLabel.layer.borderWidth = 0.8;
    cell.itemLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.itemLabel.layer.cornerRadius = 3;
    
    if (self.datas.count>indexPath.item) {
        
        PushBtnModel *m = self.datas[indexPath.item];
        
        cell.itemLabel.textColor = m.isSelect==NO? [UIColor grayColor]:[UIColor colorWithRed:46/255.0 green:182/255.0 blue:237/255.0 alpha:1.0];
        cell.itemLabel.layer.borderColor = m.isSelect ==NO?[UIColor lightGrayColor].CGColor:[UIColor colorWithRed:46/255.0 green:182/255.0 blue:237/255.0 alpha:1.0].CGColor;
        
        cell.itemLabel.text = m.menu_name;
        
        cell.itemLabel.adjustsFontSizeToFitWidth= YES;
        
        cell.itemLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters ;
    }
    
    
    return cell;
}

#pragma mark -UICollectionViewLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat miniWidth = (collectionView.size.width-TopItemCellMiniItemSpace*(TopItemCellMiniNumber-1))/TopItemCellMiniNumber ;
    
    return CGSizeMake(miniWidth, MINIHEGHT);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (self.datas.count>indexPath.item) {
        
        PushBtnModel *m = self.datas[indexPath.item];
        
        [self.datas enumerateObjectsUsingBlock:^(PushBtnModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.dataIdentifier isEqualToString:m.dataIdentifier]) {
                
                obj.isSelect = YES;
                
            }else{
                
                obj.isSelect= NO;
            }
        }];
        
        __weak PushBtnModel * model  = m;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
        if (self.complationHandle) {
            
            self.complationHandle(model);
        }
        
#pragma clang diagnostic pop
        
        [collectionView reloadData];

    }
    
}

-(UILabel *)titleLabel{
    
    if (_titleLabel==nil) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TitlelabelLeft, TitlelabelTop
                                                                , TitlelabelSize.width, TitlelabelSize.height)];
        _titleLabel.text = @"分类";
        
        _titleLabel.textColor = [UIColor lightGrayColor];
        
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return  _titleLabel;
}


-(UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = TopItemCellMiniItemSpace;
        //最小两行之间的间距
        layout.minimumLineSpacing = TopItemCellMiniLineSpace;
        
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(TitlelabelLeft,TitlelabelSize.height+TitlelabelTop, SCREEN_WIDTH-TitlelabelLeft*2, self.bottomView.size.height-TitlelabelTop-TitlelabelSize.height) collectionViewLayout:layout];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(TitlelabelLeft,TitlelabelSize.height+TitlelabelTop, SCREEN_WIDTH-TitlelabelLeft*2, self.size.height-TitlelabelTop-TitlelabelSize.height) collectionViewLayout:layout];
        
        _collectionView.alwaysBounceVertical=YES;
        
//        _collectionView.showsVerticalScrollIndicator = YES;
    
        
        _collectionView.backgroundColor=[UIColor whiteColor];
        
        _collectionView.delegate=self;
        
        _collectionView.dataSource=self;
        
        UINib *nib = [UINib nibWithNibName:@"JXCommunityDetailCollectionViewCell" bundle:nil];
        
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"JXCommunityDetailCollectionViewCell"];
        
    }
    return _collectionView;
}



@end

