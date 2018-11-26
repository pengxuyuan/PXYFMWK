//
//  PXYMonitorDataListController.m
//  FPSDemo
//
//  Created by Pengxuyuan on 2017/7/11.
//  Copyright © 2017年 Pengxuyuan. All rights reserved.
//

#import "PXYMonitorDataListController.h"
#import "PXYMonitorDataCacheHelper.h"
#import "PXYMonitorDataDetailController.h"

@interface PXYMonitorDataListController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PXYMonitorDataListController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _dataArray = [[PXYMonitorDataCacheHelper shareInstance] fetchData];
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - Public methods


#pragma mark - Private methods
- (void)buildUI {
    _dataArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"卡顿信息";
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"hq_chart_back@2x.png"] style:UIBarButtonItemStylePlain target:self action:@selector(doBack)];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

- (void)doBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;

}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//}
//
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PXYMonitorDataDetailController *detailVC = [PXYMonitorDataDetailController new];
    [detailVC setMonitorDataWithCatonInformation:_dataArray[indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 条卡顿",(long)indexPath.row];
    return cell;
}


#pragma mark - ListNotificationInter

#pragma mark - Request

#pragma mark - Setter & getter

#pragma mark - Lazzy load
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    }
    return _tableView;
}
@end
