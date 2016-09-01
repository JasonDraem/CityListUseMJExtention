//
//  XXYRequestManager+CityListProxy.m
//  WeatherData
//
//  Created by Jason_Xu on 16/8/27.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "XXYRequestManager+CityListProxy.h"
#import "CityModel.h"
@implementation XXYRequestManager (CityListProxy)
+ (void)getCityListWithSessionId:(NSString *)sessionId backReasult:(BackReasultBlock)result{
    NSMutableString *urlStr = [[NSMutableString alloc] init];
    [urlStr appendFormat:@"%@", kBaseUrl];
    [urlStr appendFormat:@"%@", kAllCityPro];
    [urlStr appendFormat:@"%@", sessionId];

    [[XXYRequestManager shareInstance] get:urlStr params:nil success:^(id responseObjc, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObjc options:NSJSONReadingMutableContainers error:&error];
        
    } fail:^(NSError *error) {
        result(nil, error);
    }];
}
@end
