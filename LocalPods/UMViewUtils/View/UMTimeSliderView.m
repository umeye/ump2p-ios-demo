//
//  UMTimeSliderView.m
//  UMEye_v2
//
//  Created by apple on 15/6/25.
//  Copyright (c) 2015年 UMEye. All rights reserved.
//

#import "UMTimeSliderView.h"

#define IOS_DAY_SECOND (60 * 60 * 24)
#define IOS_LINE_SPACING 3
@interface GZCZTimeView : UIView
@property(nonatomic, strong) NSMutableArray             *tAllTimes;
@property(nonatomic, strong) UIColor                    *linesColor;
@property(nonatomic, assign) float                      contentWidth;
@property(nonatomic, assign) float                      viewWidth;
@property(nonatomic, assign) float                      viewHeight;
@property(nonatomic, assign) IOS_TIMESELIDERVIEW_TYPE   type;
@property(nonatomic, assign) float                      minuteSpacing;
@end



@implementation GZCZTimeSliderItem
@end
#pragma mark -
@implementation GZCZTimeView

- (instancetype)initWithFrame:(CGRect)frame viewWidth:(float)theWidth times:(NSMutableArray *)aTimes minuteSpacing:(float)aMinuteSpacing{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewWidth = theWidth;
        self.viewHeight = CGRectGetHeight(frame);
        self.backgroundColor = [UIColor clearColor];
        self.linesColor = [UIColor whiteColor];
        self.tAllTimes = aTimes;
        self.minuteSpacing = aMinuteSpacing;
    }
    return self;
}


- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();

    float beginX = self.viewWidth/2;
    float spacing = _minuteSpacing;
    float textW = 37;
    float tempH = 15;
    float linesSpacing = IOS_LINE_SPACING;//5
    float linesH = CGRectGetHeight(self.frame) - 15 - linesSpacing * 2;
    
    UIFont  *font = [UIFont systemFontOfSize:10.0];
    
    CGPoint aPoints[2];
    
    CGContextDrawPath(context, kCGPathStroke);
    CGContextSetStrokeColorWithColor(context,[UIColor greenColor].CGColor);
    CGContextSetFillColorWithColor(context,  [UIColor greenColor].CGColor);
    CGRect tempRect;
    for (int i = 0; i < self.tAllTimes.count; i++) {
        NSObject *tempObj = self.tAllTimes[i];
        float tempMin,tempMax,tempX;
        if ([tempObj isKindOfClass:[GZCZTimeSliderItem class]]) {
            GZCZTimeSliderItem *tempTime = (GZCZTimeSliderItem *)tempObj;
            tempMin = beginX + spacing * (tempTime.startTime/60/10.f);
            tempMax = tempTime.endTime;
            if (tempMax == 0 && tempMin != 0) {
                tempMax = 86400;
            }
            tempMax = beginX + spacing * (tempMax/60/10.f);
            tempX = beginX + spacing * (tempTime.startTime/60/10.f);

            if (tempTime.timeType == 1) {//报警方式
                CGContextSetStrokeColorWithColor(context,[UIColor redColor].CGColor);
                CGContextSetFillColorWithColor(context,  [UIColor redColor].CGColor);
            }
            else if (tempTime.timeType == 2) {//手动方式
                CGContextSetStrokeColorWithColor(context,[UIColor yellowColor].CGColor);
                CGContextSetFillColorWithColor(context,  [UIColor yellowColor].CGColor);
            }
            else if (tempTime.timeType == 3) {//定时方式
                CGContextSetStrokeColorWithColor(context,[UIColor greenColor].CGColor);
                CGContextSetFillColorWithColor(context,  [UIColor greenColor].CGColor);
            }else{
                CGContextSetStrokeColorWithColor(context,[UIColor greenColor].CGColor);
                CGContextSetFillColorWithColor(context,  [UIColor greenColor].CGColor);
            }
        }else{
            NSMutableArray *tempTime = (NSMutableArray *)tempObj;
            tempMin = beginX + spacing * ([tempTime[0] longValue]/60/10.f);
            tempMax = [tempTime[1] longValue];
            if (tempMax == 0 && tempMin != 0) {
                tempMax = 86400;
            }
            tempMax = beginX + spacing * (tempMax/60/10.f);
            tempX = beginX + spacing * ([tempTime[0] longValue]/60/10.f);
        }
        float tempY = linesSpacing + tempH - 3;
        tempRect = CGRectMake(tempX, tempY, tempMax - tempMin, CGRectGetWidth(self.frame) - tempY);//linesSpacing + linesH + tempH + 6
        CGContextFillRect(context, tempRect);
    }
    

    CGContextSetStrokeColorWithColor(context,self.linesColor.CGColor);
    CGContextSetFillColorWithColor(context,  self.linesColor.CGColor);
    CGContextSetLineWidth(context, 3.0);
    if (_type == IOS_TIMESELIDERVIEW_TYPE_HOUR) {
        for (int i = 0; i <= 6 * 6; i++) {
            aPoints[0] = CGPointMake(beginX + spacing * i, linesSpacing);
            aPoints[1] = CGPointMake(beginX + spacing * i, linesSpacing + linesH);
            
            if (i % 6  == 0 || i == 0) {
                aPoints[0].y = linesSpacing  - 3;
                aPoints[1].y = linesSpacing + linesH + 6;
                
                int tempTime = (i + 1)/6 * 10;
                [[NSString stringWithFormat:@"00:%02d",tempTime] drawInRect:CGRectMake(aPoints[0].x - textW/2, self.viewHeight - tempH, textW, tempH) withFont:font];
            }
            
            CGContextAddLines(context, aPoints, 2);
            
        }
    }
    else if(_type == IOS_TIMESELIDERVIEW_TYPE_DAY){
        for (int i = 0; i <= 24 * 6; i++) {
            aPoints[0] = CGPointMake(beginX + spacing * i, linesSpacing);
            aPoints[1] = CGPointMake(beginX + spacing * i, linesSpacing + linesH);
            
            if (i % 6  == 0 || i == 0) {
                aPoints[0].y = linesSpacing - 3;
                aPoints[1].y = linesSpacing + linesH + 6;
                
                [[NSString stringWithFormat:@"%02d:00",(i + 1)/6] drawInRect:CGRectMake(aPoints[0].x - textW/2, self.viewHeight - tempH, textW, tempH) withFont:font];
                
            }
            CGContextAddLines(context, aPoints, 2);
            
            
        }
    }
    else{
        for (int i = 0; i <= 24 * 6; i++) {
            aPoints[0] = CGPointMake(beginX + spacing * i, linesSpacing);
            aPoints[1] = CGPointMake(beginX + spacing * i, linesSpacing + linesH);
            
            if (i % 6  == 0 || i == 0) {
                aPoints[0].y = linesSpacing - 3;
                aPoints[1].y = linesSpacing + linesH + 6;
                
                [[NSString stringWithFormat:@"%02d:00",(i + 1)/6] drawInRect:CGRectMake(aPoints[0].x - textW/2, self.viewHeight - tempH, textW, tempH) withFont:font];
                
            }
            CGContextAddLines(context, aPoints, 2);
            
            
        }
    }
    
    CGContextDrawPath(context, kCGPathStroke);


    self.contentWidth = beginX * 2 + aPoints[0].x;
}

- (void)setLinesColor:(UIColor *)linesColor{
    _linesColor = linesColor;
    
    [self setNeedsDisplay];
}

- (void)setType:(IOS_TIMESELIDERVIEW_TYPE)type{
    _type = type;
    [self setNeedsDisplay];
}


@end

#pragma mark -
#pragma mark -
@interface GZCZTimeMenuScrollView : UIScrollView<UIScrollViewDelegate>{
    BOOL _isMove;
}
@property(nonatomic, assign) float                      second;
@property(nonatomic, strong) UIColor                    *linesColor;
@property(nonatomic, strong) UIColor                    *middleLinesColor;
@property(nonatomic, strong) GZCZTimeView               *timeView;
@property(nonatomic, strong) UILabel                    *timeLabel;
@property(nonatomic, assign) float                      minuteSpacing;
@property(nonatomic, assign) float                      minSecond;
@property(nonatomic, assign) float                      maxSecond;
@property(nonatomic, strong) NSString                   *timeDate;
@property(nonatomic, assign) IOS_TIMESELIDERVIEW_TYPE   type;
@property(nonatomic, assign) id<TimeMenuViewDelegate>   actionDelegate;
@property(nonatomic, strong) NSMutableArray             *timeList;

- (instancetype)initWithFrame:(CGRect)frame times:(NSMutableArray *)aTimes;
@end
#pragma mark -
@implementation GZCZTimeMenuScrollView

- (instancetype)initWithFrame:(CGRect)frame times:(NSMutableArray *)aTimes{
    self = [super initWithFrame:frame];
    if (self) {
        self.timeDate = @"";
        self.timeList = aTimes;
        
        _minuteSpacing = [self timeMinuteSpacing:_type];
        
        float tempW = [self timeViewWidth:_type minuteSpacing:_minuteSpacing];
        
        _timeView = [[GZCZTimeView alloc] initWithFrame:CGRectMake(0, 0, tempW, CGRectGetHeight(frame)) viewWidth:CGRectGetWidth(frame) times:aTimes minuteSpacing:_minuteSpacing];
        _timeView.type = _type;
        [self addSubview:_timeView];
        
        self.linesColor = [UIColor whiteColor];
        _middleLinesColor = [UIColor redColor];
        self.backgroundColor = [UIColor clearColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        self.contentSize = CGSizeMake(tempW, 0);
    }
    return self;
}

- (void)setAllTimes:(NSMutableArray *)aAllTimes{
    self.timeList = aAllTimes;
    float tempW = [self timeViewWidth:_type minuteSpacing:_minuteSpacing];
    
    if (_timeView) {
        [_timeView removeFromSuperview];
        _timeView = nil;
    }
    _timeView = [[GZCZTimeView alloc] initWithFrame:CGRectMake(0, 0, tempW, CGRectGetHeight(self.frame)) viewWidth:CGRectGetWidth(self.frame) times:aAllTimes minuteSpacing:_minuteSpacing];
    _timeView.type = _type;
    self.timeView.linesColor = _linesColor;
    [self addSubview:_timeView];
}

- (void)setLinesColor:(UIColor *)linesColor{
    _linesColor = linesColor;
    self.timeView.linesColor = linesColor;
}
- (void)setMiddleLinesColor:(UIColor *)middleLinesColor{
    _middleLinesColor = middleLinesColor;
    [self setNeedsDisplay];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _isMove = YES;
}
/**/
//获取到的x不精确
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_type == IOS_TIMESELIDERVIEW_TYPE_HOUR) {
        _second = scrollView.contentOffset.x * 60 * 10 / _minuteSpacing / 6.0;
    }else{
        _second = scrollView.contentOffset.x / [self secondSpacing];
    }
    _second = _second < 0 ? 0 : _second;
    [self updateTimeLabel];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    float tempX = 0;
    if (_type == IOS_TIMESELIDERVIEW_TYPE_HOUR) {
        tempX = scrollView.contentOffset.x * 60 * 10 / _minuteSpacing / 6;
    }else{
        tempX = scrollView.contentOffset.x / [self secondSpacing];
    }
    tempX = tempX >= _maxSecond ? _maxSecond : tempX;
    tempX = tempX <= _minSecond ? _minSecond : tempX;
    
    CGPoint tempPoint;
    if (_type == IOS_TIMESELIDERVIEW_TYPE_HOUR) {
        tempPoint = CGPointMake(tempX / (60 * 10 / _minuteSpacing / 6), 0);
    }else{
        tempPoint = CGPointMake(tempX * [self secondSpacing], 0);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [scrollView setContentOffset:tempPoint animated:NO];
    });
    _second = tempX;
    _second = _second < 0 ? 0 : _second;
    _second = _second >= IOS_DAY_SECOND ? IOS_DAY_SECOND - 1 : _second;
    [self updateTimeLabel];
    if (_actionDelegate && [_actionDelegate respondsToSelector:@selector(timeSlider:second:)]) {
        [_actionDelegate timeSlider:self second:(int)_second];
    }
    [self performSelector:@selector(updateMove) withObject:nil afterDelay:2];
}

- (void)updateMove{
    _isMove = NO;
}

- (float)secondSpacing{
    //每秒的大小 = 每个格子的大小/每个格子代表的时间
    return _minuteSpacing/(60 * 10);
}

- (void)setSecond:(float)second{
    if (!_isMove) {
        _second = second;
        
        //根据时间设置当前进度定位的位置
        CGPoint tempPoint;
        if (_type == IOS_TIMESELIDERVIEW_TYPE_HOUR) {
            tempPoint = CGPointMake(_second / (60 * 10 / _minuteSpacing / 6.0), 0);
        }else{
            tempPoint = CGPointMake(_second * [self secondSpacing], 0);
        }
        if ([NSThread isMainThread]) {
            [self setContentOffset:tempPoint animated:NO];
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setContentOffset:tempPoint animated:NO];
            });
        }
        
        //更新最新的日期时间
        [self updateTimeLabel];
    }
    
}

- (void)setType:(IOS_TIMESELIDERVIEW_TYPE)type{
    _type = type;
    if (_timeView) {
        
        //更新每分钟的间距
        _minuteSpacing = [self timeMinuteSpacing:_type];
        
        //更新时间进度总宽度
        float tempW = [self timeViewWidth:_type minuteSpacing:_minuteSpacing];
        
        //重新生成时间进度视图
        if (_timeView) {
            [_timeView removeFromSuperview];
            _timeView = nil;
        }
        _timeView = [[GZCZTimeView alloc] initWithFrame:CGRectMake(0, 0, tempW, CGRectGetHeight(self.frame)) viewWidth:CGRectGetWidth(self.frame) times:self.timeList minuteSpacing:_minuteSpacing];
        _timeView.type = _type;
        self.timeView.linesColor = _linesColor;
        [self addSubview:_timeView];
        
        //更新可显示区域
        int tempSecond = _second;
        self.contentSize = CGSizeMake(tempW, 0);
        
        //根据可显示区域重新定位当前时间位置
        self.second = tempSecond;
    }
}

#pragma mark 更新最新的日期时间
- (void)updateTimeLabel{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_second == IOS_DAY_SECOND) {
            self.timeLabel.text = [NSString stringWithFormat:@"%@ %02d:%02d:%02d",@"",23,59,59];
        }else{
            int tempSecond = (int)_second % 60;
            long totalMinutes = _second / 60;
            int tempMinute = (int)(totalMinutes % 60);
            long totalHours = totalMinutes / 60;
            int tempHour = (int)(totalHours % 24);// 时
            self.timeLabel.text = [NSString stringWithFormat:@"%@ %02d:%02d:%02d",self.timeDate,tempHour,tempMinute,tempSecond];
        }
        
    });
    
}

#pragma mark 根据时间进度视图类型得到分钟间隔
- (float)timeMinuteSpacing:(int)aType{
    if (_type == IOS_TIMESELIDERVIEW_TYPE_HOUR) {
        return 15.0;
    }
    else if (_type == IOS_TIMESELIDERVIEW_TYPE_DAY_ENLARGE) {
        return 30.0;
    }
    else{
        return 15.0;
    }
}

#pragma mark 根据时间进度视图类型和分钟间隔得到时间视图总宽度
- (float)timeViewWidth:(int)aType minuteSpacing:(float)aMinuteSpacing{
    float tempW = 0;
    if (_type == IOS_TIMESELIDERVIEW_TYPE_HOUR) {
        tempW = CGRectGetWidth(self.frame) + 6 * 6 * aMinuteSpacing;
    }else{
        tempW = CGRectGetWidth(self.frame) + 6 * 24 * aMinuteSpacing;
    }
    return tempW;
}
@end

#pragma mark -
#pragma mark -
@interface UMTimeSliderView()
@property(nonatomic, strong) GZCZTimeMenuScrollView *timeMenuScrollView;
@property(nonatomic, strong) UILabel                *timeLabel;

@end
#pragma mark -
@implementation UMTimeSliderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [self initWithTime:frame times:nil];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithTime:(CGRect)frame times:(NSMutableArray *)aTimes{
    self = [super initWithFrame:frame];
    if (self) {
        //默认类型
        _type = IOS_TIMESELIDERVIEW_TYPE_DAY;
        
        _timeMenuScrollView = [[GZCZTimeMenuScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame) - 40, CGRectGetWidth(frame), 40) times:aTimes];
        _timeMenuScrollView.type = _type;
        [self addSubview:_timeMenuScrollView];
        _timeMenuScrollView.minSecond = 0;
        _timeMenuScrollView.maxSecond = IOS_DAY_SECOND;
        
        UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2 - 1.5, CGRectGetMinY(_timeMenuScrollView.frame), 2, CGRectGetHeight(_timeMenuScrollView.frame))];
        tempImageView.image = [UIImage imageNamed:@"playback_conter_line.png"];
        [self addSubview:tempImageView];
        tempImageView = nil;
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), 15)];
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont systemFontOfSize:10.f];
        [self addSubview:_timeLabel];
        
        _timeMenuScrollView.timeLabel = _timeLabel;
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTapGesture.numberOfTapsRequired = 2;
        doubleTapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:doubleTapGesture];
    }
    return self;

}
- (void)handleDoubleTap:(UIGestureRecognizer *)sender{
    if (self.type == IOS_TIMESELIDERVIEW_TYPE_DAY) {
        self.type = IOS_TIMESELIDERVIEW_TYPE_DAY_ENLARGE;
    }else if (self.type == IOS_TIMESELIDERVIEW_TYPE_DAY_ENLARGE) {
        self.type = IOS_TIMESELIDERVIEW_TYPE_DAY;
    }
    
}

- (void)setAllTimes:(NSMutableArray *)aAllTimes{
    [_timeMenuScrollView setAllTimes:aAllTimes];
}

- (void)setSecond:(float)second{
    _timeMenuScrollView.second = second;
}

- (float)second{
    return _timeMenuScrollView.second;
}

- (void)setLinesColor:(UIColor *)linesColor{
    _timeMenuScrollView.linesColor = linesColor;
    _timeLabel.textColor = linesColor;
}

- (UIColor *)linesColor{
    return _timeMenuScrollView.linesColor;
}

- (void)setMinSecond:(float)minSecond{
    _timeMenuScrollView.minSecond = minSecond;
}

- (float)minSecond{
    return _timeMenuScrollView.minSecond;
}

- (float)maxSecond{
    return _timeMenuScrollView.maxSecond;
}
- (void)setMaxSecond:(float)maxSecond{
    _timeMenuScrollView.maxSecond = maxSecond;
}

- (void)setDelegate:(id)delegate{
    _timeMenuScrollView.actionDelegate = delegate;
}

- (void)setTimeDate:(NSString *)timeDate{
    _timeDate = timeDate;
    _timeMenuScrollView.timeDate = timeDate;
}

- (void)setType:(IOS_TIMESELIDERVIEW_TYPE)type{
    _type = type;
    _timeMenuScrollView.type = type;
}
@end
