//
//  SPChooseCityViewController.m
//  SmartPurifieriOS
//
//  Created by windpc on 16/11/22.
//  Copyright © 2016年 SmartPurifieriOS. All rights reserved.
//

#import "SPChooseCityViewController.h"
#import "SPCityGroupCell.h"
#import "SPChooseCityHeaderView.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "SPUserModel.h"
#import "CitiesDataTool.h"

#define     MAX_COMMON_CITY_NUMBER      8
#define     COMMON_CITY_DATA_KEY        @"GYZCommonCityArray"


@interface SPLocationManger ()<CLLocationManagerDelegate>


@property(nonatomic,retain)CLLocationManager *spLocationManager;

@property (nonatomic, strong) NSMutableArray *localCityData;


@end

@implementation SPLocationManger

+(instancetype)defaultManager{

    static SPLocationManger * manager = nil ;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[SPLocationManger alloc] init];
        
    });

    return manager;
}



-(void)locationStart{

    if([CLLocationManager locationServicesEnabled]) {
        
        self.spLocationManager = [[CLLocationManager alloc] init] ;
        self.spLocationManager.delegate = self;
        //设置定位精度
        self.spLocationManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.spLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters;//每隔多少米定位一次（这里的设置为每隔百米)
        // if (IOS8) {
        //使用应用程序期间允许访问位置数据
        [self.spLocationManager requestWhenInUseAuthorization];
        //}
        // 开始定位
        [self.spLocationManager startUpdatingLocation];
    }else {
        //提示用户无法进行定位操作
        NSLog(@"%@",@"定位服务当前可能尚未打开，请设置打开！");
        
    }
}

#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations

{
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [self.spLocationManager stopUpdatingLocation];
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    
    //获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count >0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //获取城市
             NSString *currCity = [NSString stringWithFormat:@"%@-%@", placemark.locality,placemark.subLocality];
             
             if (!currCity) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 currCity = placemark.administrativeArea;
             }
             
             if (self.localCityData.count <= 0) {
                
                 SPCityModel *city = [[SPCityModel alloc] init];
                 
                 city.cityName = currCity;
                 
                 city.shortName = currCity;
                
                 [self.localCityData addObject:city];
                 
                 if (_locationEndBlock) {
                     
                     _locationEndBlock(_localCityData);
                 }
                 
             }
             
         } else if (error ==nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }else if (error !=nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
         
     }];
    
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if (error.code ==kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
    
}

- (NSMutableArray *) localCityData
{
    if (_localCityData == nil) {
        _localCityData = [[NSMutableArray alloc] init];

    }
    return _localCityData;
}



@end



@interface SPChooseCityViewController ()<UISearchBarDelegate,CLLocationManagerDelegate,SPCityGroupCellDelegate>
{
    UIAlertView *alert;
    
    SPLocationManger * manage;
    
    SPUserModel *cityModel;
}

/**
 *  记录所有城市信息，用于搜索
 */
@property (nonatomic, strong) NSMutableArray *recordCityData;
/**
 *  当前城市区县
 */
@property (nonatomic, strong) NSArray *CityClassData;

/**
 *  定位城市
 */
@property (nonatomic, strong) NSMutableArray *localCityData;
/**
 *  热门城市
 */
@property (nonatomic, strong) NSMutableArray *hotCityData;
/**
 *  最近访问城市
 */
@property (nonatomic, strong) NSMutableArray *commonCityData;

@property (nonatomic, strong) NSMutableArray *arraySection;
/**
 *  是否是search状态
 */
@property(nonatomic, assign) BOOL isSearch;
/**
 *  搜索框
 */
@property (nonatomic, strong) UISearchBar *searchBar;

/**
 *  搜索城市列表
 */
@property (nonatomic, strong) NSMutableArray *searchCities;

//@property(nonatomic,retain)CLLocationManager *locationManager;



@end

NSString *const cityHeaderView = @"CityHeaderView";
NSString *const cityGroupCell = @"CityGroupCell";
NSString *const cityCell = @"CityCell";

@implementation SPChooseCityViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"城市选择"];
    
    UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelButtonDown:)];
   
    [self.navigationItem setLeftBarButtonItem:cancelBarButton];
    
    self.isSearch = NO;
    [self locationStart];
    
    cityModel = [SPUserModel getUserLoginModel];
    
    
    NSLog(@"cityclass count is %ld",self.CityClassData.count);
    
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.0f)];
    
    backView.backgroundColor = [UIColor clearColor];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44.0f)];
    self.searchBar.barStyle     = UIBarStyleDefault;
    self.searchBar.translucent  = YES;
    self.searchBar.delegate     = self;
    self.searchBar.placeholder  = @"城市名称或首字母";
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    [self.searchBar setBarTintColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
    [self.searchBar.layer setBorderWidth:0.5f];
    [self.searchBar.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];

    [backView addSubview:self.searchBar];
    
    [self.tableView setTableHeaderView:backView];
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[UIColor colorWithHexString:@"1BB6EF"]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cityCell];
    [self.tableView registerClass:[SPCityGroupCell class] forCellReuseIdentifier:cityGroupCell];
    [self.tableView registerClass:[SPChooseCityHeaderView class] forHeaderFooterViewReuseIdentifier:cityHeaderView];
    // Do any additional setup after loading the view.
    
    alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择城市" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
}

- (void)layoutSubviews {
    UITextField *searchField;
    NSUInteger numViews = [self.searchBar.subviews count];
    for(int i = 0; i < numViews; i++) {
        if([[self.searchBar.subviews objectAtIndex:i] isKindOfClass:[UITextField class]]) {
            searchField = [self.searchBar.subviews objectAtIndex:i];
        }
    }
    
    if(!(searchField == nil)) {
        searchField.textColor = [UIColor whiteColor];
        [searchField setBackground: [UIImage imageNamed:@"SearchBarBackground.png"] ];
        [searchField setBorderStyle:UITextBorderStyleNone];
    }
    
}





#pragma mark - Event Response
- (void) cancelButtonDown:(UIBarButtonItem *)sender
{
    SPUserModel *model = [SPUserModel getUserLoginModel];
    if (model.city.length == 0) {
        [alert show];
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(cityPickerControllerDidCancel:)]) {
            [_delegate cityPickerControllerDidCancel:self];
        }
    }
}

-(NSMutableArray *) cityDatas{
    if (_cityDatas == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"]];
        _cityDatas = [[NSMutableArray alloc] init];
        for (NSDictionary *groupDic in array) {
            SPCityGroup *group = [[SPCityGroup alloc] init];
            group.groupName = [groupDic objectForKey:@"initial"];
            for (NSDictionary *dic in [groupDic objectForKey:@"citys"]) {
                SPCityModel *city = [[SPCityModel alloc] init];
                city.cityID = [dic objectForKey:@"city_key"];
                city.cityName = [dic objectForKey:@"city_name"];
                city.shortName = [dic objectForKey:@"short_name"];
                city.pinyin = [dic objectForKey:@"pinyin"];
                city.initials = [dic objectForKey:@"initials"];
                [group.arrayCitys addObject:city];
                
                [self.recordCityData addObject:city];
            }
            [self.arraySection addObject:group.groupName];
            [_cityDatas addObject:group];
            
        }
    }
    return _cityDatas;
}
- (NSMutableArray *) recordCityData
{
    if (_recordCityData == nil) {
        _recordCityData = [[NSMutableArray alloc] init];
    }
    return _recordCityData;
}

- (NSMutableArray *) hotCityData
{
    //100010000 200010000 300110000 300210000 600010000
    if (_hotCityData == nil) {
        _hotCityData = [[NSMutableArray alloc] init];
        for (NSString *str in self.hotCitys) {
            SPCityModel *city = nil;
            for (SPCityModel *item in self.recordCityData) {
                if ([item.cityID isEqualToString:str]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", str);
            }
            else {
                [_hotCityData addObject:city];
            }
        }
    }
    return _hotCityData;
}

- (NSMutableArray *) commonCityData
{
    if (_commonCityData == nil) {
        _commonCityData = [[NSMutableArray alloc] init];
        for (NSString *str in self.commonCitys) {
            SPCityModel *city = nil;
            for (SPCityModel *item in self.recordCityData) {
                if ([item.cityName isEqualToString:str]) {
                    city = item;
                    break;
                }
            }
            if (city == nil) {
                NSLog(@"Not Found City: %@", str);
            }
            else {
                [_commonCityData addObject:city];
            }
        }
    }
    return _commonCityData;
}

- (NSMutableArray *) arraySection
{
    if (_arraySection == nil) {
        _arraySection = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, @"定位", @"最近", @"最热", nil];
    }
    
    return _arraySection;
}

- (NSMutableArray *) commonCitys
{
    if (_commonCitys == nil) {
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:COMMON_CITY_DATA_KEY];
        _commonCitys = (array == nil ? [[NSMutableArray alloc] init] : [[NSMutableArray alloc] initWithArray:array copyItems:YES]);
    }
    return _commonCitys;
}

#pragma mark - Getter
- (NSMutableArray *) searchCities
{
    if (_searchCities == nil) {
        _searchCities = [[NSMutableArray alloc] init];
    }
    return _searchCities;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //搜索出来只显示一块
    if (self.isSearch) {
        return 1;
    }
    return self.cityDatas.count + 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isSearch) {
        return self.searchCities.count;
    }
    if (section < 4) {
        return 1;
    }
    SPCityGroup *group = [self.cityDatas objectAtIndex:section - 4];
    return group.arrayCitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isSearch) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCell];
        SPCityModel *city =  [self.searchCities objectAtIndex:indexPath.row];
        [cell.textLabel setText:city.cityName];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
        return cell;
    }
    
    if (indexPath.section < 4) {
        SPCityGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cityGroupCell];
        
        if (indexPath.section == 0) {
            //cell.titleLabel.text = [NSString stringWithFormat:@"当前城市:%@",cityModel.city];
            cell.titleLabel.textColor = [UIColor grayColor];
            
            cell.noDataLabel.text = @"";
            
//            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-55, 16, 11, 9)];
//            imgView.image = [UIImage imageNamed:@"Next-down"];
//            [cell.contentView addSubview:imgView];
//            
//            UILabel *quyuLabel = [[UILabel alloc]initWithFrame:CGRectMake(imgView.origin.x-100, 0, 90, 44)];
//            quyuLabel.text = @"选择县区";
//            quyuLabel.textAlignment = NSTextAlignmentRight;
//            quyuLabel.textColor = [UIColor lightGrayColor];
//            quyuLabel.font = [UIFont systemFontOfSize:14];
//            [cell.contentView addSubview:quyuLabel];
            
            
            [cell setCityArray:nil];
            
        }
        else if (indexPath.section == 1) {
            cell.titleLabel.text = @"定位城市";
            cell.noDataLabel.text = @"无法定位当前城市，请稍后再试";
            [cell setCityArray:self.localCityData];
        }
        else if (indexPath.section == 2) {
            cell.titleLabel.text = @"最近访问城市";
            [cell setCityArray:self.commonCityData];
        }
        else {
            cell.titleLabel.text = @"热门城市";
            [cell setCityArray:self.hotCityData];
        }
        [cell setDelegate:self];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCell];
    SPCityGroup *group = [self.cityDatas objectAtIndex:indexPath.section - 4];
    SPCityModel *city =  [group.arrayCitys objectAtIndex:indexPath.row];
    [cell.textLabel setText:city.cityName];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
    
    return cell;
}

#pragma mark - SPCityGroupCellDelegate
- (void) cityGroupCellDidSelectCity:(SPCityModel *)city
{
    [self didSelctedCity:city];
}


#pragma mark UITableViewDelegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < 4 || self.isSearch) {
        return nil;
    }
    SPChooseCityHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:cityHeaderView];
    NSString *title = [_arraySection objectAtIndex:section + 0];
    headerView.titleLabel.text = title;
    return headerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearch) {
        return 44.0f;
    }
    if (indexPath.section == 1) {
        return [SPCityGroupCell getCellHeightOfCityArray:self.localCityData];
    }
    else if (indexPath.section == 2) {
        return [SPCityGroupCell getCellHeightOfCityArray:self.commonCityData];
    }
    else if (indexPath.section == 3){
        return [SPCityGroupCell getCellHeightOfCityArray:self.hotCityData];
    }else if (indexPath.section == 0){
        return 0;
    }
    
    return 44.0f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section < 4 || self.isSearch) {
        return 0.0f;
    }
    return 23.5f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SPCityModel *city = nil;
    if (self.isSearch) {
        city =  [self.searchCities objectAtIndex:indexPath.row];
    }else{
        if (indexPath.section < 4) {
            if (indexPath.section == 1 && self.localCityData.count <= 0) {
                [self locationStart];
            }
            return;
        }
        SPCityGroup *group = [self.cityDatas objectAtIndex:indexPath.section - 4];
        city =  [group.arrayCitys objectAtIndex:indexPath.row];
    }
    
    [self didSelctedCity:city];
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (self.isSearch) {
        return nil;
    }
    return self.arraySection;
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (index == 0) {
        return -1;
    }
    return index - 1;
}

#pragma mark searchBarDelegete

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [self.searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn=[searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"1BB6EF"] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.searchCities removeAllObjects];
    
    if (searchText.length == 0) {
        self.isSearch = NO;
    }else{
        self.isSearch = YES;
        for (SPCityModel *city in self.recordCityData){
            NSRange chinese = [city.cityName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange  letters = [city.pinyin rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange  initials = [city.initials rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (chinese.location != NSNotFound || letters.location != NSNotFound || initials.location != NSNotFound) {
                [self.searchCities addObject:city];
            }
            //            if ([city.cityName containsString:searchText] || [city.pinyin containsString:searchText] || [city.initials containsString:searchText]) {
            //                [self.searchCities addObject:city];
            //            }
        }
    }
    [self.tableView reloadData];
}
//添加搜索事件：
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text=@"";
    [searchBar resignFirstResponder];
    self.isSearch = NO;
    [self.tableView reloadData];
}


#pragma mark - Private Methods
- (void) didSelctedCity:(SPCityModel *)city
{
   
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerController:didSelectCity:)]) {
        [_delegate cityPickerController:self didSelectCity:city];
    }

    if (self.commonCitys.count >= MAX_COMMON_CITY_NUMBER) {
        [self.commonCitys removeLastObject];
    }
    for (NSString *str in self.commonCitys) {
        if ([city.cityName isEqualToString:str]) {
            [self.commonCitys removeObject:str];
            break;
        }
    }
    [self.commonCitys insertObject:city.cityName atIndex:0];
    [[NSUserDefaults standardUserDefaults] setValue:self.commonCitys forKey:COMMON_CITY_DATA_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//开始定位
-(void)locationStart{
    //判断定位操作是否被允许
    
     manage=  [[SPLocationManger alloc] init];
    
    __weak typeof(self) weakslef = self;
    
    [manage setLocationEndBlock:^(NSMutableArray *LocationArr) {
        
        _localCityData = LocationArr;
        
        [weakslef.tableView reloadData];
        
    }];
     [manage locationStart];
    
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
