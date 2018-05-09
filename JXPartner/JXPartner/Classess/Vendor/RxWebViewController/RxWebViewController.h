//
//  RxWebViewController.h
//  RxWebViewController
//
//  Created by roxasora on 15/10/23.
//  Copyright © 2015年 roxasora. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RxWebViewController : UIViewController

/**
 *  origin url
 */
@property (nonatomic)NSURL* url;

/**
 *  embed webView
 */
@property (nonatomic)UIWebView* webView;

/**
 *  tint color of progress view
 */
@property (nonatomic)UIColor* progressViewColor;

/**
 *  get instance with url
 *
 *  @param url url
 *
 *  @return instance
 */
-(instancetype)initWithUrl:(NSURL*)url;


-(void)reloadWebView;

@end

typedef void(^confirmSelectBlock)();

@interface SPAgreetmentWebViewController : RxWebViewController

@property (nonatomic,copy) confirmSelectBlock confirmSelect ;

// 设置导航栏在最上层
- (void)bringNavBarToTopmost;

// 是否隐藏导航栏
- (void)hideNavBar:(BOOL)bIsHide;

// 设置STNavBarView 颜色
- (void)setNabbarBackgroundColor:(UIColor *)color;

// 设置标题
- (void)setNavBarTitle:(NSString *)strTitle;

// 设置导航栏左按钮
- (void)setNavBarLeftBtn:(UIButton *)btn;

// 设置导航栏右按钮
- (void)setNavBarRightBtn:(UIButton *)btn;

// 是否可右滑返回
- (void)navigationCanDragBack:(BOOL)canDragBack;


// 重设scroll view的内容区域和滚动条区域
- (void)resetScrollView:(UIScrollView *)scrollView tabBar:(BOOL)hasTabBar;

@end



