//
//  AboutViewController.m
//  SmartPurifieriOS
//
//  Created by yuan on 2016/11/28.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "AboutViewController.h"
#import "orderTWoTableViewCell.h"
#import "AboutVideoTableViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"
#import "LXFButton.h"

@interface AboutViewController ()<UITableViewDelegate,UITableViewDataSource,MPPlayableContentDelegate,UIScrollViewDelegate,UINavigationControllerDelegate>
{
    UITableView *tableV;
    
    UIImageView *navBarHairlineImageView;
    
    LXFButton *backbtn;
}
@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property(nonatomic,retain) MPMoviePlayerViewController *moviePlayer;

@end

@implementation AboutViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //控制器即将进入的时候调用
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    self.view .backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    
    self.navigationController.delegate = self;
    
    tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT+20) style:UITableViewStylePlain];
    tableV.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorStyle = YES;
    tableV.showsVerticalScrollIndicator =
    NO;
    //tableV.contentSize = CGSizeMake(SCREEN_WIDTH, tableV.frame.size.height+10);
    tableV.alwaysBounceVertical = YES;
    [self.view addSubview:tableV];
    
    UIView *clearView = [[UIView alloc]initWithFrame:CGRectMake(0, 1, tableV.frame.size.width, 50)];
    clearView.backgroundColor= [UIColor whiteColor];
    [tableV setTableFooterView:clearView];
   
}
-(void)backClick
{
    //返回点击事件
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addGesture
{
    // 创建手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
}


-(void)playVideoClick{
    

    //设置通知
    NSNotificationCenter *NSDC = [NSNotificationCenter defaultCenter];
    
    [NSDC addObserver:self    selector:@selector(moviePlayerWillEnterFullscreenNotification:)
     
                 name:MPMoviePlayerDidEnterFullscreenNotification
     
               object:_moviePlayer];
    
    [NSDC addObserver:self     selector:@selector(moviePlayerWillExitFullscreenNotification:)
     
                 name:MPMoviePlayerWillExitFullscreenNotification
               object:_moviePlayer];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(movieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:_moviePlayer];
    
    AppDelegate  *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    delegate.allowRotation = YES;
    
    NSString *videoUrl = @"http://www.szjxzn.tech:8080/pic/jingxi1010.mp4";
    

    _moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:videoUrl]];
                                            
    //http://113.106.93.195:21080/pic/jingxi1010.mp4
   //万能解码
    [self presentMoviePlayerViewControllerAnimated:_moviePlayer];
    
    [_moviePlayer moviePlayer];
    

}
#pragma  mark UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 1||indexPath.row == 2) {
        orderTWoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderTWoTableViewCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"orderTWoTableViewCell" owner:self options:nil]lastObject];
        }
        cell.deitaiLabel.textColor = SPNavBarColor;
        cell.deitaiLabel.textAlignment = NSTextAlignmentRight;
        cell.deitaiLabel.font = [UIFont systemFontOfSize:14];
        
        if (indexPath.row == 2) {
            cell.titlelabel.text = @"微信公众号";
            
            cell.deitaiLabel.text = @"净喜智能";
   
        }else{
            cell.titlelabel.text = @"官网";
            
            cell.deitaiLabel.text = @"http://www.szjxzn.cn/index.php";
        
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.row == 3){
        AboutVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AboutVideoTableViewCell"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle]loadNibNamed:@"AboutVideoTableViewCell" owner:self options:nil]lastObject];
        }
        
        [cell.playBtn addTarget:self action:@selector(playVideoClick) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
            
        }
        
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.314+44);
        view.backgroundColor = [UIColor colorWithHexString:@"efeff4"];
        [cell.contentView addSubview:view];

        backbtn =  [LXFButton buttonWithType:UIButtonTypeCustom];
        backbtn.frame = CGRectMake(8, 25, 30, 30);
        [backbtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [backbtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:backbtn];
        
        CGFloat imgWidth = SCREEN_WIDTH*0.24;
        UIImageView  *headImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-imgWidth/2, 0.09*SCREEN_HEIGHT+44, imgWidth, imgWidth)];
        headImg.image = [UIImage imageNamed:@"关于-logo"];
        headImg.backgroundColor = [UIColor whiteColor];
        headImg.layer.masksToBounds = YES;
        headImg.layer.cornerRadius = 10;
        [view addSubview:headImg];
        
        
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, headImg.frame.size.height+headImg.frame.origin.y+15, SCREEN_WIDTH, 16);
        NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        label.text = [NSString stringWithFormat:@"版本(%@)",version];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithHexString:@"404040"];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell高度代理
    if (indexPath.row == 3) {
        return 295;
    }else if (indexPath.row == 0){
        return 255;
    }else{
        return 44;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell点击事件
    if (indexPath.row == 1) {
        NSURL *url = [ [ NSURL alloc ] initWithString: @"http://www.szjxzn.cn/index.php" ];
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

#pragma 视频播放器
- (void)moviePlayerWillEnterFullscreenNotification:(NSNotification*)notify

{
    
    AppDelegate  *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    delegate.allowRotation = YES;
    
    
    NSLog(@"moviePlayerWillEnterFullscreenNotification");
}
- (void)moviePlayerWillExitFullscreenNotification:(NSNotification*)notify

{
    
    AppDelegate  *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    delegate.allowRotation = NO;

     //[_moviePlayer moviePlayer];
    
    NSLog(@"moviePlayerWillExitFullscreenNotification");
}
-(void)movieFinishedCallback:(NSNotification*)notify
{
    AppDelegate  *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    delegate.allowRotation = NO;
    
    //[_moviePlayer storyboard];
}
// 视图控制器横屏触发
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // iPhone 4个旋转反向
    if (toInterfaceOrientation == UIDeviceOrientationLandscapeRight || toInterfaceOrientation == UIDeviceOrientationLandscapeLeft) {
    }
}

// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

@end
