//
//  JXPartnerInfoViewController.m
//  JXPartner
//
//  Created by windpc on 2017/8/14.
//  Copyright © 2017年 windpc. All rights reserved.
//

#import "JXPartnerInfoViewController.h"
#import "JXPartnerItemCollectionViewCell.h"
#import "SPUserModel.h"
#import "CustomMyOrderListViewController.h"
#import "JXPartnerBusiness.h"
#import <GTSDK/GeTuiSdk.h>
#import "CustomJXSubPartnerView.h"
#import "UIView+MGBadgeView.h"
#import "ADRollView.h"
#import "JXNewsModel.h"
#import "RxWebViewController.h"

#define ITEMTEXTKEY @"ITEMTEXTKEY"
#define ITEMIMAGEKEY @"ITEMIMAGEKEY"
#define NormarOperater 0  //达到条件


@interface JXPartnerInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *partnerInfoTableView;

@property (weak, nonatomic) IBOutlet UICollectionView *partnerItemCollectionView;

@property (nonatomic,strong) NSArray * tableViewDataSource ;

@property (nonatomic,strong) NSArray * collectionDataSource ;

@property (nonatomic,strong) JXPartnerBusiness * business;

@property (nonatomic,strong)   JXPartnerItemCollectionViewCell * cell ;
@property (weak, nonatomic) IBOutlet ADRollView *newsContent;
@property (nonatomic,strong) NSArray * newsArr ;



@end

@implementation JXPartnerInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"";
    
    self.navigationController.delegate = self;
    
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"1.png" ofType:nil]];
    
    self.view.layer.contents = (id) image.CGImage;
    
    
    SPUserModel * model = [SPUserModel fetchPartnerModelDF];
    
    if ([[NSDate date] timeIntervalSince1970] - model.timeout > 60) {
        
        [self  requestPartnerInfoation];
    }else{
        
        if ((model.operatorInter == NormarOperater) ) {
            UIAlertController * ale = [UIAlertController alertControllerWithTitle:@"提示" message:@"你已经达到升级运营商的条件了!" preferredStyle:UIAlertControllerStyleAlert];
     
        
            UIAlertAction * act2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
//            [ale addAction:act];
            [ale addAction:act2];
            
            [self presentViewController:ale animated:YES completion:nil];
        }
    }
    
    self.partnerInfoTableView.layer.cornerRadius = 5.f;
    
    self.partnerInfoTableView.layer.masksToBounds = YES ;
    

    _partnerInfoTableView.tableFooterView = [UIView new];
    
    [_partnerItemCollectionView registerNib:[UINib nibWithNibName:@"JXPartnerItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"JXPartnerItemCollectionViewCell"];
    
    _collectionDataSource = @[
                              @{ITEMTEXTKEY:@"订单管理",ITEMIMAGEKEY:@"ordermanager"},
                              @{ITEMTEXTKEY:@"我的收入",ITEMIMAGEKEY:@"mymoney"},
                              @{ITEMTEXTKEY:@"我的e家",ITEMIMAGEKEY:@"subparnter"},
                              @{ITEMTEXTKEY:@"售后管理",ITEMIMAGEKEY:@"subparnter"},
                              @{ITEMTEXTKEY:@"我的消息",ITEMIMAGEKEY:@"mymessage"},
                              @{ITEMTEXTKEY:@"设置",ITEMIMAGEKEY:@"setting"}];
    
    
    [self  getPeopleInfoation];
    [self requestNewsList];
    
    
   
    // Do any additional setup after loading the view.
}

-(void)requestNewsList{
    
    __weak typeof(self) weakself = self ;
    
    [self.business fetchHomePageNewsList:@{@"type":@"0"} succcess:^(id result) {
        
        weakself.newsArr = result ;
       
        if ([weakself getData].count>0) {
            
            [weakself.newsContent  setVerticalShowDataArr:[self getData]];
            
            [weakself.newsContent start];
            
            weakself.newsContent.clickBlock = ^(NSInteger index) {
                
                if (weakself.newsArr.count>index) {
                    
                    JXNewsModel * newmodel = weakself.newsArr[index];
                    
                    RxWebViewController * web = [[RxWebViewController alloc] initWithUrl:[NSURL URLWithString:newmodel.news_url]];
                    
                    [weakself.navigationController pushViewController:web animated:YES];
                    
                }
                
            };
        }
       
        
    } failere:^(id error) {
        
        
        
    }];
    
    
}


- (NSMutableArray *)getData {
    
    NSMutableArray * adsArray = @[].mutableCopy;
    
    for (int i = 0; i < self.newsArr.count; i++) {
        
        JXNewsModel * newmodel = self.newsArr[i];
        
        ADRollModel *model = [[ADRollModel alloc] init];
        
        model.noticeType = newmodel.news_type_name;
        
        model.noticeTitle =newmodel.news_content;
        
        model.urlString = newmodel.news_url;
        
        [adsArray addObject:model];
    }
    
    return adsArray;
}

-(void)getPeopleInfoation{

    SPUserModel * model = [SPUserModel fetchPartnerModelDF];
    
    if (model) {
        
        NSString * name = [NSString stringWithFormat:@"姓名:%@",model.username];
        NSString * numberid = [NSString stringWithFormat:@"编号:%@",model.partnerNumber];
        NSString * level = [NSString stringWithFormat:@"级别:%@",[JXPartnerModulesMacro fetchParnerLevelString:model.level]];
        NSString * fathername = [NSString stringWithFormat:@"所属运营商编号:%@",model.ParParentName];
        NSString * fatherid= [NSString stringWithFormat:@"所属创客家园编号:%@",model.ParParentid];
        //        NSString * salesNumber = [NSString stringWithFormat:@"销售设备的总台数:%ld",(long)model.usernum];
        _tableViewDataSource = @[name,numberid,level,fathername,fatherid];
        
        [_partnerInfoTableView reloadData];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    
    [self requestMessageUnreadList];
        
}


-(void)requestPartnerInfoation{

     __weak typeof(self) weakself  = self ;
    
    [self.business fetchPartnerInformation:@{} success:^(id result) {
        
        SPUserModel * model = result ;
        
        model.timeout = [[NSDate date] timeIntervalSince1970];
        
        [model saveCurrentPartnerModel];
        
        [weakself getPeopleInfoation];
        
        
        
//        if (DEBUG) {
//
//            [GeTuiSdk bindAlias:[NSString stringWithFormat:@"test_%@",model.partnerNumber] andSequenceNum:model.partnerNumber];
//        }else{
         [GeTuiSdk bindAlias:model.partnerNumber andSequenceNum:model.partnerNumber];
//        } 
        if (model.originalpassword) {
            
            NSLog(@"当前为默认密码");
            
            [UIViewController showWithStatus:@"当前密码为初始密码,建议及时修改密码！" dismissAfter:10 styleName:STATETYPE_FAILERE];
            
        }else if (model.unboundedalipay) {
            
            NSLog(@"支付宝没有绑定");
             [UIViewController showWithStatus:@"支付宝当前没有绑定,建议及时绑定！" dismissAfter:10 styleName:STATETYPE_FAILERE];
        }
//        达到
        if (model.operatorInter == NormarOperater) {
            UIAlertController * ale = [UIAlertController alertControllerWithTitle:@"提示" message:@"你已经达到升级运营商的条件了!" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction * act = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            UIAlertAction * act2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [ale addAction:act];
            [ale addAction:act2];
            
            
            [self presentViewController:ale animated:YES completion:nil];
            
            
        }

        
    } failer:^(id error) {
        
        [UIViewController dismiss];
        
        [weakself makeToast:error];
        
    }];

    
}


-(void)requestMessageUnreadList{
    
    __weak typeof(self) weakself = self ;

    [self.business  fetchPartnerMessageListCount:@{} success:^(id result) {
        
        NSInteger count = [result  integerValue];
        
        count  =  MIN(99, count);
        
        weakself.cell.itemImage.badgeView.badgeValue = count ;

        [ weakself.cell.itemImage.badgeView setPosition:MGBadgePositionTopRight];
        
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber: MIN(99, count)];
        
    } failer:^(id error) {
        
        
    }];

    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _tableViewDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableView"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableView"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    tableView.backgroundColor = [UIColor colorWithRGB:213 G:213 B:213 alpha:0.5];
    
    cell.backgroundColor = [UIColor colorWithRGB:213 G:213 B:213 alpha:0.5];
    
    if (_tableViewDataSource.count>indexPath.row) {
        
        
        cell.textLabel.text = _tableViewDataSource[indexPath.row];
        
        cell.textLabel.adjustsFontSizeToFitWidth = YES ;

    }

    return cell ;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    return 35.f;
    
}


#pragma mark - UICollectionView
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _collectionDataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    JXPartnerItemCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JXPartnerItemCollectionViewCell" forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 5.f;
    
    cell.layer.masksToBounds = YES ;
    
    collectionView.backgroundColor = [UIColor clearColor];
    
    cell.backgroundColor = [UIColor colorWithRGB:213 G:213 B:213 alpha:0.5];
    
    cell.itemLabel.text = _collectionDataSource[indexPath.item][ITEMTEXTKEY];
    
    cell.itemImage.image = [UIImage imageNamed:_collectionDataSource[indexPath.item][ITEMIMAGEKEY]];
    
    if (indexPath.item == 4) {
        
        [cell.itemImage.badgeView setOutlineWidth:0.];
        
        [cell.itemImage.badgeView setPosition:MGBadgePositionTopRight];
        
        [cell.itemImage.badgeView setFont:[UIFont systemFontOfSize:16]];
        
        [cell.itemImage.badgeView setOutlineColor:[UIColor redColor]];
        
        [cell.itemImage.badgeView setBadgeColor:[UIColor redColor]];
        
        [cell.itemImage.badgeView setTextColor:[UIColor whiteColor]];
        
        _cell = cell ;
    }
    
    return cell ;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((collectionView.width-10*2)/3, (collectionView.height-10)/2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 10.f;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 10.f;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    // _collectionDataSource = @[@"订单管理",@"我的收入",@"我的下属",@"我的消息",@"设置"];
    
    if (indexPath.item == 0) {
        
        CustomMyOrderListViewController * vc = [[CustomMyOrderListViewController alloc] init];
        
        vc.title = @"订单管理";

        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.item == 1){
    
        [self performSegueWithIdentifier:@"JXIncomeViewController" sender:nil];
    
    }else if (indexPath.item == 2){
    
        CustomJXSubPartnerView * vc  = [[CustomJXSubPartnerView alloc] init];
        
        vc.title = @"我的下属";
        
        [self.navigationController  pushViewController:vc animated:YES];
    }else if (indexPath.item == 3){
//        [self performSegueWithIdentifier:@"MyClarifierMessageViewController" sender:nil];

        [self performSegueWithIdentifier:@"JXEvaluateTableViewController" sender:nil];
    }
    else if (indexPath.item == 4){
//     [self  performSegueWithIdentifier:@"JXPartnerSettingViewController" sender:nil];
        [self performSegueWithIdentifier:@"MyClarifierMessageViewController" sender:nil];
    
    }else if (indexPath.item == 5){
    
         [self  performSegueWithIdentifier:@"JXPartnerSettingViewController" sender:nil];
    }
    
}



- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(JXPartnerBusiness *)business{
    
    if (_business == nil) {
        
        _business  =[[JXPartnerBusiness alloc] init];
        
    }
    return  _business;
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
