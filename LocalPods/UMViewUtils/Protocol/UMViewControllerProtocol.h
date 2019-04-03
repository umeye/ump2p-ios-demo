//
//  UMViewControllerProtocol.h
//
//  Created by fred on 2018/9/14.
//  Copyright © 2018年 UMEye. All rights reserved.
//

/**
 为 ViewController 绑定方法协议
 */
#import <UIKit/UIKit.h>
@protocol UMViewControllerProtocol <NSObject>

#pragma mark - 方法绑定
@required
/// 初始化数据
- (void)initialDefaultsForController;

/// 绑定 vm
- (void)bindViewModelForController;

/// 创建视图
- (void)createViewForConctroller;

/// 配置导航栏
- (void)configNavigationForController;

@end
