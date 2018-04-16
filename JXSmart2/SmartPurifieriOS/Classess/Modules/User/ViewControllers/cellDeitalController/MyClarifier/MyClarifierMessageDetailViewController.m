//
//  MyClarifierMessageDetailViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2017/1/3.
//  Copyright © 2017年 SmartPurifieriOS. All rights reserved.
//

#import "MyClarifierMessageDetailViewController.h"

@interface MyClarifierMessageDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation MyClarifierMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息中心";
   
    [self compatibleAvailable_ios11:_myTableView];
}




#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
    
    //    cell.messageContent.text = model.mess_typename==ClarifierCostType_YearFree?[NSString stringWithFormat:@"包年服务费剩余%@天,%@到期",model.mess_lastdate,model.mess_invalidtime]:[NSString stringWithFormat:@"目前使用流量%@升",model.mess_hasflow];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    CGFloat cellHeght  = [tableView fd_heightForCellWithIdentifier:@"CELL0" configuration:^(MyClarifierMessageTableViewCell* cell) {
//        
//        [self configureCell:cell atIndexPath:indexPath];
//    }];
//    
//    return  cellHeght<70?70:cellHeght;
    
    return 165.f;
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
