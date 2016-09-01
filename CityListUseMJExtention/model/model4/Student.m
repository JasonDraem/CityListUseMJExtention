//
//  Student.m
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/1.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "Student.h"
#import <MJExtension/MJExtension.h>

@implementation Student
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    NSDictionary *dict = @{
                           @"ID" : @"id",
                           @"desc" : @"desciption",
                           @"stu_OldName" : @"name.oldName",
                           @"stu_NewName" : @"name.newName",
                           @"testData" : @"name.info[0]",
                           @"nameChangedTime" : @"name.info[1].nameChangedTime",
                           @"bag" : @"other.bag"
                           };
    return dict;
}
@end

@implementation Bag

@end