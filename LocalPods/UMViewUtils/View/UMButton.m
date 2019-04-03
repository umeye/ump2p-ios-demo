//
//  UMButton.m
//
//  Created by fred on 2019/1/17.
//

#import "UMButton.h"

@implementation UMButton

- (void)drawRect:(CGRect)rect {
    [self BtnImagePosition:self.imagePosition imageTitleSpace:self.space];
}

-(void)setImagePosition:(NSUInteger)imagePosition {
    _imagePosition = imagePosition;
    [self BtnImagePosition:imagePosition imageTitleSpace:self.space];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    if (self.imagePosition == CustomizeBtnImagePositionLeft) {
        [super setTitle:[NSString stringWithFormat:@" %@",title] forState:state];
    }else{
        [super setTitle:title forState:state];
    }
    
}

-(void)setSpace:(NSUInteger)space {
    _space = space;
    [self BtnImagePosition:self.imagePosition imageTitleSpace:space];
}

- (void)BtnImagePosition:(CustomizeBtnImagePosition)style
         imageTitleSpace:(CGFloat)space {
    
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    switch (style) {
        case CustomizeBtnImagePositionTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case CustomizeBtnImagePositionLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case CustomizeBtnImagePositionBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case CustomizeBtnImagePositionRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


@end
