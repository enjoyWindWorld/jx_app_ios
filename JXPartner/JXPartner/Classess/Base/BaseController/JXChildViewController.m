//
//  JXChildViewController.m
//  JXPartner
//
//  Created by Wind on 2018/4/27.
//  Copyright © 2018年 windpc. All rights reserved.
//

#import "JXChildViewController.h"
#import "STNavigationController.h"

@interface JXChildViewController ()

@end

@implementation JXChildViewController

- (void)dealloc
{
    if (self)
    {
        //取消延迟执行
        [[JXChildViewController class] cancelPreviousPerformRequestsWithTarget:self];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    STNavBarView *navbar = [[STNavBarView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [STNavBarView barSize].width, [STNavBarView barSize].height)];
    _navbar = navbar;
    _navbar.viewCtrlParent = self;
    [self.tableView addSubview:_navbar];
    //设置导航栏背景颜色
    [self setNabbarBackgroundColor:[UIColor clearColor]];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_navbar && !_navbar.hidden)
    {
        [self.view bringSubviewToFront:_navbar];
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark -
- (void)bringNavBarToTopmost
{
    if (_navbar)
    {
        [self.view bringSubviewToFront:_navbar];
    }
}


// 设置STNavBarView 颜色
- (void)setNabbarBackgroundColor:(UIColor *)color
{
    if (_navbar) {
        [_navbar setBackgroundColor:color];
    }
}

- (void)hideNavBar:(BOOL)bIsHide
{
    _navbar.hidden = bIsHide;
}

- (void)setNavBarTitle:(NSString *)strTitle
{
    if (_navbar)
    {
        [_navbar setTitle:strTitle];
    }
    else{
        NSLog(@"APP_ASSERT_STOP");
        NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);
    }
}


- (void)setNavBarLeftBtn:(UIButton *)btn
{
    if (_navbar)
    {
        [_navbar setLeftBtn:btn];
    }
    else{
        NSLog(@"APP_ASSERT_STOP");
        NSAssert1(NO, @" \n\n\n===== APP Assert. =====\n%s\n\n\n", __PRETTY_FUNCTION__);
    }
}

- (void)setNavBarRightBtn:(UIButton *)btn
{
    if (_navbar)
    {
        [_navbar setRightBtn:btn];
    }
}


// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)canDragBack
{
    if (self.navigationController)
    {
        [((STNavigationController *)(self.navigationController)) navigationCanDragBack:canDragBack];
    }
}


// 重设scroll view的内容区域和滚动条区域
- (void)resetScrollView:(UIScrollView *)scrollView tabBar:(BOOL)hasTabBar
{
    if (scrollView)
    {
        UIEdgeInsets inset = scrollView.contentInset;
        UIEdgeInsets insetIndicator = scrollView.scrollIndicatorInsets;
        
        CGPoint ptContentOffset = scrollView.contentOffset;
        CGFloat fTopInset = 0.0f;
        CGFloat fTopIndicatorInset = 0.0f;
        
        CGFloat fBottomInset = hasTabBar ? Bottom_H : 0.0f;
        
        fTopInset += NaviBar_H - StatusBar_H;
        fTopIndicatorInset += NaviBar_H - StatusBar_H;
        
        inset.top += fTopInset;
        inset.bottom += fBottomInset;
        [scrollView setContentInset:inset];
        
        insetIndicator.top += fTopIndicatorInset;
        insetIndicator.bottom += fBottomInset;
        [scrollView setScrollIndicatorInsets:insetIndicator];
        
        ptContentOffset.y -= fTopInset;
        [scrollView setContentOffset:ptContentOffset];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
