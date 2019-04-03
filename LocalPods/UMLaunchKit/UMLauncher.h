//
//  UMLauncher
//  UMLaunchKit
//
//  Created by Fred on 2019/3/15.
//

#import <Foundation/Foundation.h>

extern NSString * const UMDidFinishLaunchingWithOptionsResume;

@interface UMLauncher : NSObject <UIApplicationDelegate>

+ (instancetype)defaultLauncher;

- (void)setUpSDKLanguage:(NSString *)language;

@end
