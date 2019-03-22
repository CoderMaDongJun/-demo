//
//  DDTestTableTViewController.m
//  DDMeditorDemo
//
//  Created by 马栋军 on 2019/3/21.
//  Copyright © 2019 马栋军. All rights reserved.
//

#import "DDTestTableTViewController.h"
#import "DDMediator+DDMediatorModuleAActions.h"

@interface DDTestTableTViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *closeButton;

@end

@implementation DDTestTableTViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.closeButton];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
    self.closeButton.frame = (CGRect){self.view.center,{100,100}};
}

- (void)dealloc
{
    // 在Controller被回收的时候，把相关的target也回收掉
    [[DDMediator sharedInstance] DDMediator_cleanTableViewCellTarget];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 通过Mediator来获取cell实例，由于target已经被cache了，高频调用不是问题。
    [[DDMediator sharedInstance] DDMediator_configTableViewCell:cell withTitle:@"cell title" atIndexPath:indexPath];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 通过mediator来配置cell实例，由于target已经被cache了，高频调用不是问题。
    return [[DDMediator sharedInstance] DDMediator_tableViewCellWithIdentifier:@"cell" tableView:tableView];
}

#pragma mark - event response
- (void)didTappedCloseButton:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getters and setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton *)closeButton
{
    if (_closeButton == nil) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"Close" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(didTappedCloseButton:) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.backgroundColor = [UIColor grayColor];
    }
    return _closeButton;
}
@end
