//
//  UMJoyStick
//  UMJoyStick
//
//  Created by Fred on 2017/6/19.
//  Copyright © 2017年 UMEYE.COM. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UMJoyStick;

@protocol UMJoyStickDelegate <NSObject>

@optional
- (void)stickDidChangeValue:(UMJoyStick *)stick;
- (void)stickDidMoveEnd:(UMJoyStick *)stick;
@end

typedef void (^UMJoyStickTask)(NSDictionary *info);

@interface UMJoyStick : UIView

@property (nonatomic, assign) id <UMJoyStickDelegate> delegate;
@property(nonatomic, copy) UMJoyStickTask task;

@end
