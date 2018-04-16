//
//  JXIncomeViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/17.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXIncomeViewController.h"
#import "JXPartnerBusiness.h"
#import "SPUserModel.h"
#import "JXBindingAliStateModel.h"
#import "JXBindingAliStateViewController.h"
#import "JXNewIncomeTableViewController.h"
#import "RxWebViewController.h"

#define  TOTAL_MONEY_KEY @"withdrawal_total_amount"
#define  DRAWAL_ORDERNO_KEY @"withdrawalOrderNo"


@interface JXIncomeViewController ()



@property (weak, nonatomic) IBOutlet UILabel *incomeMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *aliBindState;

@property (nonatomic,strong) JXPartnerBusiness * business ;

@property (nonatomic,assign) AliBindingState  aliState ;

@property (nonatomic,strong) JXBindingAliStateModel * model ;

@property (nonatomic,copy) NSString * orderNO ;

@end

@implementation JXIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收入";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现规则" style:UIBarButtonItemStylePlain target:self action:@selector(roles)];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self requestFetchTiXianitemState];
    
    [self requestFetchAliBindState];
    
}

#pragma mark - 提现规则
-(void)roles{


    RxWebViewController * vc = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:JXCashRuleURL]];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark - 获取支付宝状态
-(void)requestFetchAliBindState{

    __weak  typeof(self)  weakself  = self ;
    
    [self.business fetchBindingAliInformation:@{} success:^(id result) {
        
        if (result) {
            
            weakself.aliState = AliBindingState_Binded;
            
            weakself.aliBindState.text = @"已绑定";
            
        }else {
            
            weakself.aliState = AliBindingState_Notbind;
            
            weakself.aliBindState.text = @"未绑定";
        }
        
        weakself.model = result ;
        
        [weakself.tableView reloadData];
        
    } failer:^(id error) {
        
        [weakself makeToast:error];
        
    }];
    
}


#pragma mark - 获取需要提现的金额
-(void)requestFetchTiXianitemState{

    __weak  typeof(self)  weakself  = self ;

     [self showWithStatus:@"请稍后..."];
    
    [self.business fetchTiXianSalesAllMoney:@{} success:^(id result) {
        
          [UIViewController dismiss];
        
        if ([result isKindOfClass:[NSDictionary class]]) {
            
            NSDictionary * dic = result ;
            
            CGFloat money  = [dic[TOTAL_MONEY_KEY] floatValue];
                        
            weakself.orderNO = money == 0 ? nil : dic[DRAWAL_ORDERNO_KEY];
            
            weakself.incomeMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f元",money];
            
        }else{
        
            weakself.orderNO = nil;
            
            weakself.incomeMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f元",0.00];
        }

    } failer:^(id error) {
        
        [UIViewController dismiss];
        
        if ([error isKindOfClass:[NSNumber class]]) {
            
            NSInteger recoult = [error integerValue];
            
            if (recoult == 3) {
                
                weakself.incomeMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f元(%@)",0.00,@"未绑定支付宝"];
                
            }else if (recoult == 5){
            
                
                weakself.incomeMoneyLabel.text = [NSString stringWithFormat:@"￥%.2f元(%@)",0.00,@"无权限"];
                
            }
            //暂未绑定支付宝
            weakself.orderNO = nil;
            
        }else{
        
            [weakself makeToast:error];
        }

    }];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return .1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 20.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.section == 0) {
        
        if (!_orderNO )
            return ;
        
        [self performSegueWithIdentifier:@"JXNewIncomeTableViewController" sender:nil];
    }
    
    if (indexPath.section== 1 && indexPath.row==1) {
        
        [self performSegueWithIdentifier:@"JXIncomeHistoryViewController" sender:nil];
    }
    
    if (indexPath.section== 1 && indexPath.row==0) {
        
        [self performSegueWithIdentifier:@"JXBindingAliStateViewController" sender:nil];
    }
    
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier isEqualToString:@"JXBindingAliStateViewController"]) {
        
        JXBindingAliStateViewController * vc = segue.destinationViewController ;
        
        vc.aliState = _aliState;
        
        vc.stateModel = _model ;
    }else if ([segue.identifier isEqualToString:@"JXNewIncomeTableViewController"]){
    
        JXNewIncomeTableViewController * vc = segue.destinationViewController ;
        
        vc.walletOrdersn = self.orderNO;
        
        vc.defaultMoney = self.incomeMoneyLabel.text;
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


@end
