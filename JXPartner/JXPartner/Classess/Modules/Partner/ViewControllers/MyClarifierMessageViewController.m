//
//  MyClarifierMessageViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/16.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MyClarifierMessageViewController.h"
#import "MyClarifierMessageTableViewCell.h"
#import "JXPartnerBusiness.h"
#import "JXMessageModel.h"
#import "JXNewIncomeTableViewController.h"

@interface MyClarifierMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * messageArr ;

@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (nonatomic,assign) BOOL  isEditing ;
@end

@implementation MyClarifierMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息中心";
        
    self.navigationItem.rightBarButtonItem   = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(batchAllEditingAction)];
    
    [self.myTableView addJXEmptyView];
    
    _currentPage = 1;
    
    _messageArr = [NSMutableArray arrayWithCapacity:0];
    
    _myTableView.tableFooterView = [UIView new];

    [self addMJRefreshView];
    
    [self reuestMessageListData:_currentPage];
    // Do any additional setup after loading the view.
}


-(void)addMJRefreshView{
    
    __weak typeof(self) weakself = self ;
    
    [self.myTableView addJX_NormalHeaderRefreshBlock:^{
        
          [weakself reuestMessageListData:1];
    }];
    
    [self.myTableView addJX_NormalFooterRefreshBlock:^{
        
         [weakself reuestMessageListData:weakself.currentPage+1];
        
    }];
    
}


-(void)batchAllEditingAction{
    
    BOOL tempediting = !_isEditing ;
    
    _isEditing = tempediting ;
    
    [_myTableView reloadData];
    
    if (_isEditing) {
        
        self.navigationItem.rightBarButtonItem   = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(configMessageAllDelete)];
        
    }else{
        self.navigationItem.rightBarButtonItem   = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(batchAllEditingAction)];
    }
}

-(void)configMessageAllDelete{
    
    NSMutableString * string = @"".mutableCopy;
    
    [_messageArr enumerateObjectsUsingBlock:^(JXMessageModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.selected) {
           
            [string appendFormat:@"%@,",obj.p_id];
        }
    }];
    
    if (string.length == 0) {
        
        [self batchAllEditingAction];
        
        return ;
    }
    
    [self confirmMessageWithDeleteHandler:^(UIAlertAction *action) {
        
        [SVProgressHUD showWithStatus:@"请稍后..."];
        
        NSString * newstring = [string substringToIndex:string.length-1];
        
        [self reuestDeleteMessage:newstring];
        
    }];
    
 
}


-(void)reuestMessageListData:(NSInteger)page{
    
    _currentPage = page ;
    
    __weak typeof(self) weakself = self ;
    
    [self.business fetchPartnerMessageList:@{@"page":[NSNumber numberWithInteger:page]} success:^(id result) {
        
         NSArray * resultArr = result ;
        
        [weakself.myTableView JXendRefreshing];
        
        if (page==1) {

            [weakself.messageArr removeAllObjects];
        }
        
        [weakself.messageArr addObjectsFromArray:resultArr];
        
        if(resultArr.count==0){
            
            [weakself.myTableView JXfooterEndNoMoreData];
            
        }
        
        [weakself.myTableView reloadData];
        
    } failer:^(NSString *error) {
        
        [weakself.myTableView JXendRefreshing];
        
        [weakself makeToast:error];
        
    }];
    
}


-(void)reuestMessageDefaultRead:(NSString*)messageid{
    
    __weak typeof(self) weakself = self ;
    
    [self.business fetchPartnerMessageSetReaded:@{@"id":messageid} success:^(id result) {
        
        [weakself.messageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            JXMessageModel * model = obj;
            
            if ([model.p_id isEqualToString:messageid]) {
                
                model.p_isread = 1;
                
                * stop  = YES;
            }
            
        }];
        
        if (weakself.didHander) {
            
            weakself.didHander();
        }
    } failer:^(NSString *error) {
        
        [weakself makeToast:error];
        
    }];
    
}

-(void)reuestDeleteMessage:(NSString*)message_id{
    
    __weak typeof(self) weakself = self ;
    
    [self.business fetchPartnerMessageDelete:@{@"id":message_id} success:^(id result) {
        
     [weakself showSuccessWithStatus:@"删除成功"];

     [weakself reuestMessageListData:1];
        
    } failer:^(NSString *error) {
        
        [UIViewController dismiss];
        
        [weakself makeToast:error];
    }];
    
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
    
    if (_isEditing){
        
        if (_messageArr.count >indexPath.row) {
            
            JXMessageModel * model = _messageArr[indexPath.row];
            
            if (model.p_type == JXMessageType_SuperAdult || model.p_type == JXMessageType_ChangeFree) {
                
                [self otherMessageNotDelete];
                
                return ;
            }
            
            model.selected = !model.selected ;
            
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        return ;
    }
    
    if (_messageArr.count >indexPath.row) {
        
        JXMessageModel * model = _messageArr[indexPath.row];
        
        if (!model) return;
        
        if (model.p_isread == JXMessageState_NotRead) {
            
            [self reuestMessageDefaultRead:model.p_id];
        }
        
        if (model.p_type == JXMessageType_SuperAdult || model.p_type == JXMessageType_ChangeFree) {
            
            [self performSegueWithIdentifier:@"JXNewIncomeTableViewController" sender:model];
            
        }
    }
}

-(void)otherMessageNotDelete{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"该消息为特殊消息，无法删除" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];

    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)confirmMessageWithDeleteHandler:(void (^ __nullable)(UIAlertAction *action))handler{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定删除该消息？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:handler];
    
    [alert addAction:action];
    
     [alert addAction:action1];
    
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)configureCell:(MyClarifierMessageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    JXMessageModel * model = _messageArr[indexPath.row];
    
    cell.messageTitle.text = model.p_title;
    
    cell.messageTime.text = model.message_time;
    
    cell.messageIsRead.image = model.p_isread==0?[UIImage imageNamed:@"messageUNread"]:[UIImage imageNamed:@""];
    
    cell.messageContent.lineBreakMode = NSLineBreakByCharWrapping;
    
    cell.messageContent.text = model.p_content;
 
    cell.checkbtWidthLayout.constant = _isEditing == YES ? 40.f :0.f ;
    
    UIImage * image = [UIImage imageNamed:model.selected == YES ? @"CheckedBlue": @"CheckNormal"];
    
    [cell.checkbt setImage:image forState:UIControlStateNormal];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   CGFloat cellHeght  = [tableView fd_heightForCellWithIdentifier:@"CELL0" configuration:^(MyClarifierMessageTableViewCell* cell) {
       
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
   return  cellHeght<70?70:cellHeght;
    

}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return  UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (_messageArr.count > indexPath.row) {
            
            JXMessageModel * model = _messageArr[indexPath.row];
            
            [self confirmMessageWithDeleteHandler:^(UIAlertAction *action) {
                
                [self reuestDeleteMessage:model.p_id];
            }];
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    return @"删除";
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"JXNewIncomeTableViewController"]) {
        
        JXMessageModel * model = sender ;
        
        JXNewIncomeTableViewController * vc = segue.destinationViewController ;
        
        vc.walletOrdersn = model.nextparams;
        
        vc.isAdult = model.p_type == JXMessageType_SuperAdult ? YES : NO;
    }
    
}


-(JXPartnerBusiness *)business{

    if (!_business) {
        
        _business = [[JXPartnerBusiness alloc] init];
    }
    
    return _business ;
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
