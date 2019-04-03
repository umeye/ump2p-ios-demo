//
//  UMButton.h
//
//  Created by fred on 2019/1/17.
//

#import <UIKit/UIKit.h>


typedef IBInspectable NS_ENUM(NSUInteger, CustomizeBtnImagePosition) {
    CustomizeBtnImagePositionTop, // image在上，label在下
    CustomizeBtnImagePositionLeft, // image在左，label在右
    CustomizeBtnImagePositionBottom, // image在下，label在上
    CustomizeBtnImagePositionRight // image在右，label在左
};

IB_DESIGNABLE
@interface UMButton : UIButton
@property(nonatomic,unsafe_unretained)IBInspectable NSUInteger imagePosition;
@property(nonatomic,unsafe_unretained)IBInspectable NSUInteger space;

@end

