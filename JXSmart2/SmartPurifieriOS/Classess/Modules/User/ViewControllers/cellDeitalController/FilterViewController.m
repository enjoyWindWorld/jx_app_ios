//
//  FilterViewController.m
//  SmartPurifieriOS
//
//  Created by Mray-mac on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "FilterViewController.h"
#import "SPUserModulesBusiness.h"
#import "UserPurifierDetailModel.h"
#import "SPUserModel.h"
#import "Masonry.h"

#define TABLEVIEWMASONRYINSET_TOP 35
#define TABLEVIEWMASONRYINSET_LEFT 20
#define TABLEVIEWMASONRYINSET_BOTTOM 35
#define TABLEVIEWMASONRYINSET_RIGHT 20
#define HEADERTITLEDESCRIBE @"滤芯状态"
#define HEADERTITLEHEIGHT 40

@interface FilterViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray *titleArr;
}

@property (nonatomic,strong) UITableView * ptableView;

@property (nonatomic,strong) UILabel * headerTitleLabel ;

@end

@implementation FilterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
//    [self.view addSubview:self.ptableView];
//    
//
//    
//    self.ptableView.tableHeaderView = self.headerTitleLabel;
//
//    
//    [self jx_privateMethodUpdateMasoneyView];
    
    self.title = @"滤芯状态";
    titleArr = [NSArray arrayWithObjects:@"pp",@"cto",@"ro",@"t33",@"wfr", nil];
    

    
    [self initWithUI];
    
    [self initNetWork];
    
}

-(void)initWithUI{
    _backView.layer.borderWidth = 2;
    _backView.layer.borderColor = [UIColor colorWithHexString:@"efeff4"].CGColor;
    _backView.layer.cornerRadius = 8;
    
    
    _lineOne.layer.cornerRadius = 2;
    
    for (int i = 0; i<4; i++) {
        UIView *oneV = (UIView*)[_backView viewWithTag:10+i];
        oneV.layer.cornerRadius = 2;
        oneV.layer.masksToBounds = YES;
        
        UIView *twoV = (UIView*)[_backView viewWithTag:30+i];
        twoV.layer.cornerRadius = 2;
        twoV.layer.masksToBounds = YES;

    }
    
}

-(void)initNetWork
{
    SPUserModel *m = [SPUserModel getUserLoginModel];
    NSDictionary * dic = @{@"phoneNum":m.UserPhone,@"pro_id":self.filterID};
    
    [[[SPUserModulesBusiness alloc]init] getUserPurifierDetail:dic success:^(id result) {

        [SPSVProgressHUD dismiss];
        
        NSArray * arr = result;
        
        if ([result isKindOfClass:[NSArray class]]&&result != NULL&&arr.count != 0) {
            
            
            NSDictionary *temDic = arr[0];

           
            for (int i = 0; i < titleArr.count ;i++){
                
                UIView *filterView = (UIView*)[_backView viewWithTag:10+i];
                NSString *titlestr = titleArr[i];
                
                //NSString *str = [temDic[titlestr] stringByReplacingOccurrencesOfString:@" %" withString:@""];
                NSString *str = temDic[titlestr];
                
                str = [str isEqual:[NSNull null]]?@"100":str;
                
                CGFloat f = [str floatValue];
                
                CGFloat lineWidth = 0.837*SCREEN_WIDTH;
                
                
                filterView.frame = CGRectMake(filterView.frame.origin.x, filterView.frame.origin.y, lineWidth*f/100, filterView.frame.size.height);
                
                UILabel *titleLabel = (UILabel*)[_backView viewWithTag:20+i];
                titleLabel.text = [NSString stringWithFormat:@"%.2f%%",f];
            
            }
        
        }

    } failer:^(NSString *error) {
        [SPSVProgressHUD dismiss];
        __weak typeof(self) weakself  = self;
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        
    }];
    
}


#pragma mark -private method masoney

-(void)jx_privateMethodUpdateMasoneyView{

    [self jx_masoneyWithtableView];
    
    [self jx_masoneyWithHeaderTitle];
}

-(void)jx_masoneyWithtableView{

    [self.ptableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.bottom.mas_equalTo(self.view).insets(UIEdgeInsetsMake(TABLEVIEWMASONRYINSET_TOP, TABLEVIEWMASONRYINSET_LEFT, TABLEVIEWMASONRYINSET_BOTTOM, TABLEVIEWMASONRYINSET_RIGHT));
        
    }];
}

-(void)jx_masoneyWithHeaderTitle{
    
//    [self.headerTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.left.right.mas_equalTo(@0);
//        
//        make.height.mas_equalTo(HEADERTITLEHEIGHT);
//    }];
}




#pragma getter setter 
-(UITableView *)ptableView{

    if (_ptableView==nil) {
        
        _ptableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _ptableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _ptableView.backgroundColor = [UIColor whiteColor];
    
    }

    return _ptableView;
}

-(UILabel *)headerTitleLabel{

    if (_headerTitleLabel==nil) {
        
        _headerTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.ptableView.width, HEADERTITLEHEIGHT)];
        
        _headerTitleLabel .text =HEADERTITLEDESCRIBE;
        
        _headerTitleLabel.font = [UIFont systemFontOfSize:TABLEVIEWMASONRYINSET_LEFT];
        
        _headerTitleLabel.textAlignment = NSTextAlignmentCenter;
        
        _headerTitleLabel.backgroundColor = [UIColor redColor];
        
        _headerTitleLabel.textColor = [UIColor colorWithHexString:@"000000"];
    }
    
    return _headerTitleLabel;
}

@end
