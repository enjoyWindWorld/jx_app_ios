//
//  SPAdvertiseWebViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 2016/12/15.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPAdvertiseWebViewController.h"
#import <WebKit/WebKit.h>

@interface SPAdvertiseWebViewController ()

@property (nonatomic,strong) WKWebView * webView ;

@end

@implementation SPAdvertiseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    
//    _webView.UIDelegate
   
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.url]]];
    
    [self.view addSubview:_webView];
    
    
    // Do any additional setup after loading the view from its nib.
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
