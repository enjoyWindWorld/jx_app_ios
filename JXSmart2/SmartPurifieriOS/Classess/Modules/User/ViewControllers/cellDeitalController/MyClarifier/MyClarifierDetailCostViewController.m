//
//  MyClarifierDetailCostViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyClarifierDetailCostViewController.h"
#import "SPAddressInfoCell.h"
#import "UserPurifierListModel.h"
#import "SPUserModulesBusiness.h"
#import "SPClarifierTrafficModel.h"
#import "MyClarifierWriteCostViewController.h"

NSString * const itemTitleKey = @"itemTitleKey";

NSString * const itemSubTitleKey = @"itemSubTitleKey";

@interface MyClarifierDetailCostViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;


@property (weak, nonatomic) IBOutlet UIButton *payCostButton;

@property (nonatomic,strong) SPClarifierTrafficModel * listModel;

@property (nonatomic,strong) NSMutableArray * ViewItemData;


@end

@implementation MyClarifierDetailCostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_model) {
    
        _payCostButton.hidden = _model.type==ClarifierType_Mine?NO:YES;
        
    }
    
    [self compatibleAvailable_ios11:_myTableView];
    
    [self reuestClaifierDetailData];
    // Do any additional setup after loading the view.
}


-(void)reuestClaifierDetailData{

    __weak typeof(self) weakself = self ;
    
    SPUserModulesBusiness  * all = [[SPUserModulesBusiness alloc] init];
    
    [all getClarifierDetailCost:@{@"pro_no":_model.pro_no} success:^(id result) {
        
        weakself.listModel = result ;
       
//        if (weakself.listModel.sharetype==0) {
//            
//            _payCostButton.hidden = NO;
//            
//        }
        
        [weakself getViewItemData];
        
        [weakself.myTableView reloadData];
        
    } failer:^(NSString *error) {
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];

    }];

}


-(void)getViewItemData{

    _ViewItemData  = [NSMutableArray arrayWithCapacity:0];
    
    [_ViewItemData addObject:@{itemTitleKey:@"查询日期:",itemSubTitleKey:_listModel.fetch_Time}];
    
    [_ViewItemData addObject:@{itemTitleKey:@"客户名字:",itemSubTitleKey:_listModel.name}];
    
    [_ViewItemData addObject:@{itemTitleKey:@"手机号码:",itemSubTitleKey:_listModel.phone}];
    
   
    NSString * addtime = [self getWebTimeConversionLocalTime:_listModel.pro_addtime];
    
    [_ViewItemData addObject:@{itemTitleKey:@"净水机编号:",itemSubTitleKey:_listModel.pro_no}];
    
    [_ViewItemData addObject:@{itemTitleKey:@"订单编号:",itemSubTitleKey:_listModel.ord_no}];
    
    self.title = _listModel.type==ClarifierCostType_YearFree?@"包年服务费用":@"流量服务费用";
    
    [_ViewItemData addObject:@{itemTitleKey:@"净水机类型:",itemSubTitleKey:[NSString stringWithFormat:@"%@%@(%@)%@%@元",addtime,_listModel.pro_name,_listModel.ord_color,_listModel.type==ClarifierCostType_YearFree?@"包年费用":@"流量预付",_listModel.ord_price]}];
    
    [_ViewItemData addObject:@{itemTitleKey:@"生效时间:",itemSubTitleKey:addtime}];
    
    if (_listModel.type==ClarifierCostType_TrafficFree) {
        
        [_ViewItemData addObject:@{itemTitleKey:@"目前使用流量:",itemSubTitleKey:[NSString stringWithFormat:@"%ld升",[_listModel.pro_hasflow integerValue]]}];
   
    }else if (_listModel.type==ClarifierCostType_YearFree){
    
        NSString * invalidtime = [self getWebTimeConversionLocalTime:_listModel.pro_invalidtime];
        
        [_ViewItemData addObject:@{itemTitleKey:@"失效时间:",itemSubTitleKey:invalidtime}];
    }
    
}

-(NSString*)getWebTimeConversionLocalTime:(NSString*)time{

    return time;

//  return  [NSDate getConfromWithDateString:[NSString stringWithFormat:@"%ld",([time integerValue]/1000)]];
    
}

#pragma mark - 点击续费
- (IBAction)payCostMoneyClick:(id)sender {

    if (!_listModel) {
        
        return ;
    }
    
    [self performSegueWithIdentifier:@"MyClarifierWriteCostViewController" sender:_listModel];
    
}


#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _ViewItemData.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
        
        SPAddressInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
        
        cell.titleLabel.text = [NSString stringWithFormat:@"%@%@",_ViewItemData[indexPath.row][itemTitleKey],_ViewItemData[indexPath.row][itemSubTitleKey]] ;
        
        return cell;
    }
    
    SPAddressInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL1" forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString * subTitle = _ViewItemData[indexPath.row][itemSubTitleKey];
    
    if (indexPath.row==0||subTitle.length<=0) {
        
        return 35;
    }

    
   CGFloat height  = [tableView fd_heightForCellWithIdentifier:@"CELL1" configuration:^(SPAddressInfoCell* cell) {
        
         [self configureCell:cell atIndexPath:indexPath];
    }];
    
    return indexPath.row==3?58.5:height;
//    return 45;
}


- (void)configureCell:(SPAddressInfoCell *)cell atIndexPath:(NSIndexPath *)indexPath {

    cell.titleLabel.text = _ViewItemData[indexPath.row][itemTitleKey];
    
    cell.subTitleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    //_ViewItemData[indexPath.row][itemSubTitleKey]
    cell.subTitleLabel.text = _ViewItemData[indexPath.row][itemSubTitleKey];
    

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"MyClarifierWriteCostViewController"]) {
        
        MyClarifierWriteCostViewController * vc = segue.destinationViewController;
        
        vc.listModel = sender ;
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
