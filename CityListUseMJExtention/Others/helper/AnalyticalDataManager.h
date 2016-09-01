//
//  LabelTool.h
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/1.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id, NSString *fileName);
typedef void(^FailBlock)(NSError *error);

@interface AnalyticalDataManager : NSObject
+ (instancetype)shareInstance;
+ (UILabel *)showTextOnLabel;
/**
 *  简单的字典模型
 *
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)test1AnalyticalDataSuccess:(SuccessBlock)success
                              fail:(FailBlock)fail;
/**
 *  模型里有字典模型
 *
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)test2AnalyticalDataSuccess:(SuccessBlock)success
                              fail:(FailBlock)fail;
/**
 *  模型中有个数组属性，数组里面又要装着字典模型
 *
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)test3AnalyticalDataSuccess:(SuccessBlock)success
                              fail:(FailBlock)fail;
/**
 *  模型中的属性名和字典中的key不相同(或者需要多级映射)
 *
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)test4AnalyticalDataSuccess:(SuccessBlock)success
                              fail:(FailBlock)fail;
/**
 *  将一个数据数组转成模型数组
 *
 *  @param success <#success description#>
 *  @param fail    <#fail description#>
 */
- (void)test5AnalyticalDataSuccess:(SuccessBlock)success
                              fail:(FailBlock)fail;
@end
