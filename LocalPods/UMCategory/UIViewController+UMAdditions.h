//
//  UIViewController+UMAdditions.h
//  UMViewUtils
//
//  Created by fred on 2019/3/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (UMAdditions)

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImage *backgroundImage;


/**
 去Model&&表征化参数列表
 */
@property (nonatomic, strong) NSDictionary *params;

@end

NS_ASSUME_NONNULL_END
