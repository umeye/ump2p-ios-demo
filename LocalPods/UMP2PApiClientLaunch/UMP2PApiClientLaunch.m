//
//  IMSApiClientLaunch.m
//  spring-demo
//
//  Created by Fred on 2019/3/15.
//  Copyright © 2018年 UMEye. All rights reserved.
//

#import "UMP2PApiClientLaunch.h"
#import <UMLaunchKit/UMLaunchKit.h>
#import <UMP2P/CloudSDK.h>
/// UMP2P 用户系统
#import <UMP2PAccount/UMP2PAccountLoginViewController.h>
/// UMP2P 视频播放系统
#import <UMP2PVisual/UMP2PVisualLivePreiviewViewController.h>

/// 服务器配置
static NSString *const kUMApiClientLaunchHosts = @"hosts";
/// 是否启用Log配置
static NSString *const kLauncherEnvLogs = @"logs";
/// APP应用ID
static NSString *const kLauncherEnvAppId = @"appId";
/// 服务器端口
static NSString *const kLauncherEnvPort = @"port";
/// 是否使用UM账号系统
static NSString *const kLauncherEnvUMAccount = @"account";
/// 是否使用推送功能
static NSString *const kLauncherEnvPush = @"push";

/// 默认数据
NSString * const LauncherEnvHostDefaultValue = @"v0p2p.umeye.com";
NSString * const LauncherEnvPortDefaultValue = @"8888";
NSString * const LauncherEnvAppIdDefaultValue = @"2000000000";

@interface UMP2PApiClientLaunch ()<UMLauncherProtocol>
@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, assign) BOOL isUMAccount;
@end


@implementation UMP2PApiClientLaunch

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *envConfig = [launchOptions valueForKey:kLauncherEnvConfigKey];
    NSString *gEnviroment = [envConfig valueForKey:kLauncherEnvBuildConfig] ? : LauncherEnvBuildConfigDefaultValue;
    
    NSString *host = launchOptions[kUMApiClientLaunchHosts][gEnviroment] ? : LauncherEnvHostDefaultValue;
    NSString *port = [launchOptions valueForKey:kLauncherEnvPort] ? : LauncherEnvPortDefaultValue;
    NSString *appId = [launchOptions valueForKey:kLauncherEnvAppId] ? : LauncherEnvAppIdDefaultValue;
    NSNumber *umAccount = [launchOptions valueForKey:kLauncherEnvUMAccount] ?: @(false);
    NSNumber *push = [launchOptions valueForKey:kLauncherEnvPush] ? : @(false);
    NSNumber *log = launchOptions[kLauncherEnvLogs][gEnviroment] ? : @(false);
    
    self.isUMAccount = [umAccount boolValue];
    int connType = self.isUMAccount ? 1 : 2;
    BOOL logEnable = [log boolValue];
    [UMWebClient shareClient].logEnable = logEnable;
    [UMWebClient shareClient].logDevEnable = logEnable;
    [UMWebClient shareClient].iConnType = connType;
    [UMWebClient shareClient].noLoginPushEnable = [push boolValue];
    [[UMWebClient shareClient] startSDK:host port:[port intValue] customFlag:appId];
    
    return TRUE;
}


- (void)applicationDidEnterBackground:(UIApplication *)application{
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [[UMWebClient shareClient] setClientNetState:0];
    //通知设备停止播放
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kUMAppBackgroundNotificationKey" object:nil];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [[UMWebClient shareClient] setClientNetState:1];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //检测连接服务器状态重连
        [[UMWebClient shareClient] reconnectServer];
        dispatch_async(dispatch_get_main_queue(), ^{
            //通知设备重连
            [[NSNotificationCenter defaultCenter] postNotificationName:@"kUMAppForegroundNotificationKey" object:nil];
        });
        
    });
}

- (void)setUpUIThread:(UIApplication *)application {
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[self viewControllerAtLogin:self.isUMAccount]];
    [application.keyWindow setRootViewController:navController];
}

#pragma mark - Property
/// 如果不需要UM用户系统，直接进入播放界面
- (UIViewController *)viewControllerAtLogin:(BOOL)aLogin{
    if (!_viewController) {
        if (aLogin) {
            _viewController = [[UMP2PAccountLoginViewController alloc] init];
        }else{
            _viewController = [[UMP2PVisualLivePreiviewViewController alloc] init];
        }
        
    }
    return _viewController;
}

@end
