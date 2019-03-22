//
//  DDMediator.h
//  DDMeditorDemo
//
//  Created by 马栋军 on 2019/3/21.
//  Copyright © 2019 马栋军. All rights reserved.
//  起源CTMediator

#import <UIKit/UIKit.h>

@interface DDMediator : NSObject
+ (instancetype)sharedInstance;

/** 远程App调用入口 */
- (id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;

/** 本地组件调用入口 */
- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;

/** 释放target对象 */
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;

@end
