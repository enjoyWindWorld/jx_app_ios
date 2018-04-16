//
//  SPUserAddressListViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/17.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPUserAddressListViewController.h"
#import "SPUserAddressListTableViewCell.h"
#import "spuserAddressListModel.h"
#import "SPUserModulesBusiness.h"
#import "SPUserChangeAddressViewController.h"

@interface SPUserAddressListViewController ()<UITableViewDelegate,UITableViewDataSource,SPUserAddressListTableViewCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong) NSMutableArray * addressList ;

@property (nonatomic,strong) SPUserModulesBusiness * business ;

@end

@implementation SPUserAddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"家庭地址";
    
    self.myTableView.tableFooterView = [UIView new];
    
    self.myTableView.emptyDataSetSource = self ;
    
    self.myTableView.emptyDataSetDelegate = self ;
    
    _business = [[SPUserModulesBusiness alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(addAddressListClick)];
    

    

    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self requestHomeAddressList];
}


#pragma mark - 获取列表
-(void)requestHomeAddressList{
    
    __weak typeof(self) weakself = self ;

    [_business getUserHomeList:@{} success:^(id result) {
        
        [weakself.addressList removeAllObjects];
        
        [weakself.addressList addObjectsFromArray:result];
        
        [weakself.myTableView reloadData];
        
    } failer:^(NSString *error) {
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
    
}


/**
 新增
 */
-(void)addAddressListClick{

    [self performSegueWithIdentifier:@"SPUserChangeAddressViewController" sender:nil];

}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.addressList.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SPUserAddressListTableViewCell * CELL = [tableView dequeueReusableCellWithIdentifier:@"CELL0" forIndexPath:indexPath];
    
    CELL.model = self.addressList[indexPath.section];
    
    CELL.delegate = self ;
    
    return CELL;
    

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    spuserAddressListModel * model = self.addressList[indexPath.section];
    
    if (_chooseAddressHandle) {
        
        _chooseAddressHandle(model);
        
        [self.navigationController popViewControllerAnimated:YES];
        
        return ;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return .1f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10.f ;
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

    if ([segue.identifier isEqualToString:@"SPUserChangeAddressViewController"]) {
        
        UINavigationController * vc = segue.destinationViewController ;
        
        SPUserChangeAddressViewController * vcs = (SPUserChangeAddressViewController*)vc.topViewController;
      
        vcs.listModel = sender;
        
    }
    
}


#pragma mark - SPUserAddressListTableViewCellDelegate

-(void)cellModelWithState:(AddressCellActionState)state withModel:(spuserAddressListModel *)listmdoel{

    if (!listmdoel) {
        
        return ;
    }
    
    switch (state) {
        case AddressCellActionState_Delete:
            
            [self requestClickWithDeletewithModel:listmdoel];
            
            break;
            
            case AddressCellActionState_Change:
            
            [self requestClickWithChangewithModel:listmdoel];
            
            break ;
            
            case AddressCellActionState_Default:
            
           [ self requestClickWithDefaultwithModel:listmdoel];
            
            break ;
            
        default:
            
            [ self requestClickWithDefaultwithModel:listmdoel];
            
            break;
    }
}

#pragma mark - 点击设置默认
-(void)requestClickWithDefaultwithModel:(spuserAddressListModel *)listmdoel {

     __weak typeof(self) weakself = self ;
    
    [self.business getModifyHomeAddress:@{@"id":listmdoel.addessid,@"name":listmdoel.name,@"phone":listmdoel.phone,@"area":listmdoel.area,@"detail":listmdoel.detail,@"code":@"111",@"isdefault":[NSNumber numberWithInteger:!listmdoel.isdefault]} success:^(id result) {
        
        [SPSVProgressHUD showSuccessWithStatus:@"修改成功"];
        
        [weakself requestHomeAddressList];
        
    } failer:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];

}
#pragma mark - 点击修改
-(void)requestClickWithChangewithModel:(spuserAddressListModel *)listmdoel{
    
    [self performSegueWithIdentifier:@"SPUserChangeAddressViewController" sender:listmdoel];
    
}
#pragma mark - 点击删除
-(void)requestClickWithDeletewithModel:(spuserAddressListModel *)listmdoel{
    
      __weak typeof(self) weakself = self ;
    
    NSInteger index = [self.addressList indexOfObject:listmdoel];
    
    [self.addressList removeObject:listmdoel];
    
    [self.business getDeleteHomeAddress:@{@"id":listmdoel.addessid} success:^(id result) {
        
        [SPSVProgressHUD showSuccessWithStatus:@"删除成功"];
        
        [weakself.myTableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationLeft];
        
        if (weakself.addressList.count==0) {
            
            [weakself.myTableView reloadData];
        }
        
        
    } failer:^(NSString *error) {
        
        [SPSVProgressHUD dismiss];
        
        [SPToastHUD makeToast:error duration:3 position:nil makeView:weakself.view];
        
    }];
    
}




-(NSMutableArray *)addressList{

    if (_addressList == nil) {
        
        _addressList = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _addressList ;
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
