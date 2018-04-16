//
//  JFAreaDataManager.m
//  JFFootball
//
//  Created by 张志峰 on 2016/11/18.
//  Copyright © 2016年 zhifenx. All rights reserved.
//

#import "JFAreaDataManager.h"

#import "FMDB.h"

@interface JFAreaDataManager ()

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation JFAreaDataManager

static JFAreaDataManager *manager = nil;

+ (JFAreaDataManager *)shareManager {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)areaSqliteDBData {
    // copy"area.sqlite"到Documents中
    NSFileManager *fileManager =[NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory =[paths objectAtIndex:0];
    NSString *txtPath =[documentsDirectory stringByAppendingPathComponent:@"location.db"];
    if([fileManager fileExistsAtPath:txtPath] == NO){
        NSString *resourcePath =[[NSBundle mainBundle] pathForResource:@"location.db" ofType:nil];
        [fileManager copyItemAtPath:resourcePath toPath:txtPath error:&error];
    }
    // 新建数据库并打开
    NSString *path  = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"location.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:path];
    self.db = db;
    BOOL success = [db open];
    if (success) {
        // 数据库创建成功!
        NSLog(@"数据库创建成功!");
//        NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS shop_area (area_number INTEGER ,area_name TEXT ,city_number INTEGER ,city_name TEXT ,province_number INTEGER ,province_name TEXT);";
        NSString *sqlStr = [NSString stringWithFormat:@"create table if not exists %@ (code text primary key,sheng text,di text,xian text,name text,level text);",@"shop_area"];
        BOOL successT = [self.db executeUpdate:sqlStr];
        if (successT) {
        // 创建表成功!
            
            NSLog(@"创建表成功!");
        }else{
            // 创建表失败!
            NSLog(@"创建表失败!");
            [self.db close];
        }
    }else{
        // 数据库创建失败!
        NSLog(@"数据库创建失败!");
        [self.db close];
    }
}

/// 所有市区的名称
- (void)cityData:(void (^)(NSMutableArray *dataArray))cityData {
  __block  NSMutableArray *resultArray = [[NSMutableArray alloc] init];
//    FMResultSet *result = [self.db executeQuery:@"SELECT name FROM locationTabble WHERE`level` = 2 and name <>'县' and name<>'市辖区' and name <>'省直辖县级行政区划' and name <>'自治区直辖县级行政区划';"];
    FMResultSet *result = [self.db executeQuery:@"SELECT name,sheng FROM locationTabble WHERE`level` = 2;"];
    while ([result next]) {
        __block NSString *cityName = [result stringForColumn:@"name"];
        NSString *shengName = [result stringForColumn:@"sheng"];
        
        if ([cityName isEqualToString:@"市辖区"]||[cityName isEqualToString:@"县"]||[cityName containsString:@"行政区划"]) {
           
//            NSLog(@"cityName  %@",cityName);
            
            cityName = [self replaceCity:cityName];
        
            [self currentCity:[NSString stringWithFormat:@"%@0000",shengName] currentCityName:^(NSString *name) {
            
                NSString * string = [NSString stringWithFormat:@"%@-%@",name,cityName];
                
                [resultArray addObject:string];

            }];
            
        }else{
        
            [resultArray addObject:cityName];
        }
    }
    cityData(resultArray);
}


- (void)currentCity:(NSString *)cityNumber communityCityForTDS:(void (^)(NSString *name))TDSCity{
    
    __block  NSString *tdscity = @"";
    
    NSString * citynum = @"";
    
    if (cityNumber.length>4) {
        
        citynum = [NSString stringWithFormat:@"%@00",[cityNumber substringToIndex:4]];
        
        cityNumber = citynum;
    }
  
    FMResultSet *result = [self.db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT name,sheng FROM locationTabble WHERE code = %@ ;",cityNumber]];
  
    while ([result next]) {
      
         NSString *name = [result stringForColumn:@"name"];
        
         NSString *shengName = [result stringForColumn:@"sheng"];
        
        if ([name isEqualToString:@"市辖区"]||[name isEqualToString:@"县"]||[name containsString:@"行政区划"]) {
            
            [self currentCity:[NSString stringWithFormat:@"%@0000",shengName] currentCityName:^(NSString *name) {
                
                tdscity = name;
      
            }];
            
        }else{
            
            tdscity = name ;
        }

    }

    TDSCity(tdscity);
}

/// 获取当前市的city_number
- (void)cityNumberWithCity:(NSString *)city cityNumber:(void (^)(NSString *cityNumber))cityNumber {
   
    
    NSString * cityNow = city ;
    
    NSRange range = [city rangeOfString:@"-"];
    
    if (range.location!=NSNotFound) {
        
        cityNow = [city substringToIndex:range.location];
    }
    
    FMResultSet *result = [self.db executeQuery:[NSString stringWithFormat:@"select DISTINCT code FROM locationTabble where name = '%@';",cityNow]];
    while ([result next]) {
        NSString *number = [result stringForColumn:@"code"];
        
        number = [self replaceCityNum:city number:number.mutableCopy];
        
        cityNumber(number);
    }
}



-(NSString*)replaceCityNum:(NSString*)city number:(NSMutableString*)number{

    if ([city containsString:@"辖区"]) {
        
        [number replaceCharactersInRange:NSMakeRange(2, 2) withString:@"01"];
    }else
    if ([city containsString:@"周边县"]) {
        
        [number replaceCharactersInRange:NSMakeRange(2, 2) withString:@"02"];
    }else
    if ([city containsString:@"省直辖县"]) {
        
        [number replaceCharactersInRange:NSMakeRange(2, 2) withString:@"90"];
    }else
    if ([city containsString:@"自治区直辖县"]) {
        
        [number replaceCharactersInRange:NSMakeRange(2, 2) withString:@"90"];
    }

    return number;
}
-(NSString*)replaceCity:(NSString*)city{
    

    if ([city isEqualToString:@"省直辖县级行政区划"]) {
       
        city = @"省直辖县";
    }else
    if ([city isEqualToString:@"自治区直辖县级行政区划"]) {
         city = @"自治区直辖县";
    }else
    if ([city isEqualToString:@"市辖区"]) {
            
            city = @"辖区";
    }else
    if ([city isEqualToString:@"县"]) {
        city = @"周边县";
    }
    return city;
}



/// 所有区县的名称
- (void)areaData:(NSString *)cityNumber areaData:(void (^)(NSMutableArray *areaData))areaData {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
//    NSString *sqlString = [NSString stringWithFormat:@"SELECT area_name FROM shop_area WHERE city_number ='%@';",cityNumber];
    
    NSString *sqlString = [NSString stringWithFormat:@"select  name from locationTabble where sheng = %@  and level= 3 and code like '%@%%%%';",[cityNumber substringToIndex:2],[cityNumber substringToIndex:4]];
    FMResultSet *result = [self.db executeQuery:sqlString];
    while ([result next]) {
        NSString *areaName = [result stringForColumn:@"name"];
        [resultArray addObject:areaName];
    }
    areaData(resultArray);
}

/// 根据city_number获取当前城市
- (void)currentCity:(NSString *)cityNumber currentCityName:(void (^)(NSString *name))currentCityName {
    FMResultSet *result = [self.db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT name FROM locationTabble WHERE code = %@ ;",cityNumber]];
    while ([result next]) {
        NSString *name = [result stringForColumn:@"name"];
        currentCityName(name);
    }
}

- (void)searchCityData:(NSString *)searchObject result:(void (^)(NSMutableArray *result))result {
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    

    
    
    FMResultSet *areaResult = [self.db executeQuery:[NSString stringWithFormat:@"SELECT DISTINCT code,name FROM locationTabble WHERE name LIKE '%%%@%%';",searchObject]];
    while ([areaResult next]) {
//        NSString *area = [areaResult stringForColumn:@"area_name"];
        NSString *city = [areaResult stringForColumn:@"name"];
        NSString *cityNumber = [areaResult stringForColumn:@"code"];
        NSDictionary *dataDic = @{@"super":@"",@"city":city,@"city_number":cityNumber};
        [resultArray addObject:dataDic];
    }
    

    
    //统一在数组中传字典是为了JFSearchView解析数据时方便
    if (resultArray.count == 0) {
        [resultArray addObject:@{@"city":@"抱歉",@"super":@"未找到相关位置，可尝试修改后重试!"}];
    }
    //返回结果
    result(resultArray);
}

@end
