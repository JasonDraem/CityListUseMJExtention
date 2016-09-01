//
//  CustomTableViewCell.h
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/1.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@property (weak, nonatomic) IBOutlet UILabel *iconLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;


- (void)updateWithModel:(User *)model;

@end
