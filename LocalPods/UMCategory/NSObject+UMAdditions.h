//
//  NSObject+UMAdditions
//  UMViewUtils
//
//  Created by Fred on 2017/12/10.
//  Copyright © 2017年 UMEYE.COM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (UMAdditions)

/**
 去表征化参数列表
 */
@property (nonatomic, strong) NSDictionary *params;


/**
 初始化方法
 */
- (instancetype)initWithParams:(NSDictionary *)params;

@end
