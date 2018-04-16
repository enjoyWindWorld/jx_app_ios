//
//  JXDetailProdescView.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/6/5.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "JXDetailProdescView.h"
#import "JXDetailProductDescCell.h"
#import "SPPurifierModel.h"

#define VIEWHEADERHEIGHT 65
#define FOOTERBTNHEIGHT 50
#define CELLHEIGHT 30
NSString * const itemContent = @"itemContent";
NSString * const itemSubContent = @"itemSubContent";

@interface JXDetailProdescView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * mainTableView ;

@property (nonatomic,strong) UIView * backView ;

@property (nonatomic,strong)  UIButton * btn  ;

@property (nonatomic,strong)  UIView * headerView ;

@property (nonatomic,strong) NSMutableArray * itemArr ;

@end

@implementation JXDetailProdescView

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

-(void)setModel:(SPPurifierModel *)model{

    _model = model;
    
    [self updateViewItemTime];
}

-(void)updateViewItemTime{

    self.itemArr = @[].mutableCopy;
    
    [self.itemArr addObjectsFromArray:@[
                                        @{itemContent:@"型号:",itemSubContent:self.model.dataTypename},
                                        @{itemContent:@"额定电压/频率:",itemSubContent:self.model.PROD_HZ},
                                        @{itemContent:@"加热功率:",itemSubContent:self.model.PROD_W},
                                        @{itemContent:@"进水压力:",itemSubContent:self.model.PROD_MPA},
                                        @{itemContent:@"环境温度:",itemSubContent:self.model.PROD_C},
                                        @{itemContent:@"净水流量:",itemSubContent:self.model.PROD_HL},
                                        @{itemContent:@"过滤方式:",itemSubContent:self.model.PROD_FL},
                                        @{itemContent:@"适用水范围:",itemSubContent:self.model.PROD_WT},
                                        @{itemContent:@"出水水质:",itemSubContent:self.model.PROD_IW},
                                        @{itemContent:@"产品毛重:",itemSubContent:self.model.PROD_WX},
                                        @{itemContent:@"产品净重:",itemSubContent:self.model.PROD_WD},
                                        @{itemContent:@"产品尺寸:",itemSubContent:self.model.PROD_SZ},
                                        @{itemContent:@"包装尺寸:",itemSubContent:self.model.PROD_SZI}]
     ];
    
    [self.mainTableView reloadData];

}


-(void)initWithUI{
    
    [self addSubview:self.backView];
    
    [self.backView  addSubview:self.headerView];
    
    [self.backView addSubview:self.mainTableView];
    
    [self.backView addSubview:self.btn];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.itemArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    JXDetailProductDescCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JXDetailProductDescCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.itemArr.count>indexPath.row) {
        
        NSDictionary * dic = self.itemArr[indexPath.row];
        
        cell.titleLabel.text = dic[itemContent];
        
        cell.nameLabel.text = dic[itemSubContent];
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return CELLHEIGHT;
}


#pragma mark - GETTER SETTER
-(UIView *)backView{
    
    if (_backView==nil) {

        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, self.width, self.height*0.7)];
        
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(UITableView *)mainTableView{

    if (_mainTableView==nil) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, VIEWHEADERHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT*0.7-VIEWHEADERHEIGHT-FOOTERBTNHEIGHT) style:UITableViewStylePlain];
        
        _mainTableView.dataSource = self;
        
        _mainTableView.delegate = self;
        
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_mainTableView registerNib:[UINib nibWithNibName:@"JXDetailProductDescCell" bundle:nil] forCellReuseIdentifier:@"JXDetailProductDescCell"];
    }
    
    return _mainTableView;
}

-(UIButton *)btn{
    
    if (_btn ==nil) {
        
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_btn setTitle:@"完成" forState:UIControlStateNormal];
        
        _btn.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [_btn setBackgroundColor:[UIColor colorWithHexString:@"73d1c4"]];
        
        _btn.frame = CGRectMake(0,self.backView.height-FOOTERBTNHEIGHT, SCREEN_WIDTH, FOOTERBTNHEIGHT);
        
        [_btn addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _btn;
}


-(UIView *)headerView{

    if (_headerView == nil) {
        
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEWHEADERHEIGHT)];
        
        UILabel * label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, VIEWHEADERHEIGHT)];
        
        label.text = @"产品参数";
        
        label.textColor = HEXCOLOR(@"0f0f0f");
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = [UIFont systemFontOfSize:20];
        
        [headerView addSubview:label];
        
        UIButton * exit  = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [exit setImage:[UIImage imageNamed:@"exit"] forState:UIControlStateNormal];
        
        [exit addTarget:self action:@selector(dissMiss) forControlEvents:UIControlEventTouchUpInside];
        
        exit.frame = CGRectMake(headerView.width-30, VIEWHEADERHEIGHT/4, 22, 22);
        
        [headerView addSubview:exit];
        
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0,VIEWHEADERHEIGHT-1, self.backView.width, 1)];
        
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        [headerView addSubview:line];
        
        _headerView = headerView;
    }
    return _headerView;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self dissMiss];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
