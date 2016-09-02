//
//  JasonMJExtensionViewController.m
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/2.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "JasonMJExtensionViewController.h"
#import <Masonry/Masonry.h>

#import "User.h"
#import "Status.h"
#import "StatusResult.h"
#import "Student.h"
#import "ArrayModel.h"
#import "AnalyticalDataManager.h"

@interface JasonMJExtensionViewController ()
@property (strong, nonatomic) UILabel *showTextLabel;
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation JasonMJExtensionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XXYColor(90, 94, 22);
    [self setupUIWithButton];
}
/**
 *  创建数据button
 */
- (void)setupUIWithButton{
    
    NSArray *title = @[@"data1", @"data2", @"data3", @"data4", @"data5"];
    for (NSInteger i = 0; i < title.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        //一次只可以点击一次
        button.exclusiveTouch = YES;
        button.frame = CGRectMake(20+(i*55), 100+ (i * 35), 50, 30);
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setTitleColor:XXYColor(120, 110, 119) forState:UIControlStateNormal];
        button.tag = 100 + i;
        button.backgroundColor = XXYColor(94, 8, 22);
        [button addTarget:self action:@selector(showTextOnLabel:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

#pragma mark - buttonHandeler
- (void)showTextOnLabel:(UIButton *)button{
    weakify(self)
    switch (button.tag) {
        case 100:
        {
            [[AnalyticalDataManager shareInstance] test1AnalyticalDataSuccess:^(User *user, NSString *fileName) {
                strongify(self)
                [strong_self navigationItemTitle:fileName];
                [strong_self showLabelOnSuperViewWithText:[NSString stringWithFormat:@"\n name:%@\n icon:%@\n age:%u\n height:%@\n money:%@\n gay:%d",user.name,user.icon,user.age,user.height,user.money,user.gay]];
            } fail:^(NSError *error) {
                
            }];

        }
            break;
            
        case 101:
        {
            [[AnalyticalDataManager shareInstance] test2AnalyticalDataSuccess:^(Status *status, NSString *fileName) {
                strongify(self)
                [strong_self navigationItemTitle:fileName];
                [strong_self showLabelOnSuperViewWithText:[NSString stringWithFormat:@"user:\n%@\n%@\n%@\n \n retweetedStatus:\n%@\n%@\n%@\n", status.text, status.user.name, status.user.icon, status.retweetedStatus.text, status.retweetedStatus.user.name, status.retweetedStatus.user.icon]];
            } fail:^(NSError *error) {
                
            }];
        }
            break;
            
        case 102:
        {
            //
            [[AnalyticalDataManager shareInstance] test3AnalyticalDataSuccess:^(StatusResult *result, NSString *fileName) {
                strongify(self)
                [strong_self navigationItemTitle:fileName];
                for (Status *status in result.statuses) {
                    [strong_self.dataSource addObject:status];
                    strong_self.showTextLabel.text = [NSString stringWithFormat:@"\n%@\n%@\n%@", status.text, status.user.name, status.user.icon];
                }
                //ads
                for (AdModel *ad in result.ads) {
                    //NSLog(@"\n%@\n%@", ad.image, ad.url);
                    [strong_self.dataSource addObject:ad];
                }
                
                NSLog(@"%@", strong_self.dataSource);
            } fail:^(NSError *error) {
                
            }];

        }
            break;
            
        case 103:
        {
            //
            [[AnalyticalDataManager shareInstance] test4AnalyticalDataSuccess:^(Student *student, NSString *fileName) {
                strongify(self)
                [strong_self navigationItemTitle:fileName];
                [strong_self showLabelOnSuperViewWithText:[NSString stringWithFormat:@"\nID: %@\ndesciption: %@\nnewName: %@\noldName: %@\nnameChangedTime: %@\ntestData: %@", student.ID, student.desc, student.stu_NewName, student.stu_OldName, student.nameChangedTime, student.testData]];
            } fail:^(NSError *error) {
                
            }];
        }
            break;
            
        case 104:
        {
            //
            [[AnalyticalDataManager shareInstance] test5AnalyticalDataSuccess:^(ArrayModel *model, NSString *fileName) {
                strongify(self)
                //其实有不止一个model 仅仅是添加  实际应用中根据数据进行处理
                [strong_self.dataSource addObject:model];
                [strong_self navigationItemTitle:fileName];
                [strong_self showLabelOnSuperViewWithText:[NSString stringWithFormat:@"\nname: %@\nicon: %@", model.name, model.icon]];
            } fail:^(NSError *error) {
                
            }];
        }
            break;
            
        default:
            break;
    }
}
/**
 *   导航标题 可以不单独方法
 *
 *  @param title <#title description#>
 */
- (void)navigationItemTitle:(NSString *)title{
    self.navigationItem.title = title;
}
#pragma mark - 显示数据的label
/**
 *  show label
 *
 *  @param text <#text description#>
 */
- (void)showLabelOnSuperViewWithText:(NSString *)text{
    self.showTextLabel = [AnalyticalDataManager createLabel];
    self.showTextLabel.frame = CGRectMake(0, 0, XXYScreenW/2, XXYScreenH/2);
    self.showTextLabel.center = self.view.center;
    [UIView animateWithDuration:2.0 animations:^{
        self.showTextLabel.text = text;
        self.showTextLabel.userInteractionEnabled = NO;
        self.view.userInteractionEnabled = NO;
        [self.view addSubview:self.showTextLabel];
    }];
    //
    [self rightItem];
}
/**
 *  dismiss item
 */
- (void)rightItem{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss:)];
    self.navigationItem.rightBarButtonItem = item;
}
/**
 *  dismissHandler
 *
 *  @param item <#item description#>
 */
- (void)dismiss:(UIBarButtonItem *)item{
    weakify(self)
    self.navigationItem.rightBarButtonItem = item;
    [UIView animateWithDuration:2.0 animations:^{
        [self.showTextLabel removeFromSuperview];
        self.showTextLabel = nil;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
        weak_self.navigationItem.rightBarButtonItem = nil;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
