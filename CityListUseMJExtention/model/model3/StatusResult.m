//
//  StatusResult.m
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/1.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "StatusResult.h"
#import <MJExtension/MJExtension.h>

@implementation StatusResult
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"statuses" : @"Status",
             @"ads" : @"AdModel"
             };
}
@end

@implementation AdModel


@end