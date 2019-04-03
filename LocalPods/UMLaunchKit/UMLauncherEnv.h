//
//  UMLauncherEnv.h
//  UMLaunchKit
//
//  Created by Fred on 2019/3/15.
//

#import <Foundation/Foundation.h>

extern NSString * const kLauncherEnvConfigKey;

extern NSString * const kLauncherEnvLanguage;
extern NSString * const kLauncherEnvBuildConfig;

extern NSString * const LauncherEnvLanguageDefaultValue;
extern NSString * const LauncherEnvBuildConfigDefaultValue;



@interface UMLauncherEnv : NSObject

@property (nonatomic, strong) NSMutableDictionary *launcherConfig;

+ (instancetype)sharedInstance;

@end
