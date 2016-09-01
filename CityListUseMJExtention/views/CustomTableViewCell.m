//
//  CustomTableViewCell.m
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/1.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "User.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateWithModel:(User *)model{
    self.nameLabel.text = [NSString stringWithFormat:@"name:%@", model.name];
    self.ageLabel.text = [NSString stringWithFormat:@"age:%u", model.age];
    self.iconLabel.text = [NSString stringWithFormat:@"icon:%@", model.icon];
    self.idLabel.text = [NSString stringWithFormat:@"height:%@", model.height];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
