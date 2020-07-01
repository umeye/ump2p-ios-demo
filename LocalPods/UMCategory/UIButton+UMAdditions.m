//
//  UIButton+UMAdditions.m
//  Pods
//
//  Created by fred on 2020/7/1.
//

#import "UIButton+UMAdditions.h"

@implementation UIButton (UMAdditions)
- (void)setImageEdgeSpaing:(float)spacing{
    [self setImageEdgeInsets:UIEdgeInsetsMake(spacing, spacing, spacing, spacing)];
}
@end
