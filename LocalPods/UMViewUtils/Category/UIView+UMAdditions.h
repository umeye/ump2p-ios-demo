//
//  UIView+UMAdditions
//
//  Created by Fred on 2017/12/10.
//  Copyright © 2017年 UMEye. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
// 获取当前数据源的下标
FOUNDATION_EXTERN NSString *const um_UIView_DataSourceArrayIndexKey;

@interface UIView (UMAdditions)
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImage *backgroundImage;

- (void)setBgImgAlpha:(CGFloat)alpha;

- (RACSignal *)rac_prepareForReuseSignal;
@end
