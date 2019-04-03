//
//  UIViewController+UMAdditions.m
//  UMViewUtils
//
//  Created by fred on 2019/3/14.
//

#import "UIViewController+UMAdditions.h"
#import <objc/runtime.h>

static const void *kBackgroundImageViewKey = &kBackgroundImageViewKey;
static const void *kBackgroundImageKey = &kBackgroundImageKey;
static const void *kParamsKey = &kParamsKey;


@implementation UIViewController (UMAdditions)

#pragma mark - Getter Setter
- (void)setBackgroundImageView:(UIImageView *)param
{
    objc_setAssociatedObject(self, kBackgroundImageViewKey, param, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.view addSubview:param];
}

- (UIImageView *)backgroundImageView
{
    UIImageView *tempImageView = objc_getAssociatedObject(self, kBackgroundImageViewKey);
    if (!tempImageView){
        tempImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
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

- (void)setParams:(NSDictionary *)params
{
    objc_setAssociatedObject(self, kParamsKey, params, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)params
{
    return objc_getAssociatedObject(self, kParamsKey);
}

#pragma mark - 横竖屏
- (BOOL)shouldAutorotate
{
    return NO;
}
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}
@end
