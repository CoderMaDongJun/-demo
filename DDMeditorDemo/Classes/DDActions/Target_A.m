//
//  Target_A.m
//  DDMeditorDemo
//
//  Created by 马栋军 on 2019/3/21.
//  Copyright © 2019 马栋军. All rights reserved.
//

#import "Target_A.h"
#import "DDModuleATestController.h"

typedef void (^DDUrlRouterCallbackBlock)(NSDictionary *info);

@implementation Target_A

- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)params
{
    // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    DDModuleATestController *viewController = [[DDModuleATestController alloc] init];
    viewController.valueLabel.text = params[@"key"];
    return viewController;
}

- (id)Action_nativePresentImage:(NSDictionary *)params
{
    DDModuleATestController *viewController = [[DDModuleATestController alloc] init];
    viewController.valueLabel.text = @"this is image";
    viewController.imageView.image = params[@"image"];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
    return nil;
}

- (id)Action_showAlert:(NSDictionary *)params
{
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        DDUrlRouterCallbackBlock callback = params[@"cancelAction"];
        if (callback) {
            callback(@{@"alertAction":action});
        }
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DDUrlRouterCallbackBlock callback = params[@"confirmAction"];
        if (callback) {
            callback(@{@"alertAction":action});
        }
    }];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"alert from Module A" message:params[@"message"] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:cancelAction];
    [alertController addAction:confirmAction];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    return nil;
}

- (id)Action_nativeNoImage:(NSDictionary *)params
{
    DDModuleATestController *viewController = [[DDModuleATestController alloc] init];
    viewController.valueLabel.text = @"no image";
    viewController.imageView.image = [UIImage imageNamed:@"noImage"];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:viewController animated:YES completion:nil];
    
    return nil;
}

- (UITableViewCell *)Action_cell:(NSDictionary *)params
{
    UITableView *tableView = params[@"tableView"];
    NSString *identifier = params[@"identifier"];
    
    // 这里的TableViewCell的类型可以是自定义的，我这边偷懒就不自定义了。
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)Action_configCell:(NSDictionary *)params
{
    NSString *title = params[@"title"];
    NSIndexPath *indexPath = params[@"indexPath"];
    UITableViewCell *cell = params[@"cell"];
    
    // 这里的TableViewCell的类型可以是自定义的，我这边偷懒就不自定义了。
    cell.textLabel.text = [NSString stringWithFormat:@"%@,%ld", title, (long)indexPath.row];
    
    //    if ([cell isKindOfClass:[XXXXXCell class]]) {
    //        正常情况下在这里做特定cell的赋值，上面就简单写了
    //    }
    
    return nil;
}
@end
