//
//  UMLauncher
//  UMLaunchKit
//
//  Created by Fred on 2019/3/15.
//

#import "UMLauncher.h"

#import "UMLauncherEnv.h"
#import "UMSDKConfig.h"
#import "UMLauncherProtocol.h"

NSString * const UMDidFinishLaunchingWithOptionsResume = @"UMDidFinishLaunchingWithOptionsResume";

static NSString *const LaunchSDKNameKey = @"name";
static NSString *const LaunchSDKVersionKey = @"version";
static NSString *const LaunchSDKDescriptionKey = @"description";

static NSString *const LaunchSDKInitializedKey = @"initializedInUIThread";

static NSString *const LaunchInitializerClassNameKey = @"initializerClass";
static NSString *const LaunchGlueClassListKey = @"glueClassList";

static NSString *const LaunchSDKOptionsKey = @"opts";


@interface UMLauncher ()

@property (nonatomic, strong) NSArray<UMSDKConfig *> *sdkConfigList;

@property (nonatomic, strong) NSDictionary *initializerInstanceInfo;
@property (nonatomic, strong) NSDictionary *glueInstanceInfo;


@property (nonatomic, strong) NSDictionary *launchOptions;
@property (nonatomic, assign) NSInteger initIndex;

@end


@implementation UMLauncher

+ (instancetype)defaultLauncher {
    static UMLauncher *launcher = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        launcher = [[[self class] alloc] init];
    });
    
    return launcher;
}


- (id)init {
    if (self = [super init]) {
        _initIndex = 0;
        
        [self registerObserver];
        
        [self instanceClass];
    }
    
    return self;
}


- (void)dealloc {
    [self removeApplicationObserver];
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"%s options:%@", __FUNCTION__, launchOptions);
    
    BOOL ret = TRUE;
    for (NSInteger index = self.initIndex; index < self.sdkConfigList.count; index++) {
        self.initIndex++;
        
        UMSDKConfig *config = self.sdkConfigList[index];
        NSMutableDictionary *options = [[self sdkConfigWithName:config.initializerClassName].options mutableCopy];
        [options addEntriesFromDictionary:launchOptions];
        
        NSDictionary *envConfig = [UMLauncherEnv sharedInstance].launcherConfig ? : @{};
        [options setValue:envConfig forKey:kLauncherEnvConfigKey];
        
        id<UIApplicationDelegate> instance = self.initializerInstanceInfo[config.initializerClassName];
        [instance application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:options];
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[config.initializerClassName]) {
            ret = [glueInstance application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:options];
            if (ret == FALSE) {
                return FALSE;
            }
        }
        
        
    }
    [self setUpUIThread:application];
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (NSString *key in [self.initializerInstanceInfo allKeys]) {
        id<UIApplicationDelegate> instance = self.initializerInstanceInfo[key];
        if ([instance respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
            [instance application:application didReceiveRemoteNotification:userInfo];
        }
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[key]) {
            if ([glueInstance respondsToSelector:@selector(application:didReceiveRemoteNotification:)]) {
                [glueInstance application:application didReceiveRemoteNotification:userInfo];
            }
        }
    }
}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    for (NSString *key in [self.initializerInstanceInfo allKeys]) {
        id<UIApplicationDelegate> instance = self.initializerInstanceInfo[key];
        if ([instance respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
            [instance application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[key]) {
            if ([glueInstance respondsToSelector:@selector(application:didRegisterForRemoteNotificationsWithDeviceToken:)]) {
                [glueInstance application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
            }
        }
    }
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    for (NSString *key in [self.initializerInstanceInfo allKeys]) {
        id<UIApplicationDelegate> instance = self.initializerInstanceInfo[key];
        if ([instance respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) {
            [instance application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[key]) {
            if ([glueInstance respondsToSelector:@selector(application:didFailToRegisterForRemoteNotificationsWithError:)]) {
                [glueInstance application:application didFailToRegisterForRemoteNotificationsWithError:error];
            }
        }
    }
}


#pragma mark - Other

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    NSLog(@"%s notification:%@", __FUNCTION__, notification);
    
    for (NSString *key in [self.initializerInstanceInfo allKeys]) {
        id<UIApplicationDelegate> instance = self.initializerInstanceInfo[key];
        if ([instance respondsToSelector:@selector(applicationDidBecomeActive:)]) {
            [instance applicationDidBecomeActive:[UIApplication sharedApplication]];
        }
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[key]) {
            if ([glueInstance respondsToSelector:@selector(applicationDidBecomeActive:)]) {
                [glueInstance applicationDidBecomeActive:[UIApplication sharedApplication]];
            }
        }
    }
}


- (void)applicationWillResignActive:(NSNotification *)notification {
    NSLog(@"%s notification:%@", __FUNCTION__, notification);
    
    for (NSString *key in [self.initializerInstanceInfo allKeys]) {
        id<UIApplicationDelegate> instance = self.initializerInstanceInfo[key];
        if ([instance respondsToSelector:@selector(applicationWillResignActive:)]) {
            [instance applicationWillResignActive:[UIApplication sharedApplication]];
        }
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[key]) {
            if ([glueInstance respondsToSelector:@selector(applicationWillResignActive:)]) {
                [glueInstance applicationWillResignActive:[UIApplication sharedApplication]];
            }
        }
    }
}


- (void)applicationDidEnterBackground:(NSNotification *)notification {
    NSLog(@"%s notification:%@", __FUNCTION__, notification);
    
    for (NSString *key in [self.initializerInstanceInfo allKeys]) {
        id<UIApplicationDelegate> instance = self.initializerInstanceInfo[key];
        if ([instance respondsToSelector:@selector(applicationDidEnterBackground:)]) {
            [instance applicationDidEnterBackground:[UIApplication sharedApplication]];
        }
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[key]) {
            if ([glueInstance respondsToSelector:@selector(applicationDidEnterBackground:)]) {
                [glueInstance applicationDidEnterBackground:[UIApplication sharedApplication]];
            }
        }
    }
}


- (void)applicationWillEnterForeground:(NSNotification *)notification {
    NSLog(@"%s notification:%@", __FUNCTION__, notification);
    
    for (NSString *key in [self.initializerInstanceInfo allKeys]) {
        id<UIApplicationDelegate> instance = self.initializerInstanceInfo[key];
        if ([instance respondsToSelector:@selector(applicationWillEnterForeground:)]) {
            [instance applicationWillEnterForeground:[UIApplication sharedApplication]];
        }
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[key]) {
            if ([glueInstance respondsToSelector:@selector(applicationWillEnterForeground:)]) {
                [glueInstance applicationWillEnterForeground:[UIApplication sharedApplication]];
            }
        }
    }
}


- (void)applicationDidReceiveMemoryWarning:(NSNotification *)notification {
    NSLog(@"%s notification:%@", __FUNCTION__, notification);
    
    for (NSString *key in [self.initializerInstanceInfo allKeys]) {
        id<UIApplicationDelegate> instance = self.initializerInstanceInfo[key];
        if ([instance respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]) {
            [instance applicationDidReceiveMemoryWarning:[UIApplication sharedApplication]];
        }
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[key]) {
            if ([glueInstance respondsToSelector:@selector(applicationDidReceiveMemoryWarning:)]) {
                [glueInstance applicationDidReceiveMemoryWarning:[UIApplication sharedApplication]];
            }
        }
    }
}


- (void)applicationWillTerminate:(NSNotification *)notification {
    NSLog(@"%s notification:%@", __FUNCTION__, notification);
    
    for (NSString *key in [self.initializerInstanceInfo allKeys]) {
        id<UIApplicationDelegate> instance = self.initializerInstanceInfo[key];
        if ([instance respondsToSelector:@selector(applicationWillTerminate:)]) {
            [instance applicationWillTerminate:[UIApplication sharedApplication]];
        }
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[key]) {
            if ([glueInstance respondsToSelector:@selector(applicationWillTerminate:)]) {
                [glueInstance applicationWillTerminate:[UIApplication sharedApplication]];
            }
        }
    }
}

- (void)didFinishLaunchingWithOptionsResume:(NSNotification *)notification {
    id<UIApplicationDelegate> obj = self;
    [obj application:[UIApplication sharedApplication] didFinishLaunchingWithOptions:self.launchOptions];
}

#pragma mark - Method
- (void)setUpUIThread:(UIApplication *)application {
    for (NSInteger index = 0; index < self.sdkConfigList.count; index++) {
        UMSDKConfig *config = self.sdkConfigList[index];
        if (!config.runInMainThread) {
            continue;
        }
        id instance = self.initializerInstanceInfo[config.initializerClassName];
        if ([instance respondsToSelector:@selector(setUpUIThread:)]) {
            [instance performSelector:@selector(setUpUIThread:) withObject:application];
        }
        
        for (id<UIApplicationDelegate> glueInstance in self.glueInstanceInfo[config.initializerClassName]) {
            if ([glueInstance respondsToSelector:@selector(setUpUIThread:)]) {
                [glueInstance performSelector:@selector(setUpUIThread:) withObject:application];
            }
        }
    }
}

- (UMSDKConfig *)sdkConfigWithName:(NSString *)name {
    for (UMSDKConfig *config in self.sdkConfigList) {
        if ([config.initializerClassName isEqualToString:name]) {
            return config;
        }
    }
    return nil;
}

- (NSArray *)launchJSONConfig {
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *path = [mainBundle pathForResource:@"Launch" ofType:@"json"];
    
    if (!path) {
        return nil;
    }
    
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    if (!data) {
        return nil;
    }
    
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

#pragma mark - Property

- (NSArray *)sdkConfigList {
    if (!_sdkConfigList) {
        NSArray *jsonArray = [self launchJSONConfig];
        
        NSMutableArray *sdkConfigList = [NSMutableArray array];
        
        for (NSDictionary *item in jsonArray) {
            UMSDKConfig *conf = [[UMSDKConfig alloc] init];
            
            conf.name = item[LaunchSDKNameKey];
            conf.version = item[LaunchSDKVersionKey];
            conf.desc = item[LaunchSDKDescriptionKey];
            
            conf.runInMainThread = [item[LaunchSDKInitializedKey] boolValue];
            
            conf.initializerClassName = item[LaunchInitializerClassNameKey];
            conf.glueClassList = item[LaunchGlueClassListKey];
            
            conf.options = item[LaunchSDKOptionsKey];
            
            [sdkConfigList addObject:conf];
        }
        
        _sdkConfigList = sdkConfigList;
    }
    
    return _sdkConfigList;
}

- (void)instanceClass {
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    NSMutableDictionary *glueInfo = [NSMutableDictionary dictionary];
    
    for (UMSDKConfig *config in [self sdkConfigList]) {
        Class class = NSClassFromString(config.initializerClassName);
        if (class) {
            info[config.initializerClassName] = [[class alloc] init];
        }
        
        if (config.glueClassList.count > 0) {
            NSMutableArray *mutArray = [NSMutableArray array];
            
            for (NSString *glueClassName in config.glueClassList) {
                Class class = NSClassFromString(glueClassName);
                if (class) {
                    [mutArray addObject:[[class alloc] init]];
                }
            }
            glueInfo[config.initializerClassName] = mutArray;
        }
    }
    _initializerInstanceInfo = info;
    _glueInstanceInfo = glueInfo;
}

#pragma mark - Add or Remove UIApplication State Observer

- (void)registerObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillResignActive:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationDidReceiveMemoryWarning:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(applicationWillTerminate:)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didFinishLaunchingWithOptionsResume:)
                                                 name:UMDidFinishLaunchingWithOptionsResume
                                               object:nil];
}


- (void)removeApplicationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
}

@end
