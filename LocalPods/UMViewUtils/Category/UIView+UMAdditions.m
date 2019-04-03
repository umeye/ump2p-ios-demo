//
//  UIView+UMAdditions
//
//  Created by Fred on 2017/12/10.
//  Copyright © 2017年 UMEye. All rights reserved.
//

#import "UIView+UMAdditions.h"
#import "NSObject+RACDescription.h"
#import <objc/runtime.h>
#import <Masonry/Masonry.h>
static const void *kBackgroundImageViewKey = &kBackgroundImageViewKey;
static const void *kBackgroundImageKey = &kBackgroundImageKey;

@implementation UIView (UMAdditions)

#pragma mark - Getter Setter
- (void)setBackgroundImageView:(UIImageView *)param
{
    objc_setAssociatedObject(self, kBackgroundImageViewKey, param, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addSubview:param];
    [param mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self sendSubviewToBack:param];
}

- (UIImageView *)backgroundImageView
{
    UIImageView *tempImageView = objc_getAssociatedObject(self, kBackgroundImageViewKey);
    if (!tempImageView){
        tempImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backgroundImageView = tempImageView;
        
    }
    return tempImageView;
}

- (void)setBackgroundImage:(UIImage *)param
{
    self.backgroundImageView.image = param;
    objc_setAssociatedObject(self, kBackgroundImageKey, param, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)backgroundImage
{
    return objc_getAssociatedObject(self, kBackgroundImageKey);
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (RACSignal *)rac_prepareForReuseSignal {
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if (signal != nil) return signal;
    
    signal = [[[self rac_signalForSelector:@selector(prepareForReuse)]
               mapReplace:RACUnit.defaultUnit]
              setNameWithFormat:@"%@ -rac_prepareForReuseSignal", RACDescription(self)];
    
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return signal;
}

- (void)setBgImgAlpha:(CGFloat)alpha{
    UIImageView *tempImageView = objc_getAssociatedObject(self, kBackgroundImageViewKey);
    if (tempImageView) {
        tempImageView.alpha = alpha;
    }
}


@end
