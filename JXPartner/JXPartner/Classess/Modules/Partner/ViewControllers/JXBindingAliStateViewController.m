//
//  JXBindingAliStateViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/18.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXBindingAliStateViewController.h"
#import "JXBindingAliStateTableViewCell.h"
#import "JXPartnerBusiness.h"
#import "SPUserModel.h"
#import "ShieldEmoji.h"
@interface JXBindingAliStateViewController ()<JXBindingAliStateTableViewCellDelegate>

@property (nonatomic,strong) UIView * agreementView ;

@property (nonatomic,strong) UIButton * checkBT ;

@property (nonatomic,strong) JXPartnerBusiness * business ;


@property (weak, nonatomic) IBOutlet UIButton *stateBtn;

@property (nonatomic,copy) NSString * payname ;
@property (nonatomic,copy) NSString * payaccount ;


@end

@implementation JXBindingAliStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self loadViewForAliState:_aliState];
    
}


#pragma mark - 更新按钮
-(void)confirmAgreement{
    
    BOOL iselect = _checkBT.selected;
    
    _checkBT.selected = !iselect;
    
}

-(void)loadViewForAliState:(AliBindingState)state{
    
    if (state == AliBindingState_Binded) {
        //已绑定

        //移除
        [self.stateBtn removeTarget:self action:@selector(bingingAliAccontAction) forControlEvents:UIControlEventTouchUpInside];
        [self.stateBtn addTarget:self action:@selector(requestUnBindingAliData) forControlEvents:UIControlEventTouchUpInside];
        
        [self.stateBtn setTitle:@"解绑" forState:UIControlStateNormal];
    }else if (state == AliBindingState_Notbind){
        //未绑定
        
        [self.stateBtn setTitle:@"绑定" forState:UIControlStateNormal];
        
        [self.stateBtn removeTarget:self action:@selector(requestUnBindingAliData) forControlEvents:UIControlEventTouchUpInside];
        [self.stateBtn addTarget:self action:@selector(bingingAliAccontAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.tableView reloadData];
}

#pragma mark - 获取状态
-(void)requestFetchAliBindState{
    

    __weak  typeof(self)  weakself  = self ;
    
    [self.business fetchBindingAliInformation:@{} success:^(id result) {
        
        if (result) {
            
            weakself.aliState = AliBindingState_Binded;
            
        
        }else {
            
            weakself.aliState = AliBindingState_Notbind;
            
        }
        weakself.stateModel = result ;
        
        [weakself loadViewForAliState:weakself.aliState];
        
    } failer:^(id error) {
        
        [weakself makeToast:error];
        
    }];
    
}


-(void)bingingAliAccontAction{

    if (_aliState == AliBindingState_Binded){
        
        [self makeToast:@"已经绑定"];
        
        return ;
    }
    
    if ([_payaccount stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        
        [self makeToast:@"请输入支付宝账号" ];
        
        return ;
    }
    if ([_payname stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        
        [self makeToast:@"请输入真实姓名" ];
        
        return ;
    }
    
    if ([ShieldEmoji isContainsNewEmoji:_payname] || [ShieldEmoji isContainsNewEmoji:_payaccount]) {
        
        [self makeToast:@"不能包含表情"];
        
        return ;
    }
    
    if (!_checkBT.isSelected) {
        
        [self makeToast:@"请确认此账号为为提现收款账号"];
        
        return ;
    }
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示"message:@"本人确认支付宝账号输入无误"preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self requestBingingAliData];
    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    

    
}

#pragma mark- 请求绑定
-(void)requestBingingAliData{
    
    [self  showWithStatus:@"绑定中..."];
  
    __weak typeof(self) weakself = self ;
    
    [self.business  bindingAliInformation:@{@"pay_name":_payname,@"pay_account":_payaccount} success:^(id result) {
        
        [weakself showSuccessWithStatus:@"绑定成功"];
        
        weakself.stateModel = result ;
        
        weakself.aliState = AliBindingState_Binded;
        
        [weakself loadViewForAliState:weakself.aliState];
        
    } failer:^(id error) {
        
        [UIViewController dismiss];
        
        [weakself makeToast:error];
    }];
    
}

#pragma mark - 请求解绑
-(void)requestUnBindingAliData{
    
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"提示"message:@"您确认解绑吗?"preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        __weak typeof(self) weakself = self ;
        
        [self.business  unbundlingAliInformation:@{} success:^(id result) {
            
            [weakself showSuccessWithStatus:@"解绑成功"];
            
            weakself.aliState = AliBindingState_Notbind ;
            
            [weakself loadViewForAliState:weakself.aliState];
            
        } failer:^(id error) {
            
            [weakself makeToast:error];
            
        }];

    }];
    
    [alertController addAction:cancelAction];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    JXBindingAliStateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLTEXT" forIndexPath:indexPath];
    
    cell.indexPath = indexPath ;
    
    cell.cellLabel.text = indexPath.row == 0 ?@"支付宝账号:":@"真实姓名:";
    
    cell.delegate = self ;
    
    if (_aliState == AliBindingState_Binded) {
        
        cell.cellText.enabled = NO ;
        
        cell.cellText.text = indexPath.row == 0 ? _stateModel.pay_account:_stateModel.pay_name;
    }else{
    
        cell.cellText.enabled = YES ;
        
        cell.cellText.text = @"";
        
    }
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (_aliState == AliBindingState_Notbind) {
        
        return self.agreementView ;
    }
    
    return nil ;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    if (_aliState == AliBindingState_Notbind) {
        
        return 40.f;
    }
    
    return .1f;
}


-(void)cell_BindingAliStatetTextChange:(NSString *)text index:(NSIndexPath *)index{


    
    if (index.row==0) {
        _payaccount = text ;
    }else
        _payname = text ;

}


-(UIView *)agreementView{
    
    if (_agreementView == nil) {
        
        _agreementView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40.f)];
        
        UIButton * checkbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [checkbtn setImage:[UIImage imageNamed:@"CheckNormal"] forState:UIControlStateNormal];
        
        [checkbtn setImage:[UIImage imageNamed:@"CheckedBlue"] forState:UIControlStateSelected];
        
        checkbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        
        [checkbtn addTarget:self action:@selector(confirmAgreement) forControlEvents:UIControlEventTouchUpInside];
        
        checkbtn.frame = CGRectMake(15, 5, 30, 30);
        
        [_agreementView addSubview:checkbtn];
        
        _checkBT = checkbtn;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, SCREEN_WIDTH-55, 30)];
        
        label.font = [UIFont systemFontOfSize:16];
        
        label.textColor = [UIColor colorWithHexString:@"333333"];
        
        NSString * text = @"本人确认此账号为提现收款账号";
        
//        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
//        
//        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:text attributes:attribtDic];
//        
//        [attribtStr addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:(NSRange){0,[text length]}];
//        
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forwardAgreement)];
//        
//        label.userInteractionEnabled = YES ;
//        
//        [label addGestureRecognizer:tap];
//        
//        //赋值
//        label.attributedText = attribtStr;
        
        label.text = text;
        
        [_agreementView addSubview:label];
        
    }
    
    return _agreementView;
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


-(NSArray*)fetchCellTitleArr{

    return @[@"支付宝账号",@"真实姓名"];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
