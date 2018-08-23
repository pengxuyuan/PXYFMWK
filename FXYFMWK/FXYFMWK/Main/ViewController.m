//
//  ViewController.m
//  FXYFMWK
//
//  Created by Pengxuyuan on 2018/8/13.
//  Copyright © 2018年 Pengxuyuan. All rights reserved.
//

#import "ViewController.h"

@interface TabelViewCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void (^operationBlock)(void);

+ (instancetype)creatWithTitle:(NSString *)title operationBlock:(void (^)(void))operationBlock;

@end

@implementation TabelViewCellModel

+ (instancetype)creatWithTitle:(NSString *)title operationBlock:(void (^)(void))operationBlock {
    TabelViewCellModel *model = [TabelViewCellModel new];
    model.title = title;
    model.operationBlock = operationBlock;
    
    return model;
}

@end

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *cellModelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildData];
    
    self.navigationItem.title = @"PXYFMWK";
    [self.view addSubview:self.tableView];
}

#pragma mark - Private Methods
- (void)buildData {
    self.cellModelArray = [NSMutableArray array];
    
    __weak typeof(self)weakSelf = self;
    
    TabelViewCellModel *model0 = [TabelViewCellModel creatWithTitle:@"01·iOS 面试题·项目中用过 Runtime 吗？" operationBlock:^{
        
    }] ;
    [self.cellModelArray addObject:model0];
    
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TabelViewCellModel *model = self.cellModelArray[indexPath.row];
    if (model.operationBlock) {
        model.operationBlock();
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    TabelViewCellModel *model = self.cellModelArray[indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

#pragma mark - Lazzy Load
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}


@end
