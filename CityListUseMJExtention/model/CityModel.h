//
//  CityModel.h
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/8/31.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MJExtension/MJExtension.h>

@interface CityModel : NSObject
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *page_total;
@property (nonatomic, copy) NSString *pagenumber;
@property (nonatomic, strong) NSMutableArray *result;
@property (nonatomic, copy) NSString *result_count;

@end

@interface CityListModel : NSObject
@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *province_name;
@end
