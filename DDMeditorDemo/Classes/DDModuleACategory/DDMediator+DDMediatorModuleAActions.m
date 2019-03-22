//
//  DDMediator+DDMediatorModuleAActions.m
//  DDMeditorDemo
//
//  Created by 马栋军 on 2019/3/21.
//  Copyright © 2019 马栋军. All rights reserved.
//

#import "DDMediator+DDMediatorModuleAActions.h"

NSString * const kDDMediatorTargetA = @"A";

NSString * const kDDMediatorActionNativFetchDetailViewController = @"nativeFetchDetailViewController";
NSString * const kDDMediatorActionNativePresentImage = @"nativePresentImage";
NSString * const kDDMediatorActionNativeNoImage = @"nativeNoImage";
NSString * const kDDMediatorActionShowAlert = @"showAlert";
NSString * const kDDMediatorActionCell = @"cell";
NSString * const kDDMediatorActionConfigCell = @"configCell";

@implementation DDMediator (DDMediatorModuleAActions)

- (UIViewController *)DDMediator_viewControllerForDetail
{
    UIViewController *viewController = [self performTarget:kDDMediatorTargetA
                                                    action:kDDMediatorActionNativFetchDetailViewController
                                                    params:@{@"key":@"value"}
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

- (void)DDMediator_presentImage:(UIImage *)image
{
    if (image) {
        [self performTarget:kDDMediatorTargetA
                     action:kDDMediatorActionNativePresentImage
                     params:@{@"image":image}
          shouldCacheTarget:NO];
    } else {
        // 这里处理image为nil的场景，如何处理取决于产品
        [self performTarget:kDDMediatorTargetA
                     action:kDDMediatorActionNativeNoImage
                     params:@{@"image":[UIImage imageNamed:@"noImage"]}
          shouldCacheTarget:NO];
    }
}

- (void)DDMediator_showAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction
{
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    if (message) {
        paramsToSend[@"message"] = message;
    }
    if (cancelAction) {
        paramsToSend[@"cancelAction"] = cancelAction;
    }
    if (confirmAction) {
        paramsToSend[@"confirmAction"] = confirmAction;
    }
    
    [self performTarget:kDDMediatorTargetA
                 action:kDDMediatorActionShowAlert
                 params:paramsToSend
      shouldCacheTarget:NO];
}

- (UITableViewCell *)DDMediator_tableViewCellWithIdentifier:(NSString *)identifier tableView:(UITableView *)tableView
{
    return [self performTarget:kDDMediatorTargetA
                        action:kDDMediatorActionCell
                        params:@{
                                 @"identifier":identifier,
                                 @"tableView":tableView
                                 }
             shouldCacheTarget:YES];
}

- (void)DDMediator_configTableViewCell:(UITableViewCell *)cell withTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath
{
    [self performTarget:kDDMediatorTargetA
                 action:kDDMediatorActionConfigCell
                 params:@{
                          @"cell":cell,
                          @"title":title,
                          @"indexPath":indexPath
                          }
      shouldCacheTarget:YES];
}

- (void)DDMediator_cleanTableViewCellTarget
{
    [self releaseCachedTargetWithTargetName:kDDMediatorTargetA];
}
@end
