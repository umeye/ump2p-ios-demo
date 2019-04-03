//
//  UMLauncherEnv.m
//  UMLaunchKit
//
//  Created by Fred on 2019/3/15.
//

#import "UMLauncherEnv.h"

NSString * const kLauncherEnvConfigKey = @"UMLauncherEnvConfigKey";

NSString * const kLauncherEnvLanguage = @"language";
NSString * const kLauncherEnvBuildConfig = @"buildConfig";

NSString * const LauncherEnvLanguageDefaultValue = @"zh-CN";
NSString * const LauncherEnvBuildConfigDefaultValue = @"release";


static NSString * const UMLauncherBundleName = @"UMLaunchKit";

@interface UMLauncherEnv ()

@end

@implementation UMLauncherEnv

+ (instancetype)sharedInstance {
    static UMLauncherEnv *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _launcherConfig = [NSMutableDictionary dictionary];
        
        [self loadConfig];
    }
    return self;
}

#pragma mark - Method

- (void)loadConfig {
    NSDictionary *defaultConfig = [self loadConfigWithFilePath:[self defalutConfigFilePath]];
    [self.launcherConfig addEntriesFromDictionary:defaultConfig ? : @{}];
}

- (NSDictionary *)loadConfigWithFilePath:(NSString *)path {
    if (!path) {
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (!data) {
        return nil;
    }
    
    NSError *error;
    NSDictionary *config = [NSJSONSerialization JSONObjectWithData:data
                                                          options:0
                                                            error:&error];
    
    if (error) {
        NSLog(@"Something went wrong! %@", error.localizedDescription);
        return nil;
    }
    
    return config;
}

#pragma mark - File Path

- (NSString *)defalutConfigFilePath {
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:UMLauncherBundleName
                                               withExtension:@"bundle"];
    if (!bundleURL) {
        return nil;
    }
    
    NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
    if (!bundle) {
        return nil;
    }
    
    return [bundle pathForResource:UMLauncherBundleName ofType:@"json"];
}


@end

