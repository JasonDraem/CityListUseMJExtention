//
//  DemoViewController.m
//  CityListUseMJExtention
//
//  Created by Jason_Xu on 16/9/1.
//  Copyright © 2016年 Jason_Xu. All rights reserved.
//

#import "DemoViewController.h"
#import "CustomTableViewCell.h"
#import "JasonMJExtensionViewController.h"

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
    [self setupUI];
    //表格进行数据展示
    [self GetDataFromsever];
}
- (void)setupUI{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"详情" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemHandler)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemHandler{
    JasonMJExtensionViewController *jasonVC = [[JasonMJExtensionViewController alloc] init];
    [self.navigationController pushViewController:jasonVC animated:YES];
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
    return 60;
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
