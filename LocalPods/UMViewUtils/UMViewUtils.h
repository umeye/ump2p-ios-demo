//
//  UMViewUtils.h
//  UMViewUtils
//
//  Created by Fred on 2018/4/14.
//  Copyright © 2018年 UMEYE.COM. All rights reserved.
//

#define IOS_IPHONE_TYPE_DEVICE_IPHONE3GS    ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_IPHONE_TYPE_DEVICE_IPHONE4      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_IPHONE_TYPE_DEVICE_IPHONE5      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_IPHONE_TYPE_DEVICE_IPHONE6      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_IPHONE_TYPE_DEVICE_IPHONE6PLUS  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS_IPHONE_TYPE_DEVICE_IPAD2  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1024, 768), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_IPHONE_TYPE_DEVICE_IPADMINI1  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_IPHONE_TYPE_DEVICE_IPAD4  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(2048, 1536), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_IPHONE_TYPE_DEVICE_IPAD4_1  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_IPHONE_TYPE_DEVICE_IPADPRO  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(2732, 2048), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_IPHONE_TYPE_DEVICE_IPADPRO_1  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(2048, 2732), [[UIScreen mainScreen] currentMode].size) : NO)

#define IOS_IPHONE_TYPE_DEVICE_IPADPRO_2  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1668, 2224), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS_IPHONE_TYPE_DEVICE_IPAD_ALL  (IOS_IPHONE_TYPE_DEVICE_IPAD2 || IOS_IPHONE_TYPE_DEVICE_IPAD4 || IOS_IPHONE_TYPE_DEVICE_IPADPRO||IOS_IPHONE_TYPE_DEVICE_IPAD4_1||IOS_IPHONE_TYPE_DEVICE_IPADPRO_1 || IOS_IPHONE_TYPE_DEVICE_IPADMINI1||IOS_IPHONE_TYPE_DEVICE_IPADPRO_2)

#define IOS_IPHONE_TYPE_DEVICE_IPHONE4_ALL (IOS_IPHONE_TYPE_DEVICE_IPHONE3GS || IOS_IPHONE_TYPE_DEVICE_IPHONE4 || IOS_IPHONE_TYPE_DEVICE_IPAD_ALL)

#define IOS_IPHONE_TYPE_DEVICE_IPHONE5_OVER (!IOS_IPHONE_TYPE_DEVICE_IPHONE3GS && !IOS_IPHONE_TYPE_DEVICE_IPHONE4 && !IOS_IPHONE_TYPE_DEVICE_IPAD_ALL)


#define IOS_IPHONE_TYPE_DEVICE_IPHONE6_OVER (!IOS_IPHONE_TYPE_DEVICE_IPHONE3GS && !IOS_IPHONE_TYPE_DEVICE_IPHONE4 && !IOS_IPHONE_TYPE_DEVICE_IPHONE5 && !IOS_IPHONE_TYPE_DEVICE_IPAD_ALL)

#define UMLocalized(name) [NSString localizedAtKey:name]

/// 通知

/// 系统框架
#import <UIKit/UIKit.h>
// 颜色文件配置工具
#import <UMViewUtils/HKColorConfig.h>
/// 系统框框追加属性
#import <UMViewUtils/NSObject+UMAdditions.h>
#import <UMViewUtils/UIColor+UMAdditions.h>
#import <UMViewUtils/NSString+UMAdditions.h>
#import <UMViewUtils/UIView+UMAdditions.h>
#import <UMViewUtils/UIViewController+UMAdditions.h>
/// 自定义图片+文字按钮，可以设置文字跟图片的位置
#import <UMViewUtils/UMButton.h>
/// 云台控制杆
#import <UMViewUtils/UMJoyStick.h>
/// 时间进度条控件
#import <UMViewUtils/UMTimeSliderView.h>
///
#import <UMViewUtils/UMProgressView.h>
#import <UMViewUtils/UMNavigationView.h>
/// View、ViewController接口规范
#import <UMViewUtils/UMViewModelProtocol.h>
#import <UMViewUtils/UMViewControllerProtocol.h>
#import <UMViewUtils/UMViewProtocol.h>

/// SVProgressHUD扩充类
#import <UMViewUtils/SVProgressHUD+UMAdditions.h>
/// 时间选择控件
#import <UMViewUtils/ZYDatePickerController.h>
/// 富文本控件
#import <SJAttributesFactory/SJAttributesFactory.h>


// 账号系统相关通知
#define UMLoginStateChangedNotificationKey  @"UMLoginStateChangedNotificationKey"
#define kUMLoginExpiredNotification         @"kUMLoginExpiredNotification"
#define UMLogoutNotificationKey             @"UMLogoutNotificationKey"

