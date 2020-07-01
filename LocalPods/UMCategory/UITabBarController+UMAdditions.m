//
//  UITabBarController+UMAdditions
//  UMViewUtils
//
//  Created by fred on 2018/10/18.
//  Copyright © 2018年 UMEYE. All rights reserved.
//

#import "UITabBarController+UMAdditions.h"

@implementation UITabBarController (UMAdditions)

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}
- (NSUInteger)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}

@end
