//
//  NSString+UMAdditions.m
//  UMViewUtils
//
//  Created by fred on 2019/3/11.
//

#import "NSString+UMAdditions.h"

@implementation NSString (UMAdditions)


+ (NSString *)stringFromDate:(NSString *)format date:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = format;
    return  [dateFormatter stringFromDate:date];
}
- (NSDate *)dateFromString:(NSString *)format{
    NSString *aFormat = nil;
    if (format) {
        aFormat = format;
    }else{
        aFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = aFormat;
    return [dateFormatter dateFromString:self];
}

+ (NSString *)localizedAtKey:(NSString *)aValue{
    return NSLocalizedString(aValue, aValue);
}

+ (NSComparisonResult)compareDate:(NSString *)one another:(NSString *)another format:(NSString *)format{
    NSDate *oD = [one dateFromString:format];
    NSDate *aD = [another dateFromString:format];
    return [oD compare:aD];
}
@end
