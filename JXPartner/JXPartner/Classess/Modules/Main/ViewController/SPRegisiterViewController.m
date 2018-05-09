//
//  SPRegisiterViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPRegisiterViewController.h"
#import "SPMainLoginBusiness.h"
#import "SPResetPasswordViewController.h"
#import "UIButton+TimerClass.h"
#import "RegTableViewCell.h"
#import "RxWebViewController.h"
#import "RegLocalModel.h"
@interface SPRegisiterViewController ()<UITableViewDelegate,UITableViewDataSource,JXRegTableViewCellTableViewCellDelegate,UINavigationControllerDelegate>

@property(nonatomic,strong) SPMainLoginBusiness * buessiness;

@property (weak, nonatomic) IBOutlet UIButton *regisButton;
@property (weak, nonatomic) IBOutlet UIButton *rulesBtn;

@property (weak, nonatomic) IBOutlet UITableView *myTable;

@property (nonatomic,strong) UIView * agreementView ;

@property (nonatomic,strong) UIButton * checkBT ;

@property (nonatomic,strong) NSMutableArray * datas ;

@property (nonatomic,strong) NSArray * localArr ;


@end

@implementation SPRegisiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarTitle:@"注册"];

    [self setNavBarLeftBtn:[STNavBarView createImgNaviBarBtnByImgNormal:@"nav_back" imgHighlight:@"nav_back_highlighted" target:self action:@selector(viewGoPop)]];
    
    self.myTable.tableFooterView = self.agreementView;
    
    self.myTable.bounces = NO ;

    
//    [self.tableView setContentInset:UIEdgeInsetsMake(50, 0, 0, 0)];
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //控制器即将进入的时候调用
    
}

/**
 视图返回
 */
-(void)viewGoPop{

    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)regAction:(id)sender {
    
    [self.view endEditing:YES];
    
    
    for (RegLocalModel * mdoel in self.datas) {
        
        if (mdoel.rightContent.length == 0) {
            
            [self makeToast:[NSString stringWithFormat:@"请输入%@",mdoel.leftText]];
//            break ;
            return;
        }
    }
    
    if (!_checkBT.isSelected) {
        
        [self makeToast:@"请前往阅读服务协议并同意"];
        return ;
    }
    
    
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    dic[@"RecommenderCode"] = ((RegLocalModel*)self.datas[0]).rightContent;
    dic[@"NameReferee"] = ((RegLocalModel*)self.datas[1]).rightContent;
    //order
    dic[@"ord_no"] = ((RegLocalModel*)self.datas[2]).rightContent;
    dic[@"nameApplicant"] = ((RegLocalModel*)self.datas[3]).rightContent;
    dic[@"cardNumber"] = ((RegLocalModel*)self.datas[4]).rightContent;
    dic[@"mobilePhone"] = ((RegLocalModel*)self.datas[5]).rightContent;
    dic[@"s_province"] = self.localArr[0];
    dic[@"s_city"] = self.localArr[1];
    dic[@"s_county"] = self.localArr[2];
    dic[@"homeAddress"] = ((RegLocalModel*)self.datas[7]).rightContent;
    
     __weak typeof(self) weakslef = self ;
    [self showWithStatus:@"正在请求中..."];
    
    [self.buessiness requestUserRegister:dic success:^(id result) {
        
        NSDictionary * dic = [result firstObject] ;
        
        NSString * message = [NSString stringWithFormat:@"您的账号是:%@\n您的初始密码是:%@\n建议及时保存和修改密码",dic[@"id"],@"123456"];

        UIAlertController * ale = [UIAlertController alertControllerWithTitle:@"注册成功" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction * act = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [weakslef.navigationController popToRootViewControllerAnimated:YES];

        }];
        
        [ale addAction:act];
        
        [weakslef presentViewController:ale animated:YES completion:nil];
        
    } failer:^(id error) {
        
        [UIViewController dismiss];
        
        [weakslef makeToast:error];
        
    }];
    
    
    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RegTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    
    cell.delegate = self ;
    
    cell.indexPath = indexPath ;
    
    cell.vc = self ;
    
    __weak typeof(self) weakself = self ;
    [cell setChooseFinish:^(NSArray *arrData) {
        weakself.localArr = arrData ;
    }];
    
    RegLocalModel * model = self.datas[indexPath.row];
    
    cell.leftLabel.text = model.leftText;
    
    cell.contentText.text = model.rightContent ;

    return cell ;
    
}

-(void)cell_RegTextChange:(NSString *)text index:(NSIndexPath *)index{
    
   RegLocalModel * mdoel  = self.datas[index.row];
    
    if (mdoel) {
        mdoel.rightContent = text ;
    }
    if (index.row == 6) {
        
        [self.myTable reloadData];
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45.f;
}



#pragma mark - 前往服务协议
-(void)forwardAgreement{
    
    NSURL * url = [NSURL URLWithString:@"http://www.szjxzn.tech:8080/jx/pdf/partneragreement.pdf"];
    
    SPAgreetmentWebViewController* webViewController = [[SPAgreetmentWebViewController alloc] initWithUrl:url];
    
    webViewController.title = @"使用服务协议";
    
    __weak typeof(self) weakself = self;
    
    webViewController.confirmSelect = ^{
        
        weakself.checkBT.selected = YES;
        
    };
    
    [self.navigationController pushViewController:webViewController animated:YES];
    
}


#pragma mark - 更新按钮
-(void)confirmAgreement{
    
    BOOL iselect = _checkBT.selected;
    
    _checkBT.selected = !iselect;
    
}

-(UIView *)agreementView{
    
    if (_agreementView == nil) {
        
        _agreementView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        
        UIButton * checkbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [checkbtn setImage:[UIImage imageNamed:@"CheckNormal"] forState:UIControlStateNormal];
        
        [checkbtn setImage:[UIImage imageNamed:@"CheckedBlue"] forState:UIControlStateSelected];
        
        checkbtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        
        [checkbtn addTarget:self action:@selector(confirmAgreement) forControlEvents:UIControlEventTouchUpInside];
        
        checkbtn.frame = CGRectMake(15, 5, 30, 30);
        
        [_agreementView addSubview:checkbtn];
        
        _checkBT = checkbtn;
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(40, 5, 200, 30)];
        
        label.font = [UIFont systemFontOfSize:16];
        
        label.textColor = [UIColor colorWithHexString:@"333333"];
        
        NSString * text = @"同意服务协议";
        
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:text attributes:attribtDic];
        
        [attribtStr addAttribute:NSUnderlineColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:(NSRange){0,[text length]}];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forwardAgreement)];
        
        label.userInteractionEnabled = YES ;
        
        [label addGestureRecognizer:tap];
        
        //赋值
        label.attributedText = attribtStr;
        
        [_agreementView addSubview:label];
        
    }
    
    return _agreementView;
}



-(SPMainLoginBusiness *)buessiness{

    if (_buessiness == nil) {
        
        _buessiness = [[SPMainLoginBusiness alloc] init];
        
    }
    return _buessiness ;
}

-(NSMutableArray *)datas{
    
    if (!_datas) {
        
        NSArray * titles =  @[@"推荐人代码",@"推荐人姓名",@"申请人订单号",@"申请人姓名",@"身份证号码",@"手机号码",@"省市区",@"家庭地址"];
        
        _datas = [NSMutableArray arrayWithCapacity:0];
        
        for (int i = 0; i < titles.count; i++) {
            
            RegLocalModel * model = [[RegLocalModel alloc] init];
            model.leftText = titles[i];
            [_datas addObject:model];
        }
    }
    
    return _datas ;
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
