//
//  LabelTool.m
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/1.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "AnalyticalDataManager.h"
#import "UIColor+XXYExtension.h"

#import <MJExtension/MJExtension.h>
#import "User.h"
#import "Status.h"
#import "StatusResult.h"
#import "Student.h"
#import "ArrayModel.h"
static NSError *error = nil;
@implementation AnalyticalDataManager
static  AnalyticalDataManager *_shareInstance = nil;
+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[AnalyticalDataManager alloc] init];
    });
    return _shareInstance;
}

+ (UILabel *)showTextOnLabel{
    UILabel *label = [[UILabel alloc] initWithFrame:XXYScreenBounds];
    label.backgroundColor = [UIColor colorWithHexString:@"#ddeeff"];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByTruncatingHead;
    return label;
}
/**
 *  定义一个json字符串
 */
- (void)setJSONStr{
    // 定义一个JSON字符串
    NSString *jsonStr = @"{\"name\":\"Jack\", \"icon\":\"lufy.png\", \"age\":20}";
    User *user = [User mj_objectWithKeyValues:jsonStr];
    NSLog(@"MJ---%@----%@---%u",user.name,user.icon,user.age);
}
/**
 *  简单的字典模型
 */
- (void)test1AnalyticalDataSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    
    NSDictionary *dict = [self analyticalDataWithPathForResource:@"data1"];
    User *user = [User mj_objectWithKeyValues:dict];
    if (success) {
        success(user, @"data1");
    }else if  (fail) {
        fail(error);
    }
}

/**
 *  模型里有字典模型
 */
- (void)test2AnalyticalDataSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    NSDictionary *dict = [self analyticalDataWithPathForResource:@"data2"];
    Status *status = [Status mj_objectWithKeyValues:dict];

    if (success) {
        success(status, @"data2");
    }else if(fail) {
        fail(error);
    }
}
/**
 *  模型中有个数组属性，数组里面又要装着字典模型
 */
- (void)test3AnalyticalDataSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    NSDictionary *dict = [self analyticalDataWithPathForResource:@"data3"];
    StatusResult *result = [StatusResult mj_objectWithKeyValues:dict];
    if (success) {
        success(result, @"data3");
    }
    else if  (fail) {
        fail(error);
    }
}
/**
 *  模型中的属性名和字典中的key不相同(或者需要多级映射)
 */
- (void)test4AnalyticalDataSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    NSDictionary *dict = [self analyticalDataWithPathForResource:@"data4"];
    Student *student = [Student mj_objectWithKeyValues:dict];
    if (success) {
        success(student, @"data4");
    }
    
    else if (fail){
        fail(error);
    }
}
/**
 *  将一个数据数组转成模型数组
 */
- (void)test5AnalyticalDataSuccess:(SuccessBlock)success fail:(FailBlock)fail{
    NSArray *arr = [self analyticalDataArrayWithPathForResource:@"data5"];
    NSArray *modelArray = [ArrayModel mj_objectArrayWithKeyValuesArray:arr];
    for (ArrayModel *model in modelArray) {
        if (success) {
            success(model, @"data5");
        }else if (fail) {
            fail(error);
        }

    }
}

/**
 *  从本定解析数据 (数据原型最外层为字典)
 *
 *  @param fileName 文件名
 *
 *  @return  NSDictionary
 */
- (NSDictionary *)analyticalDataWithPathForResource:(NSString *)fileName{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"error:%@", error);
        return nil;
    }
    return dict;
}
/**
 *  数据原型为数组
 *
 *  @param fileName <#fileName description#>
 *
 *  @return NSArray
 */
- (NSArray *)analyticalDataArrayWithPathForResource:(NSString *)fileName{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"txt"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSLog(@"error:%@", error);
        return nil;
    }
    return array;
}
/**
 *   导航标题 可以不单独方法
 *
 *  @param title <#title description#>
 */

@end
