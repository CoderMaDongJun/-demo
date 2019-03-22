//
//  DDMediator+DDMediatorModuleAActions.h
//  DDMeditorDemo
//
//  Created by 马栋军 on 2019/3/21.
//  Copyright © 2019 马栋军. All rights reserved.
//

#import "DDMediator.h"

@interface DDMediator (DDMediatorModuleAActions)

- (UIViewController *)DDMediator_viewControllerForDetail;

- (void)DDMediator_showAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction;

- (void)DDMediator_presentImage:(UIImage *)image;

- (UITableViewCell *)DDMediator_tableViewCellWithIdentifier:(NSString *)identifier tableView:(UITableView *)tableView;

- (void)DDMediator_configTableViewCell:(UITableViewCell *)cell withTitle:(NSString *)title atIndexPath:(NSIndexPath *)indexPath;

- (void)DDMediator_cleanTableViewCellTarget;

@end
