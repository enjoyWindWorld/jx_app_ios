//
//  MyClarifierMessageViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyClarifierMessageViewController.h"
#import "MyClarifierDetailCostViewController.h"
#import "MyClarifierMessageTableViewCell.h"
#import "SPUserModulesBusiness.h"
#import "SPClarifierMessageModel.h"
#import "UserPurifierListModel.h"
#import "OrderDeitalViewController.h"

@interface MyClarifierMessageViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * messageArr ;

@property (nonatomic,assign) NSInteger currentPage;


@end

@implementation MyClarifierMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息中心";
    
    self.myTableView.emptyDataSetSource = self;
    
    self.myTableView.emptyDataSetDelegate = self;
    
    _currentPage = 1;
    
    _messageArr = [NSMutableArray arrayWithCapacity:0];
    
    _myTableView.tableFooterView = [UIView new];
    
    [self compatibleAvailable_ios11:_myTableView];

    [self addMJRefreshView];
    
    [self reuestMessageListData:_currentPage];
    // Do any additional setup after loading the view.
}


-(void)addMJRefreshView{
    
    __weak typeof(self) weakself = self ;
    
    [SPMJRefresh normalHeader:self.myTableView refreshBlock:^{
        
        [weakself reuestMessageListData:1];
        
    }];
    
    [SPMJRefresh autoNormalFooter:self.myTableView refreshBlock:^{
        
        [weakself reuestMessageListData:_currentPage+1];
        
    }];
    
}

-(void)reuestMessageListData:(NSInteger)page{
    
    _currentPage = page ;
    
    __weak typeof(self) weakself = self ;
    
    SPUserModulesBusiness  * all = [[SPUserModulesBusiness alloc] init];
    
    [all getMessageList:@{@"page":[NSNumber numberWithInteger:page]} success:^(id result) {
        
         NSArray * resultArr = result ;
        
        [SPMJRefresh endRefreshing:weakself.myTableView];
        
        if (page==1) {
            
            [weakself.messageArr removeAllObjects];
        }
        
        [weakself.messageArr addObjectsFromArray:resultArr];
        
        if(resultArr.count==0){
            
            [SPMJRefresh footerEndNoMoreData:weakself.myTableView];
            
        }
        
        [weakself.myTableView reloadData];
        
    } failer:^(NSString *error) {
        
         [SPMJRefresh endRefreshing:weakself.myTableView];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}


-(void)reuestMessageDefaultRead:(NSString*)messageid{
    
    __weak typeof(self) weakself = self ;
    
    SPUserModulesBusiness  * all = [[SPUserModulesBusiness alloc] init];
    
    [all getChangeMessageWithRead:@{@"id":messageid} success:^(id result) {
        
        
        [weakself.messageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            SPClarifierMessageModel * model = obj;
            
            if ([model.messageid isEqualToString:messageid]) {
                
                model.isread = 1;
                
                * stop  = YES;
            }
            
        }];
        
        if (_didHander) {
            
            _didHander();
        }
        
        [weakself.myTableView reloadData];
        
    } failer:^(NSString *error) {
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}

-(void)reuestDeleteMessage:(SPClarifierMessageModel*)model{
    
    __weak typeof(self) weakself = self ;
    
    NSInteger index = [self.messageArr indexOfObject:model];
   
    [self.messageArr removeObject:model];

    SPUserModulesBusiness  * all = [[SPUserModulesBusiness alloc] init];
    
    [all getDeleteOneOfMessage:@{@"id":model.messageid} success:^(id result) {
        
         [SPSVProgressHUD showSuccessWithStatus:@"删除成功"];
        
        [weakself.myTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        
        if (weakself.messageArr.count==0) {
            
            [weakself.myTableView reloadData];
        }
        
        if (model.isread==0&&_didHander) {
            
            _didHander();
        }
        
    } failer:^(NSString *error) {
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}

-(NSString*)getWebTimeConversionLocalTime:(NSString*)time{
    
    return time;
    
    //return  [NSDate getConfromWithDateString:[NSString stringWithFormat:@"%ld",([time integerValue]/1000)]];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _messageArr.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    MyClarifierMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    

    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
     SPClarifierMessageModel * model = _messageArr[indexPath.row];
    
    if (!model) return;
    
    if (model.isread==0) {
        
        [self reuestMessageDefaultRead:model.messageid];
        
    }
    //交易跳订单 绑定跳余量查询
    
    if (model.type == MessageType_Trade||model.type == MessageType_Binding) {
        
        //订单详情
        [self performSegueOrderDtail:model];
        
    }else if (model.type ==MessageType_Expire){
    
        
        [self performSegueWithIdentifier:@"MyClarifierDetailCostViewController" sender:model];
    }
    
}

-(void)performSegueOrderDtail:(SPClarifierMessageModel*)message{

    OrderDeitalViewController *vc =[[OrderDeitalViewController alloc]init];
    //订单详情id：OrderId
    vc.OrderId = message.nextparams;
    
    vc.status = OrderState_HadBeenPay;
    
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)configureCell:(MyClarifierMessageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
    SPClarifierMessageModel * model = _messageArr[indexPath.row];
    
    //[SPSDWebImage SPImageView:cell.messageLogo imageWithURL:model.pro_image placeholderImage:[UIImage imageNamed:@"productplaceholderImage"]];
    
    cell.messageTitle.text = model.title;
    
    cell.messageTime.text = [self getWebTimeConversionLocalTime:model.message_time];
    
    cell.messageIsRead.image = model.isread==0?[UIImage imageNamed:@"messageUNread"]:[UIImage imageNamed:@""];
    
    cell.messageContent.text = model.content;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
   CGFloat cellHeght  = [tableView fd_heightForCellWithIdentifier:@"CELL0" configuration:^(MyClarifierMessageTableViewCell* cell) {
       
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
   return  cellHeght<70?70:cellHeght;
    
//    return cellHeght;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    
        [self reuestDeleteMessage:self.messageArr[indexPath.row]];
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"MyClarifierDetailCostViewController"]) {
        
        MyClarifierDetailCostViewController * vc = segue.destinationViewController;
        
        SPClarifierMessageModel * Messagemodel = sender;
        
        UserPurifierListModel * model = [[UserPurifierListModel alloc]init];
        
        model.pro_no = Messagemodel.nextparams;
        
        model.color = @"";
//
        model.name = @"";
//
//        model.ord_protypeid =0;
        
        vc.model = model;
        
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
