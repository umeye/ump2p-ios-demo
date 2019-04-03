//
//  SVProgressHUD+UMAdditions
//  UMViewUtils
//
//  Created by Fred on 2018/9/27.
//  Copyright © 2017年 UMEye. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (UMAdditions)

/// 显示不带文字的overflow
+ (void)um_displayOverFlowActivityView;
+ (void)um_displayOverFlowActivityView:(NSTimeInterval)maxShowTime;

/// 显示成功状态
+ (void)um_displaySuccessWithStatus:(NSString *)status;

/// 显示失败状态
+ (void)um_displayErrorWithStatus:(NSString *)status;

/// 显示提示信息
+ (void)um_dispalyInfoWithStatus:(NSString *)status;

/// 显示提示信息
+ (void)um_dispalyMsgWithStatus:(NSString *)status;

/// 显示加载圈 加文本
+ (void)um_dispalyLoadingMsgWithStatus:(NSString *)status;

/// 显示进度，带文本
+ (void)um_dispalyProgress:(CGFloat)progress status:(NSString *)status;

/// 显示进度，不带文本
+ (void)um_dispalyProgress:(CGFloat)progress;


@end
