//
//  SetViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "OrderDeitalViewController.h"
#import "OrderOneTableViewCell.h"
#import "orderTWoTableViewCell.h"
//#import "CommunityTableViewCell.h"
#import "SPUserModulesBusiness.h"
#import "OrderDetailModel.h"
#import "SPHomePageElectricityEntrance.h"
#import "SPGoPayDetailViewController.h"

@interface OrderDeitalViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *tableV;
    
    UIView *btnView;
    
    NSMutableArray *dataArr;
    
    UIAlertView *alert;
}

@property (nonatomic,strong) SPUserModulesBusiness * business ;

@end

@implementation OrderDeitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订单详情";
    
    self.view.backgroundColor = SPViewBackColor;
    
    dataArr = [NSMutableArray array];
    
    [self initWithUI];
    
    [self initNetWork];
    
    [self compatibleAvailable_ios11:tableV];
}


-(void)initNetWork
{
    [SPSVProgressHUD show];
    
    NSDictionary * dic = @{@"ord_no":self.OrderId};
    
    [self.business getUserMyOrderDetail:dic success:^(id result) {
       
        [dataArr removeAllObjects];
        
        [SPSVProgressHUD dismiss];
        
        if ([result isKindOfClass:[NSArray class]] || result != NULL) {
            NSMutableArray *listArr = [NSMutableArray array];
            listArr= [OrderDetailModel mj_objectArrayWithKeyValuesArray:result];
   
            if (listArr.count != 0) {
                [dataArr addObject:listArr[0]];
                
//                if (!_status) {
                    OrderDetailModel *m = dataArr[0];
                    
                    self.status = [m.status integerValue];
                    
                    [self initPayUI];
//                }
                
            }
        }
        
        [tableV reloadData];
    } failer:^(NSString *error) {
        [SPSVProgressHUD dismiss];
        __weak typeof(self) weakself  = self ;
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        
    }];

    
}

-(void)initWithUI{
   
    if (_status == OrderState_NonPayment) {
       
        tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-SCREEN_HEIGHT *0.075-1) style:UITableViewStylePlain];
    }else{
        
        tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    }
    
    tableV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    tableV.delegate = self;
    
    tableV.dataSource = self;
    
    tableV.separatorStyle = YES;
    
    [self.view addSubview:tableV];
    
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, tableV.frame.size.width, 1)];
    clearView.backgroundColor= [UIColor clearColor];
    [tableV setTableFooterView:clearView];
 
    alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"删除订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
//    [self initPayUI];
}

-(void)initPayUI{
    
    float backHeight = SCREEN_HEIGHT *0.075;
   
    if (_status == OrderState_NonPayment) {
        btnView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-backHeight-64, SCREEN_WIDTH, backHeight)];
        btnView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:btnView];
        
        UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        payBtn.frame = CGRectMake(SCREEN_WIDTH-15-SCREEN_WIDTH*0.2, 5, SCREEN_WIDTH*0.2, btnView.frame.size.height-10);
        payBtn.layer.cornerRadius = 3;
        payBtn.backgroundColor = SPNavBarColor;
        [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [payBtn addTarget:self action:@selector(payClick) forControlEvents:UIControlEventTouchUpInside];
        payBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        payBtn.layer.masksToBounds = YES;
        payBtn.layer.cornerRadius = 3;
        [btnView addSubview:payBtn];
        
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(payBtn.frame.origin.x-payBtn.frame.size.width-10, 5, SCREEN_WIDTH*0.2, payBtn.frame.size.height);
        cancelBtn.layer.borderWidth = 1;
        cancelBtn.layer.borderColor = [UIColor colorWithHexString:@"efeff4"].CGColor;
        [cancelBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:SPNavBarColor forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.layer.cornerRadius = 3;
        [btnView addSubview:cancelBtn];
    }

}

-(void)payClick{
    //立即支付
    UIViewController* vc;
    if (dataArr.count >0) {
        OrderDetailModel *m = dataArr[0];
        
        vc  =  [SPHomePageElectricityEntrance getPayDetailViewController:m];
    }else{
        
        vc  =  [SPHomePageElectricityEntrance getPayDetailViewController:nil];
    }
    
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)cancelClick{
    //删除订单
  
    [alert show];

}

-(void)initDelOrderNetWork{
    //删除订单
    NSDictionary * dic = @{@"ord_no":self.OrderId};
    
    __weak typeof(self) weakself  = self ;
    
    [self.business getUserOrderDel:dic success:^(id result) {
        
        
        [SPSVProgressHUD showSuccessWithStatus:@"删除成功"];

        __block BOOL isok = NO ;
        
        [weakself.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[SPGoPayDetailViewController class]]) {
                
                isok = YES ;
                
                *stop = YES ;
            }
        }];
        
        if (isok) {
            
            [weakself.navigationController popToRootViewControllerAnimated:YES];
        }else{
            
            [weakself.navigationController popViewControllerAnimated:YES];
        }
 
        
    } failer:^(NSString *error) {
        
        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        
    }];
    
}

#pragma mark - UIalertDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        if (_delBlock) {
            //订单列表
            
            _delBlock(_OrderId);
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            //其他
            
            [self initDelOrderNetWork];
            
        }
        
    }else{
 
    }
}
#pragma  mark UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        UILabel *titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH-15, 0.053*SCREEN_HEIGHT)];
        titlelabel.text = @"   买家信息";
        titlelabel.textColor = [UIColor colorWithHexString:@"777777"];
        titlelabel.font = [UIFont systemFontOfSize:15];
        
        return titlelabel;
    }else{
        UIView *view = [[UIView alloc]init];
        
        return view;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 0.053*SCREEN_HEIGHT;
    }else{
        return 10;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 4;
    }else if (section == 3){
        return 2;
    }else{
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderDetailModel *m;

    if (dataArr.count > 0) {
        m = dataArr[0];
    }
    //真是不想说 这样的代码了 慢慢改吧
    if (indexPath.section == 0) {
    
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
        cell.textLabel.text = [NSString stringWithFormat:@"订单编号:%@",self.OrderId];
        
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
        UILabel *statuslabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 0, 80, 50)];
        
        statuslabel.text = [m fetchOrderStateDescription];

        statuslabel.font = [UIFont systemFontOfSize:16];

        statuslabel.adjustsFontSizeToFitWidth = YES;
        
        statuslabel.textAlignment = NSTextAlignmentRight;
        
        statuslabel.textColor = [UIColor orangeColor];
        
        [cell.contentView addSubview:statuslabel];
       
        
        
        return cell;
    }else if (indexPath.section == 1){
       
        OrderOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderOneTableViewCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderOneTableViewCell" owner:self options:nil]lastObject];
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [SPSDWebImage SPImageView: cell.imgView imageWithURL:m.url placeholderImage:[UIImage imageNamed:SPPRODUCTICOPLACEHOLDERImage]];
        
        if (m.name.length > 0  ) {
            cell.titleLabel.text = [NSString stringWithFormat:@"%@(%@)",m.name,m.color];
        }
        
        NSString * detailString = @"";
        
        if (m.isagain==SPAddorder_Type_PAY) {
            
            detailString = m.paytype==ClarifierCostType_YearFree?[NSString stringWithFormat:@"包年费用:%.2f",m.price]:[NSString stringWithFormat:@"流量预付:%.2f",m.price];
        }else if (m.isagain==SPAddorder_Type_Renewal){
        
            detailString = m.paytype==ClarifierCostType_YearFree?[NSString stringWithFormat:@"包年续费:%.2f",m.price]:[NSString stringWithFormat:@"流量续费:%.2f",m.price];
        }
        
        cell.priceLabel.text = detailString;
        return cell;
        
    }else if (indexPath.section == 2){
         orderTWoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderTWoTableViewCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"orderTWoTableViewCell" owner:self options:nil]lastObject];
        }
        
        if (indexPath.row == 1) {
            cell.titlelabel.text = @"家庭地址";
            
            if (m) {
                cell.deitaiLabel.font = [UIFont systemFontOfSize:13];
                
                cell.deitaiLabel.text = m.address;
                cell.deitaiLabel.numberOfLines = 0;
                
            }

        }else if (indexPath.row == 2){
             cell.titlelabel.text = @"联系电话";
            if (m) {
                cell.deitaiLabel.text = m.phone;
            }
        }else if (indexPath.row == 3){
            cell.deitaiLabel.textColor = SPNavBarColor;
            
             cell.titlelabel.text = @"安装时间";
            if (m) {
                cell.deitaiLabel.text = m.serttime;
            }
        }else{
            cell.titlelabel.text = @"联系人";
            if (m) {
                cell.deitaiLabel.text = m.uname;
            }
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }else{
         orderTWoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderTWoTableViewCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"orderTWoTableViewCell" owner:self options:nil]lastObject];
        }
        
        cell.deitaiLabel.textAlignment = NSTextAlignmentRight;
        if (indexPath.row == 0) {
            cell.titlelabel.text = @"支付方式";
            if (m) {
                
                if ([m.way isEqualToString:@"0"]) {
                    cell.deitaiLabel.text = @"支付宝";
                }else if ([m.way isEqualToString:@"1"]){
                    cell.deitaiLabel.text = @"微信";
                }else{
                    cell.deitaiLabel.text = @"银联";
                }
            }
        }else{
            cell.titlelabel.text = @"全额支付";
            
            cell.deitaiLabel.textColor = [UIColor colorWithHexString:@"fd6212"];
            
            if (m) {
              
                cell.deitaiLabel.text = [NSString stringWithFormat:@"%.2f元",m.price];
            }
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell高度代理
    if (indexPath.section == 2) {
        return 45;
    }else if (indexPath.section == 3||indexPath.section == 0){
        return 50;
    }else{
        return 115;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //cell点击事件
    
}

-(SPUserModulesBusiness *)business{

    if (_business == nil) {
        
        _business = [[ SPUserModulesBusiness alloc] init];
        
    }

    return _business;
}



@end
