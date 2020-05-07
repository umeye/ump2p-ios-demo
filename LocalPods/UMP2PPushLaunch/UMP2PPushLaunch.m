//
//  UMP2PPushLaunch.m
//  UMP2PPushLaunch
//
//  Created by Fred on 2019/3/15.
//  Copyright © 2018年 UMEye. All rights reserved.
//

#import "UMP2PPushLaunch.h"
#import <UMLaunchKit/UMLaunchKit.h>
#import <UMP2P/CloudSDK.h>
#import <GTSDK/GeTuiSdk.h>
#import <UserNotifications/UserNotifications.h>

/// APP应用ID
static NSString *const kLauncherEnvAppId = @"appId";

static NSString *const kLauncherEnvAppKey = @"appKey";

static NSString *const kLauncherEnvAppSecret = @"appSecret";


@interface UMP2PPushLaunch ()<UMLauncherProtocol, GeTuiSdkDelegate, UNUserNotificationCenterDelegate>

@end


@implementation UMP2PPushLaunch

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSString *appId = [launchOptions valueForKey:kLauncherEnvAppId] ? : @"";
    NSString *appKey = [launchOptions valueForKey:kLauncherEnvAppKey] ? : @"";
    NSString *appSecret = [launchOptions valueForKey:kLauncherEnvAppSecret] ? : @"";
    // [ GTSdk ]：自定义渠道
    [GeTuiSdk setChannelId:@"APPSTORE"];
    // [ GTSdk ]：使用APPID/APPKEY/APPSECRENT创建个推实例
    [GeTuiSdk startSdkWithAppId:appId appKey:appKey appSecret:appSecret delegate:self];
    [self registerRemoteNotification];
    return TRUE;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    // APP停留在后台，点击通知启动
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // [ GTSdk ]：向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceTokenData:deviceToken];
}

#pragma mark - GTSDK Delegate
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    // 收到消息推送回调
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:payloadData options:0 error:NULL];
    if (!json) {
        NSString *s = [[NSString alloc] initWithData:payloadData encoding:NSUTF8StringEncoding];
        json = @{@"msg":s};
    }
    // 控制台打印日志
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@", taskId, msgId, json, offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>[GTSdk ReceivePayload]:%@", msg);
    
}
/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    NSLog(@"\n>>[GTSdk RegisterClient]:%@\n\n", clientId);
    [UMWebClient shareClient].sClientToken = clientId;
    // 通知用户更新推送配置
    if ([[UMWebClient shareClient] isLogin]) {
        [[UMWebClient shareClient] modifyUserPushInfo:YES disableOtherUsers:YES unReadCount:0 userId:nil];
    }
}
/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@"\n>>[GTSdk error]:%@\n\n", [error localizedDescription]);
    
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // 通知SDK运行状态
    NSLog(@"\n>>[GTSdk SdkState]:%u\n\n", aStatus);
}
#pragma mark - Property
/** 注册远程通知 */
- (void)registerRemoteNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error) {
                NSLog(@"request authorization succeeded!");
            }
        }];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

- (void)setUpLanguage:(NSString *)language {
    
}

@end
