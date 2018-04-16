//
//  SPMapAroundInfoViewController.m
//  SmartPurifieriOS
//
//  Created by Wind on 2016/11/17.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPMapAroundInfoViewController.h"
#import "SPAddressInfoModel.h"


//1.首先我们要给出两个位置 起点和终点 的经纬度
//2.给出起点和终点的详细信息
//3.包装 起点的节点 和终点的节点
//4.进行路线请求
//5.发送请求
//6.计算

@interface SPMapAroundInfoViewController ()<MKMapViewDelegate>{

    BOOL haveGetUserLocation;//是否获取到用户位置
    
    CLLocationManager *_locationManager;

}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(strong,nonatomic)MKMapItem *mapItem;
//编码工具
@property(strong,nonatomic)CLGeocoder *geocoder;

//用于发送请求给服务器
@property(strong,nonatomic)MKDirections *direct;

@end

@implementation SPMapAroundInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"路线规划";
    
    _locationManager=[[CLLocationManager alloc]init];
    
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        
        [_locationManager requestWhenInUseAuthorization];
    }
    
    haveGetUserLocation = NO;
   

    self.mapView.mapType = MKMapTypeStandard;
    
    self.mapView.showsUserLocation = YES;
    
    self.mapView.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始导航" style:0 target:self action:@selector(navigationForLine)];
}

#pragma mark - 导航
-(void)navigationForLine{

    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"导航到设备" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //自带地图
    [alertController addAction:[UIAlertAction actionWithTitle:@"自带地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_endPoint addressDictionary:nil]];
        
        toLocation.name = _addressname;
        
        [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                                   MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];

    }]];

    //判断是否安装了百度地图，如果安装了百度地图，则使用百度地图导航
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"百度地图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"alertController -- 百度地图");
            NSString *urlsting =[[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",_endPoint.latitude,_endPoint.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlsting]];
            
        }]];
    }
    
    //添加取消选项
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alertController dismissViewControllerAnimated:YES completion:nil];
        
    }]];
    
    //显示alertController
    [self presentViewController:alertController animated:YES completion:nil];
 
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"userLocation:longitude:%f---latitude:%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    
    if (!haveGetUserLocation) {
        if (self.mapView.userLocationVisible) {
           
            haveGetUserLocation = YES;
            
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_endPoint addressDictionary:nil]];
            //添加一个小别针到地图上
            SPAddressInfoModel *thanno = [[SPAddressInfoModel alloc]init];
            
            thanno.coordinate = toLocation.placemark.location.coordinate;
            
            thanno.name = _addressname;
            
            [self.mapView addAnnotation:thanno];

        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 返回指定的遮盖模型所对应的遮盖视图, renderer-渲染
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    // 判断类型
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        // 针对线段, 系统有提供好的遮盖视图
        MKPolylineRenderer *render = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        
        // 配置，遮盖线的颜色
        render.lineWidth = 6;
       
        render.strokeColor = SPNavBarColor;
        
        return render;
    }
    // 返回nil, 是没有默认效果
    return nil;
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
