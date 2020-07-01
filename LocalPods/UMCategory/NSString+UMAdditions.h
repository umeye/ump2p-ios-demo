//
//  NSString+UMAdditions.h
//  UMViewUtils
//
//  Created by fred on 2019/3/11.
//

#import <Foundation/Foundation.h>


@interface NSString (UMAdditions)

+ (NSString *)stringFromDate:(NSString *)format date:(NSDate *)date;
- (NSDate *)dateFromString:(NSString *)format;

+ (NSString *)localizedAtKey:(NSString *)aValue;

/// 时间对比
+ (NSComparisonResult)compareDate:(NSString *)one another:(NSString *)another format:(NSString *)format;
@end

