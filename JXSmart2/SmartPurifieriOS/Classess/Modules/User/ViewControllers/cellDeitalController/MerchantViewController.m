//
//  MerchantViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/28.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "MerchantViewController.h"
#import "CommunityTableViewCell.h"
#import "CleanDetailViewController.h"
#import "SPUserModulesBusiness.h"
#import "ServiceModel.h"
#import "SPUserModel.h"
#import "UIImageView+WebCache.h"


@interface MerchantViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    UITableView *tableV;
    
    NSMutableArray *dataArr;
    
    NSMutableArray *listArr;
    
    int page;
}


@end

@implementation MerchantViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的发布";
    self.view.backgroundColor = SPViewBackColor;
    
    listArr = [NSMutableArray array];
    
    dataArr = [NSMutableArray array];
    
    page = 1;
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableV.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.emptyDataSetSource = self;
    tableV.emptyDataSetDelegate = self;
    tableV.separatorStyle = YES;
    [self.view addSubview:tableV];
    
    [self  compatibleAvailable_ios11:tableV];
    
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, tableV.frame.size.width, 1)];
    clearView.backgroundColor= [UIColor clearColor];
    [tableV setTableFooterView:clearView];
    
    __weak __typeof (self)weakself = self;

    
    [tableV addJX_NormalHeaderRefreshBlock:^{
        
        [weakself headerRefresh];
        
    }];
    
    [tableV addJX_NormalFooterRefreshBlock:^{
        
        [weakself footRefresh];
    }];
    
    
    [self initNetWork];
}

-(void)initNetWork
{
    
    NSString *pagestr = [NSString stringWithFormat:@"%d",page];
    
    SPUserModel *model = [SPUserModel getUserLoginModel];
    NSDictionary * dic = @{@"phoneNum":model.UserPhone,
                           @"page":pagestr,
                           };
    
    __weak typeof(self) weakself  = self ;
    
    [[[SPUserModulesBusiness alloc]init] getMerchantRelease:dic success:^(id result) {
        
        if (page == 1) {
            [dataArr removeAllObjects];
        }
        
        if ([result isKindOfClass:[NSArray class]]) {
            
            listArr= [ServiceModel mj_objectArrayWithKeyValuesArray:result];
            
            if (listArr.count < 1) {
                if (page > 1) {
               
                    [SPToastHUD makeToast:@"没有更多的数据了" duration:2.5 position:nil makeView:weakself.view];
                }
                
            }else{
                for (int i=0;i<listArr.count;i++) {
                    [dataArr addObject:listArr[i]];
                }
            }
            
        }
        
        [tableV reloadData];
        
        [tableV JXendRefreshing];
        
    } failer:^(NSString *error) {
        

        [SPToastHUD makeToast:error duration:2.5 position:nil makeView:weakself.view];
        
        [SPSVProgressHUD dismiss];
        [tableV JXendRefreshing];
    }];
    
    
}

- (void)headerRefresh
{
    [dataArr removeAllObjects];
    page = 1;
    [self initNetWork];
    
}

- (void)footRefresh
{
    page ++;
    
    [self initNetWork];
}


#pragma  mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return dataArr.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell创建视图
    CommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityTableViewCell"];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommunityTableViewCell" owner:self options:nil]lastObject];
    }
    
    if (dataArr.count != 0) {
        ServiceModel *m = dataArr[indexPath.row];
        
        cell.deitallabel.numberOfLines = 0;
        cell.deitallabel.text = m.content;
        cell.titlelabel.text = m.seller;
        [cell.titlelabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        cell.addressLabel.text = m.address;
        NSString *timestr = [m.pub_addtime substringWithRange:NSMakeRange(0,10)];
        cell.timeLabel.text = timestr;
        
        cell.typeName.text = m.typenamestr;
        
        NSString * first = [[m.url componentsSeparatedByString:@","]firstObject];
        
        [SPSDWebImage SPImageView:cell.cellImg imageWithURL:first placeholderImage:[UIImage imageNamed:@"暂无图片1@2x"]];
        
        //    CGSize size = CGSizeMake(cell.deitallabel.frame.size.width,2000);
        //
        //    NSString *titleText = cell.deitallabel.text;
        //
        //    deitalSize = [titleText sizeWithFont:cell.deitallabel.font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        //
        //    [cell.deitallabel setFrame:CGRectMake(cell.deitallabel.frame.origin.x,cell.deitallabel.frame.origin.y, deitalSize.width, deitalSize.height)];
        //
        //    [cell.contentView addSubview:cell.deitallabel];
        
    }
    
    
    cell.selectionStyle=UITableViewCellSelectionStyleDefault;
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell高度代理
    return 0.15*SCREEN_HEIGHT;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //cell点击事件
    [tableV deselectRowAtIndexPath:indexPath animated:YES];
    CleanDetailViewController *vc = [[CleanDetailViewController alloc]init];
    
    ServiceModel *m = dataArr[indexPath.row];
    vc.pubId = m.pubId;
    
    [self.navigationController pushViewController:vc animated:YES];
    
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
