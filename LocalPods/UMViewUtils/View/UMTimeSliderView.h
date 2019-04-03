//
//  UMTimeSliderView.h
//  UMEye_v2
//
//  Created by apple on 15/6/25.
//  Copyright (c) 2015年 UMEye. All rights reserved.
//  时间戳控件

#import <UIKit/UIKit.h>

 enum {
    IOS_TIMESELIDERVIEW_TYPE_DAY  = 1,
    IOS_TIMESELIDERVIEW_TYPE_HOUR = 2,
    IOS_TIMESELIDERVIEW_TYPE_DAY_ENLARGE  = 3,
 };
typedef int IOS_TIMESELIDERVIEW_TYPE;

@protocol TimeMenuViewDelegate<NSObject>

- (void)timeSlider:(id)sender second:(long)theSecond;

@end


@interface GZCZTimeSliderItem : NSObject
@property (nonatomic, assign) long  startTime;
@property (nonatomic, assign) long  endTime;
@property (nonatomic, assign) int   timeType;
@end

@interface UMTimeSliderView : UIView

@property(nonatomic, assign) float      second;
@property(nonatomic, assign) float      minSecond;
@property(nonatomic, assign) float      maxSecond;
@property(nonatomic, strong) UIColor    *linesColor;
@property(nonatomic, strong) NSString   *timeDate;
@property(nonatomic, assign) IOS_TIMESELIDERVIEW_TYPE   type;

@property(nonatomic, assign) id<TimeMenuViewDelegate> delegate;

- (instancetype)initWithTime:(CGRect)frame times:(NSMutableArray *)aTimes;

- (void)setAllTimes:(NSMutableArray *)aAllTimes;
@end
