//
//  MyOrderViewController.m
//  SmartPurifieriOS
//
//  Created by Mray-mac on 2016/11/21.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "OrderDeitalViewController.h"
#import "SPComServiceModulesBusiness.h"
#import "SPUserModulesBusiness.h"
#import "OrderLitModel.h"
#import "SPUserModel.h"


@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate,UIAlertViewDelegate>{
   
    UIAlertView *alert;
    
    UIAlertView *delAlert;
    
}

@property (nonatomic,strong) SPUserModulesBusiness * business;

@property (nonatomic,strong) UITableView *tableV; ;

@property (nonatomic,strong) NSMutableArray * orderListArr ;  //分组欠的

@property (nonatomic,assign) NSInteger readPage ;

@end

@implementation MyOrderViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
   

    _orderListArr = [NSMutableArray arrayWithCapacity:0];
   
    [self initWithUI];

    self.view.backgroundColor = SPViewBackColor;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestMyOrderList:1];
    
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
}



-(void)initWithUI{
    
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-44) style:UITableViewStylePlain];
   
    _tableV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    _tableV.delegate = self;
    
    _tableV.dataSource = self;
 
    _tableV.separatorStyle = YES;
  
    [self.view addSubview:_tableV];

    [_tableV setTableFooterView:[UIView new]];
    
    
    
    __weak __typeof (self)weakself = self;
    
    [self.tableV addJX_NormalHeaderRefreshBlock:^{
        
        [weakself requestMyOrderList:1];
    }];
    
    [self.tableV addJX_NormalFooterRefreshBlock:^{
        
        [weakself requestMyOrderList:_readPage+1];
    }];
    
    [_tableV addJXEmptyView];
}


#pragma mark- 网络代理  获取我的订单列表
-(void)requestMyOrderList:(NSInteger)currentpage{
    
    NSLog(@"OC FETCH");
    
    _readPage  = currentpage;
    
    SPUserModel *model = [SPUserModel getUserLoginModel];
    
    __weak typeof(self) weakself  = self;
    
    [self.business getUserMyOrder:@{@"uid":model.userid,@"page":[NSString stringWithFormat:@"%ld",currentpage],@"state":_state} success:^(id result) {

        __strong __typeof(weakself)strongSelf = weakself;
        
        [strongSelf.tableV JXendRefreshing ];
        
        NSArray * resultArr = result ;
        
        if (currentpage==1) {
            
            [strongSelf.orderListArr removeAllObjects];
        }
        
        if (resultArr.count==0) {
            
            [strongSelf.tableV JXfooterEndNoMoreData];
        }
        
        [strongSelf.orderListArr addObjectsFromArray:resultArr];
        
        
        [strongSelf.tableV reloadData];
        
        
    } failer:^(NSString *error) {
        
        [weakself.tableV JXendRefreshing ];
  
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        
    }];
    
    
}



-(NSArray*)fetchTimeGroupArr:(NSMutableArray*)OrderArr{
    
    NSMutableArray *timeArr=[NSMutableArray array];
    
    [OrderArr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        OrderLitModel *m = obj;
        
        NSString *timestr = [m.addtime substringWithRange:NSMakeRange(0,7)];
        
        [timeArr addObject:timestr];
        
    }];
    //使用asset把timeArr的日期去重
    NSSet *set = [NSSet setWithArray:timeArr];
    NSArray *userArray = [set allObjects];
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO];//yes升序排列，no,降序排列
    //按日期降序排列的日期数组
    NSArray *myary = [userArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sd1, nil]];
    //此时得到的myary就是按照时间降序排列拍好的数组
    __block  NSMutableArray * _titleArray=[NSMutableArray array];
    //遍历myary把_titleArray按照myary里的时间分成几个组每个组都是空的数组
    [myary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *arr=[NSMutableArray array];
        
        [_titleArray addObject:arr];
        
    }];
    //遍历_dataArray取其中每个数据的日期看看与myary里的那个日期匹配就把这个数据装到_titleArray 对应的组中
    [OrderArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        OrderLitModel *m = obj;
        
        NSString *timestr = [m.addtime substringWithRange:NSMakeRange(0,7)];
        
        for (NSString *str in myary)
        {
            if([str isEqualToString:timestr])
            {
                NSMutableArray *arr=[_titleArray objectAtIndex:[myary indexOfObject:str]];
                
                [arr addObject:m];
            }
        }
        
    }];
    
    
    return _titleArray;
}


-(void)initDelOrderNetWork:(NSString*)orderID{
    //删除订单
    NSDictionary * dic = @{@"ord_no":orderID};
    
    __weak typeof(self) weakself = self;
    
    [self.business getUserOrderDel:dic success:^(id result) {
      

        [SPSVProgressHUD showSuccessWithStatus:@"删除成功"];
        
        __block NSInteger delIndex = 0 ;
        
        [weakself.orderListArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            OrderLitModel * list = obj;
            
            if ([list.ordno isEqualToString:orderID]) {
                
                delIndex = idx;
                
                *stop = YES;
            }
        }];
        
        [weakself.orderListArr removeObjectAtIndex:delIndex];
       
        if (weakself.orderListArr.count==0) {
            
//            [weakself.tableV deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationLeft];
            
             [weakself.tableV deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:delIndex inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        }else{
      
            [weakself.tableV deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:delIndex inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        }
        

    } failer:^(NSString *error) {
        
        
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        
    }];
    
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.orderListArr.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //cell创建视图
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderTableViewCell"];
   
    if(cell == nil){
    
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MyOrderTableViewCell" owner:self options:nil]lastObject];
    }
    
    if (self.orderListArr.count>indexPath.row) {
        
        OrderLitModel *m = self.orderListArr[indexPath.row];
        
        cell.title.text = m.name;
        
        cell.timeLabel.text = m.addtime;
        
        cell.monenyLabel.text = [NSString stringWithFormat:@"%@元",m.price];
        
        cell.payLabel.text = [m fetchOrderStateDescription];
        
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell高度代理
    return 66;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //cell点击事件
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderDeitalViewController *vc = [[OrderDeitalViewController alloc]init];
    

    if (self.orderListArr.count>indexPath.row) {
       
        OrderLitModel *m = self.orderListArr[indexPath.row];
        
        if (!m) return ;
        
        vc.OrderId = m.ordno;
        
        vc.status = [m.status integerValue];
        
        __weak typeof(self) weakslel = self;
        
        [vc setDelBlock:^(NSString*orderid){
            
            [weakslel initDelOrderNetWork:orderid];
            
        }];
        
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (self.orderListArr.count>indexPath.row) {
            
            OrderLitModel *m = self.orderListArr[indexPath.row];
            
            [self openAlertController:m];
        }

    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(void)openAlertController:(OrderLitModel*)model{
    
    BOOL isShouldDel = NO;
    
    isShouldDel = [model.status integerValue]==OrderState_NonPayment?YES:NO;
    

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:isShouldDel==YES?@"确认删除此订单?":@"此订单不能删除!" preferredStyle:UIAlertControllerStyleAlert];
   
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
        
       
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (isShouldDel) {
            
            [self initDelOrderNetWork:model.ordno];
        }
        
    }];
    
    if (isShouldDel) {
        
        [alertController addAction:cancelAction];
    }
   
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return @"删除";
}



#pragma mark - gettet setter

-(SPUserModulesBusiness *)business{
    
    if (_business == nil) {
        
        _business  =[[SPUserModulesBusiness alloc] init];
        
    }
    return  _business;
}


-(NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    
    NSString * title = @"暂无数据";
    
    return [[NSAttributedString alloc] initWithString:title attributes:nil];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"NoData@2x"];
}

-(BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    
    return YES ;
}

@end
