//
//  UMLauncherProtocol.h
//  UMLaunchKit
//
//  Created by Fred on 2019/3/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UMLauncherProtocol <NSObject>

@optional
- (void)setUpUIThread:(UIApplication *)application;

@end

NS_ASSUME_NONNULL_END
