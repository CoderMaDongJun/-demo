//
//  ViewController.m
//  DDMeditorDemo
//
//  Created by 马栋军 on 2019/3/21.
//  Copyright © 2019 马栋军. All rights reserved.
//

#import "ViewController.h"
#import "DDMediator+DDMediatorModuleAActions.h"
#import "DDTestTableTViewController.h"

NSString * const kCellIdentifier = @"kCellIdentifier";
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        UIViewController *viewController = [[DDMediator sharedInstance] DDMediator_viewControllerForDetail];
        
        // 获得view controller之后，在这种场景下，到底push还是present，其实是要由使用者决定的，mediator只要给出view controller的实例就好了
        [self presentViewController:viewController animated:YES completion:nil];
    }
    
    if (indexPath.row == 1) {
        UIViewController *viewController = [[DDMediator sharedInstance] DDMediator_viewControllerForDetail];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
    if (indexPath.row == 2) {
        // 这种场景下，很明显是需要被present的，所以不必返回实例，mediator直接present了
        [[DDMediator sharedInstance] DDMediator_presentImage:[UIImage imageNamed:@"image"]];
    }
    
    if (indexPath.row == 3) {
        // 这种场景下，参数有问题，因此需要在流程中做好处理
        [[DDMediator sharedInstance] DDMediator_presentImage:nil];
    }
    
    if (indexPath.row == 4) {
        [[DDMediator sharedInstance] DDMediator_showAlertWithMessage:@"casa" cancelAction:nil confirmAction:^(NSDictionary *info) {
            // 做你想做的事
            NSLog(@"alert:%@",info);
        }];
    }
    
    if (indexPath.row == 5) {
        DDTestTableTViewController *tableViewController = [[DDTestTableTViewController alloc] init];
        [self presentViewController:tableViewController animated:YES completion:nil];
    }
    
    if (indexPath.row == 6) {
        [[DDMediator sharedInstance] performTarget:@"InvalidTarget" action:@"InvalidAction" params:nil shouldCacheTarget:NO];
    }
}

#pragma mark - getters and setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    }
    return _tableView;
}

- (NSArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = @[@"present detail view controller",
                        @"push detail view controller",
                        @"present image",
                        @"present image when error",
                        @"show alert",
                        @"table view cell",
                        @"No Target-Action response"
                        ];
    }
    return _dataSource;
}

@end
