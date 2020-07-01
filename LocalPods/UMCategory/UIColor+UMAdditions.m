//
//  UIColor+UMAdditions.m
//  UMViewUtils
//
//  Created by fred on 2019/3/21.
//

#import "UIColor+UMAdditions.h"

@implementation UIColor (UMAdditions)
+ (UIColor *)colorWithRGB2:(NSString *)theRGB{
    unsigned int r,g,b;
    NSRange range = NSMakeRange(0, 2);
    NSString *string1 = [theRGB substringWithRange:range];
    [[NSScanner scannerWithString:string1] scanHexInt:&r];
    
    range = NSMakeRange(2, 2);
    string1 = [theRGB substringWithRange:range];
    [[NSScanner scannerWithString:string1] scanHexInt:&g];
    
    range = NSMakeRange(4, 2);
    string1 = [theRGB substringWithRange:range];
    [[NSScanner scannerWithString:string1] scanHexInt:&b];
    
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    
}



+ (BOOL)isTheSameColor2:(UIColor*)color1 anotherColor:(UIColor*)color2
{
    if (CGColorEqualToColor(color1.CGColor, color2.CGColor)) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (UIColor *)um_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor um_colorWithRed:red green:green blue:blue alpha:1.0f];
}
+ (UIColor *)um_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((red) / 255.0) green:((green) / 255.0) blue:((blue) / 255.0) alpha:(alpha)];
}

+ (UIColor *)um_colorWithHexRGB:(NSUInteger)hexRGB {
    
    return [UIColor um_colorWithHexRGB:hexRGB alpha:1.0f];
}
+ (UIColor *)um_colorWithHexRGB:(NSUInteger)hexRGB alpha:(CGFloat)alpha {
    return [UIColor um_colorWithRed:((float)((hexRGB & 0xFF0000) >> 16)) green:((float)((hexRGB & 0xFF00) >> 8)) blue:((float)(hexRGB & 0xFF)) alpha:alpha];
}

@end
