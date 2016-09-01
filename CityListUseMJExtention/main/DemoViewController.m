//
//  DemoViewController.m
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/1.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "DemoViewController.h"
#import "CustomTableViewCell.h"

#import "User.h"
#import "Status.h"
#import "StatusResult.h"
#import "Student.h"
#import "ArrayModel.h"
#import "AnalyticalDataManager.h"

@interface DemoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UILabel *showTextLabel;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XXYColor(90, 9, 19);
    //表格进行数据展示
    //[self GetDataFromsever];
    //label 一一展示数据
    [self showTextOnLabel];
}
/**
 *  懒加载tableview
 *
 *  @return <#return value description#>
 */
- (UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        [_tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
        [self.view addSubview:_tableView];
        //
    }
    return _tableView;
}
/**
 *  懒加载datasource
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)GetDataFromsever{
    weakify(self)
    [[AnalyticalDataManager shareInstance] test1AnalyticalDataSuccess:^(User *user, NSString *flieName) {
        strongify(self)
        [strong_self navigationItemTitle:flieName];
        [strong_self.dataSource addObject:user];
        [strong_self.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    User *user = self.dataSource[indexPath.row];
    [cell updateWithModel:user];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
#pragma mark - label
- (void)showTextOnLabel{
    weakify(self)
    self.showTextLabel = [AnalyticalDataManager showTextOnLabel];
    [self.view addSubview:self.showTextLabel];
#if 0
    [[AnalyticalDataManager shareInstance] test1AnalyticalDataSuccess:^(User *user, NSString *fileName) {
        strongify(self)
        [strong_self navigationItemTitle:fileName];
        strong_self.showTextLabel.text = [NSString stringWithFormat:@"\n name:%@\n icon:%@\n age:%u\n height:%@\n money:%@\n gay:%d",user.name,user.icon,user.age,user.height,user.money,user.gay];
    } fail:^(NSError *error) {
        
    }];
#elif 1
    //
    [[AnalyticalDataManager shareInstance] test2AnalyticalDataSuccess:^(Status *status, NSString *fileName) {
        strongify(self)
        [strong_self navigationItemTitle:fileName];
        strong_self.showTextLabel.text = [NSString stringWithFormat:@"user:\n%@\n%@\n%@\n \n retweetedStatus:\n%@\n%@\n%@\n", status.text, status.user.name, status.user.icon, status.retweetedStatus.text, status.retweetedStatus.user.name, status.retweetedStatus.user.icon];
    } fail:^(NSError *error) {
        
    }];
#elif 0
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
#elif 0
    //
    [[AnalyticalDataManager shareInstance] test4AnalyticalDataSuccess:^(Student *student, NSString *fileName) {
        strongify(self)
        [strong_self navigationItemTitle:fileName];
        strong_self.showTextLabel.text = [NSString stringWithFormat:@"\nID: %@\ndesciption: %@\nnewName: %@\noldName: %@\nnameChangedTime: %@\ntestData: %@", student.ID, student.desc, student.stu_NewName, student.stu_OldName, student.nameChangedTime, student.testData];
    } fail:^(NSError *error) {
        
    }];
#elif 0
    //
    [[AnalyticalDataManager shareInstance] test5AnalyticalDataSuccess:^(ArrayModel *model, NSString *fileName) {
        strongify(self)
        //其实有不止一个model 仅仅是添加  实际应用中根据数据进行处理
        [strong_self.dataSource addObject:model];
        [strong_self navigationItemTitle:fileName];
        strong_self.showTextLabel.text = [NSString stringWithFormat:@"\nname: %@\nicon: %@", model.name, model.icon];
    } fail:^(NSError *error) {
        
    }];
#endif
}
/**
 *   导航标题 可以不单独方法
 *
 *  @param title <#title description#>
 */
- (void)navigationItemTitle:(NSString *)title{
    self.navigationItem.title = title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
