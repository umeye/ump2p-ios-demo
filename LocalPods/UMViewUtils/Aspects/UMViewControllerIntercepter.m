//
//  UMViewControllerIntercepter.m
//
//  Created by fred on 2018/9/14.
//  Copyright © 2018年 UMEye. All rights reserved.
//

#import "UMViewControllerIntercepter.h"
#import "Aspects.h"
#import "HKColorConfig.h"
@implementation UMViewControllerIntercepter

+ (void)load
{
    [super load];
    
    [UMViewControllerIntercepter sharedInstance];
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static UMViewControllerIntercepter *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[UMViewControllerIntercepter alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        /* 方法拦截 */
        
        // 拦截 viewDidLoad 方法
        [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            
            
            [self _viewDidLoad:aspectInfo.instance];
        }  error:nil];
        
        // 拦截 viewWillAppear:
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated){
            
            [self _viewWillAppear:animated controller:aspectInfo.instance];
        } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(gestureRecognizerShouldBegin:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, UIGestureRecognizer *gestureRecognizer){
            
            [self _gestureRecognizerShouldBegin:gestureRecognizer controller:aspectInfo.instance];
        } error:NULL];
        
        
    }
    return self;
}

#pragma mark - Hook Methods
- (void)_viewDidLoad:(UIViewController <UMViewControllerProtocol>*)controller
{
    
    
    // 只有遵守 UMViewControllerProtocol 的 viewController 才进行 配置
    if ([controller conformsToProtocol:@protocol(UMViewControllerProtocol)]) {
        // 执行协议方法
        controller.edgesForExtendedLayout = UIRectEdgeNone;
        controller.extendedLayoutIncludesOpaqueBars = NO;
        controller.automaticallyAdjustsScrollViewInsets = NO;
        
        controller.view.backgroundColor = [UIColor whiteColor];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back", @"")
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
        controller.navigationItem.backBarButtonItem = item;
        controller.navigationController.navigationBar.tintColor = [self colorWithHexRGB:0x46a0f8];
        
//        controller.navigationController.navigationController.interactivePopGestureRecognizer.enabled = YES;
//        controller.navigationController.navigationController.interactivePopGestureRecognizer.delegate = controller;
        
        
        if ([controller respondsToSelector:@selector(initialDefaultsForController)]) {
            [controller initialDefaultsForController];
        }
        
        if ([controller respondsToSelector:@selector(configNavigationForController)]) {
            [controller configNavigationForController];
        }
        
        if ([controller respondsToSelector:@selector(createViewForConctroller)]) {
            [controller createViewForConctroller];
        }
        if ([controller respondsToSelector:@selector(bindViewModelForController)]) {
            [controller bindViewModelForController];
        }
        
        
        
    }
}

- (void)_viewWillAppear:(BOOL)animated controller:(UIViewController <UMViewControllerProtocol>*)controller
{
    
}


- (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((red) / 255.0) green:((green) / 255.0) blue:((blue) / 255.0) alpha:(alpha)];
}

- (UIColor *)colorWithHexRGB:(NSUInteger)hexRGB {
    
    return [self colorWithHexRGB:hexRGB alpha:1.0f];
}
- (UIColor *)colorWithHexRGB:(NSUInteger)hexRGB alpha:(CGFloat)alpha {
    return [self colorWithRed:((float)((hexRGB & 0xFF0000) >> 16)) green:((float)((hexRGB & 0xFF00) >> 8)) blue:((float)(hexRGB & 0xFF)) alpha:alpha];
}


- (BOOL)_gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer controller:(UIViewController <UMViewControllerProtocol>*)controller
{
    if (gestureRecognizer == controller.navigationController.interactivePopGestureRecognizer) {
        UIViewController *vc = [controller.navigationController topViewController];
        if([vc respondsToSelector:@selector(navigationShouldPopOnBackButton)]) {
            return [vc performSelector:@selector(navigationShouldPopOnBackButton) withObject:nil];
        }
        return [controller.navigationController.interactivePopGestureRecognizer.delegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}
@end
