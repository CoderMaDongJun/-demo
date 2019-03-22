//
//  Target_A.h
//  DDMeditorDemo
//
//  Created by 马栋军 on 2019/3/21.
//  Copyright © 2019 马栋军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Target_A : NSObject

- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)params;
- (id)Action_nativePresentImage:(NSDictionary *)params;
- (id)Action_showAlert:(NSDictionary *)params;

// 容错
- (id)Action_nativeNoImage:(NSDictionary *)params;

@end
