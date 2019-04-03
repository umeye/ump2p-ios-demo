//
//  UMProgressView.m
//
//  Created by fred on 2019/2/20.
//

#import "UMProgressView.h"
#import <Masonry/Masonry.h>

@interface UMProgressView ()
@property (nonatomic, strong) UILabel *cLabel;
@end


@implementation UMProgressView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        //默认颜色
        self.progerssBackgroundColor=[UIColor lightGrayColor];
        self.progerssColor=[UIColor blueColor];
        self.percentFontColor=[UIColor blueColor];
        //默认进度条宽度
        self.progerWidth = 10;
        //默认百分比字体大小
        self.percentageFontSize = 35;
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    self.cLabel.text = [NSString stringWithFormat:@"%0.0f%%", progress * 100];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    
    //路径
    UIBezierPath *backgroundPath = [[UIBezierPath alloc] init];
    //线宽
    backgroundPath.lineWidth = self.progerWidth;
    //颜色
    [self.progerssBackgroundColor set];
    //拐角
    backgroundPath.lineCapStyle = kCGLineCapRound;
    backgroundPath.lineJoinStyle = kCGLineJoinRound;
    //半径
    CGFloat radius = (MIN(rect.size.width, rect.size.height) - self.progerWidth) * 0.5;
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [backgroundPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2  clockwise:YES];
    //连线
    [backgroundPath stroke];
    
    
    //路径
    UIBezierPath *progressPath = [[UIBezierPath alloc] init];
    //线宽
    progressPath.lineWidth = self.progerWidth;
    //颜色
    [self.progerssColor set];
    //拐角
    progressPath.lineCapStyle = kCGLineCapRound;
    progressPath.lineJoinStyle = kCGLineJoinRound;
    
    //画弧（参数：中心、半径、起始角度(3点钟方向为0)、结束角度、是否顺时针）
    [progressPath addArcWithCenter:(CGPoint){rect.size.width * 0.5, rect.size.height * 0.5} radius:radius startAngle:M_PI * 1.5 endAngle:M_PI * 1.5 + M_PI * 2 * _progress clockwise:YES];
    //连线
    [progressPath stroke];
    
    self.cLabel.center = CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5);
    [self addSubview:self.cLabel];
}


- (UILabel *)cLabel{
    if (!_cLabel) {
        _cLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        _cLabel.textAlignment = NSTextAlignmentCenter;
    }
    _cLabel.textColor = self.percentFontColor;
    _cLabel.font = [UIFont boldSystemFontOfSize:self.percentageFontSize];
    return _cLabel;
}
@end
