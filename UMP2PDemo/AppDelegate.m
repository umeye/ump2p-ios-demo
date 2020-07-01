//
//  AppDelegate.m
//  Demo
//
//  Created by fred on 2019/3/29.
//  Copyright © 2019 UMEYE. All rights reserved.
//

#import "AppDelegate.h"
#if __has_include(<UMLaunchKit/UMLauncher.h>)
#import <UMLaunchKit/UMLauncher.h>
#define kPod
#else
#import <UMBasis/UMBasis.h>
#endif
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
#ifdef kPod
    [[UMLauncher defaultLauncher] application:application didFinishLaunchingWithOptions:launchOptions];
#else
    [UMConfig builder].sslEnable = YES;
//    [UMConfig builder].logEnable = YES;
    [UMConfig startSDK:@"xx"];
    UIViewController *vc = nil;
    if (NSClassFromString(@"ViewController")) {
        Class c = NSClassFromString(@"ViewController");
        vc = [[c alloc] init];
    }else if (NSClassFromString(@"PortViewController")) {
        Class c = NSClassFromString(@"PortViewController");
        vc = [[c alloc] init];
    }
    self.window.rootViewController = vc;
#endif
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
