//
//  Student.h
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/1.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Bag;

@interface Student : NSObject
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *desc;
@property (copy, nonatomic) NSString *stu_NewName;
@property (copy, nonatomic) NSString *stu_OldName;
@property (nonatomic, copy) NSString *testData;
@property (copy, nonatomic) NSString *nameChangedTime;
@property (strong, nonatomic) Bag *bag;
@end

@interface Bag : NSObject
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) double price;
@end

/**
 *  核心代码 mj_objectWithKeyValues:和mj_replacedKeyFromPropertyName
 *  多级映射，用点语法设置
 */
