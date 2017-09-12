//
//  BMNewAddressSourceManager.m
//  BMiOSUIComponents
//
//  Created by BobWong on 2017/6/1.
//  Copyright © 2017年 月亮小屋（中国）有限公司. All rights reserved.
//

#import "BMNewAddressSourceManager.h"
#import <FMDB.h>
#import "BMNewRegionModel.h"

NSString *const BMAddressTypeProvince = @"province";
NSString *const BMAddressTypeCity = @"city";
NSString *const BMAddressTypeCounty = @"county";

@interface BMNewAddressSourceManager ()

@property (strong, nonatomic) FMDatabase *database;

@end

@implementation BMNewAddressSourceManager

- (NSArray<BMNewRegionModel *> *)addressSourceArrayWithParentCode:(NSInteger)parentCode addressType:(NSString *)addressType {
    NSMutableArray *arrayM = [NSMutableArray new];
    if (![self.database open]) {
        NSLog(@"数据库打开失败");
        return arrayM;
    }
    
    NSString *sqlString;
    if ([addressType isEqualToString:BMAddressTypeProvince]) {
        sqlString = [NSString stringWithFormat:@"select * from province"];
    }
    else if ([addressType isEqualToString:BMAddressTypeCity]) {
        sqlString = [NSString stringWithFormat:@"select * from city where pcode = %ld", (long)parentCode];
    }
    else if ([addressType isEqualToString:BMAddressTypeCounty]) {
        sqlString = [NSString stringWithFormat:@"select * from county where pcode = %ld", (long)parentCode];
    }
    else {
        return arrayM;
    }
    
    FMResultSet *set = [self.database executeQuery:sqlString];
    while ([set next]) {
        BMNewRegionModel *model = [BMNewRegionModel new];
        model.code = [set intForColumn:@"dcode"];
        model.name = [set stringForColumn:@"dname"];
        model.type = [set stringForColumn:@"type"];
        model.parentCode = [set intForColumn:@"pcode"];
        [arrayM addObject:model];
    }
    [self.database close];
    
    return arrayM;
}

#pragma mark - Setter and Getter

- (FMDatabase *)database {
    if (!_database) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"db"];
        _database = [FMDatabase databaseWithPath:path];
    }
    return _database;
}

@end
