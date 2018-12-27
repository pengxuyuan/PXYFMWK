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
        
    }];
    
    TabelViewCellModel *model1 = [TabelViewCellModel creatWithTitle:@"02·iOS 面试题·Category 的实现原理，以及 Category 为什么只能加方法不能加属性？" operationBlock:nil];
    
    TabelViewCellModel *model2 = [TabelViewCellModel creatWithTitle:@"03·iOS 面试题·main()之前的过程有哪些?" operationBlock:nil];
    
    TabelViewCellModel *model3 = [TabelViewCellModel creatWithTitle:@"04·iOS 面试题·Block 的原理，Block 的属性修饰词为什么用 copy，使用 Block 时有哪些要注意的？" operationBlock:nil];
    
    TabelViewCellModel *model4 = [TabelViewCellModel creatWithTitle:@"05·iOS 面试题·Sizeof与Strlen的区别与联系" operationBlock:nil];
    
    TabelViewCellModel *model5 = [TabelViewCellModel creatWithTitle:@"06·iOS 面试题·Category 中有 load 方法吗？load 方法是什么时候调用的？load 方法能继承吗？" operationBlock:nil];

    TabelViewCellModel *model6 = [TabelViewCellModel creatWithTitle:@"07·iOS 面试题·class A 继承 class B，class B 继承 NSObject，请画出完整的类图" operationBlock:nil];
    
    [self.cellModelArray addObject:model0];
    [self.cellModelArray addObject:model1];
    [self.cellModelArray addObject:model2];
    [self.cellModelArray addObject:model3];
    [self.cellModelArray addObject:model4];
    [self.cellModelArray addObject:model5];
    [self.cellModelArray addObject:model6];
    
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
- (IBAction)jump1:(id)sender {
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
