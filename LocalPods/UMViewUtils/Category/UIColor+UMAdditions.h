//
//  UIColor+UMAdditions.h
//  UMViewUtils
//
//  Created by fred on 2019/3/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (UMAdditions)
+ (UIColor *)colorWithRGB2:(NSString *)theRGB;
+ (BOOL)isTheSameColor2:(UIColor*)color1 anotherColor:(UIColor*)color2;

/// 通过16进制的rgb值得到UIColor
+ (UIColor *)um_colorWithHexRGB:(NSUInteger)hexRGB;
@end

NS_ASSUME_NONNULL_END
