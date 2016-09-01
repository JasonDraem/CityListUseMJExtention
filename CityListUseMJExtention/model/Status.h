//
//  Status.h
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/1.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;

@interface Status : NSObject
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) User *user;
@property (nonatomic, strong) Status *retweetedStatus;
@end
