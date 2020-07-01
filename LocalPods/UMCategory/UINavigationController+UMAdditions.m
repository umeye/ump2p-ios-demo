//
//  UINavigationController+UMAdditions
//  UMViewUtils
//
//  Created by fred on 2018/10/18.
//  Copyright © 2018年 UMEYE. All rights reserved.
//

#import "UINavigationController+UMAdditions.h"

@implementation UINavigationController (UMAdditions)


-(BOOL)shouldAutorotate{
    return [self.visibleViewController shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations{
    
    return [self.visibleViewController supportedInterfaceOrientations];
}
@end
