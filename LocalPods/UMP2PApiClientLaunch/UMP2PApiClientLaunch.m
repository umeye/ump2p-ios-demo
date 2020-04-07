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
#import <UMLog/UMLog.h>
/// UMP2P 用户系统
#import <UMP2PLife/UMP2PLifeDevicesViewController.h>
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
/// 是否支持HTTPS功能
static NSString *const kLauncherEnvSSL = @"ssl";

/// 默认数据
NSString * const LauncherEnvHostDefaultValue = @"v0p2p.umeye.com";
NSString * const LauncherEnvPortDefaultValue = @"8888";
NSString * const LauncherEnvAppIdDefaultValue = @"2000000000";

#define UMLogoutNotificationKey             @"UMLogoutNotificationKey"

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
    NSNumber *ssl = launchOptions[kLauncherEnvSSL] ? : @(false);
    
    self.isUMAccount = [umAccount boolValue];
    BOOL logEnable = [log boolValue];

    UMConfig *builder = [UMConfig builder];
    // 是否启用LOG
    builder.logEnable = logEnable;
    builder.logDevEnable = logEnable;
    // 是否需要免登录推送
    builder.pushEnable = [push boolValue];
    // 是否启动SSL
    builder.sslEnable = [ssl boolValue];
    builder.host = host;
    builder.port = [port intValue];
    //是否为登录模式
    //YES：使用SDK自带的登录体系，
    //NO：不需要SDK登录体系，使用UID、用户名、密码直接访问设备
    builder.accountEnable = [umAccount boolValue];
    // 启动异步请求
    builder.asyncEnable = YES;
    // 启动SDK
    [UMConfig startSDK:appId];
    
    [self createLoginNotification];
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
- (void)createLoginNotification{
    // 用户过期以后，SDK发起的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginExpiredNotification:) name:kUMLoginExpiredNotification object:nil];
    
    // demo自定义通知，登出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutNotification:) name:UMLogoutNotificationKey object:nil];
//    ULogD(@"创建Login通知监听");
}

- (void)pushLoginNotification:(NSNotification *)noti{
    UIViewController *vc = [noti object];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[UMP2PAccountLoginViewController new]];
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    [vc presentViewController:navController animated:YES completion:nil];
}

- (void)loginExpiredNotification:(NSNotification *)noti{
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:[UMP2PAccountLoginViewController new]];
    navController.modalPresentationStyle = UIModalPresentationFullScreen;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navController animated:YES completion:nil];
}

- (void)logoutNotification:(NSNotification *)noti{
    [[UMWebClient shareClient] logoutServer:YES];
    [self pushLoginNotification:noti];
}

/// 如果不需要UM用户系统，直接进入播放界面
- (UIViewController *)viewControllerAtLogin:(BOOL)aLogin{
    if (!_viewController) {
        if (aLogin) {
            _viewController = [[UMP2PLifeDevicesViewController alloc] init];
        }else{
            _viewController = [[UMP2PVisualLivePreiviewViewController alloc] init];
        }
    }
    return _viewController;
}


@end
