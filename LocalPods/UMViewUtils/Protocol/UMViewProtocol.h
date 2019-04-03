//
//  UMViewProtocol.h
//  HEeyes
//
//  Created by fred on 2018/10/8.
//  Copyright © 2018年 UMEYE. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol UMViewProtocol <NSObject>

#pragma mark - 方法绑定
@required

- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params;

@end
