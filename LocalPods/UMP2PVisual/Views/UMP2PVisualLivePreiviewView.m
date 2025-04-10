//
//  UMP2PVisualLivePreiviewView
//  UMP2PVisual
//
//  Created by Fred on 2019/3/15.
//

#import "UMP2PVisualLivePreiviewView.h"
#import <UMViewUtils/UMViewUtils.h>
#import <Masonry/Masonry.h>
@implementation UMP2PVisualLivePreiviewView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViewForView];
    }
    return self;
}

- (void)createViewForView{

    [self addSubview:self.topDisplayView];
    [self addSubview:self.bottomDisplayView];
    [self addSubview:self.stateLable];
    [self addSubview:self.bottomView];
    [self addSubview:self.menuView];
    [self.bottomView addSubview:self.startOrStopBtn];
    [self.bottomView addSubview:self.captureBtn];
    [self.bottomView addSubview:self.recordBtn];
    [self.bottomView addSubview:self.talkButton];
    [self.bottomView addSubview:self.soundButton];
    [self.bottomView addSubview:self.apButton];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.topDisplayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(self.topDisplayView.mas_width).multipliedBy(0.56);
    }];
    [self.bottomDisplayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topDisplayView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.topDisplayView.mas_width).multipliedBy(0.56);
    }];
    [self.stateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomDisplayView.mas_bottom);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bottomView.mas_top);
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.stateLable.mas_bottom);
    }];
    
    NSArray *tViews = @[self.startOrStopBtn, self.captureBtn, self.recordBtn, self.talkButton , self.soundButton];
    int i = 0;
    for (UIView *view in tViews) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(70);
            make.top.mas_equalTo(0);
            make.centerX.mas_equalTo(self.bottomView.mas_right).multipliedBy(((CGFloat)i + 1) / ((CGFloat)tViews.count + 1));
        }];
        i++;
    }

//    tViews = @[self.apButton];
//    i = 0;
//    for (UIView *view in tViews) {
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(50);
//            make.width.mas_equalTo(80);
//            make.top.mas_equalTo(self.startOrStopBtn.mas_bottom);
//            make.centerX.mas_equalTo(self.bottomView.mas_right).multipliedBy(((CGFloat)i + 1) / ((CGFloat)tViews.count + 1));
//        }];
//        i++;
//    }
}


- (void)setupTopDisplayView:(UIView *)aView{
    [self.topDisplayView addSubview:aView];
    [aView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

- (void)setupBottomDisplayView:(UIView *)aView{
    [self.bottomDisplayView addSubview:aView];
    [aView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

#pragma mark -
- (UIView *)topDisplayView{
    if (!_topDisplayView) {
        _topDisplayView = [[UIView alloc] init];
        _topDisplayView.backgroundColor = [UIColor blackColor];
    }
    return _topDisplayView;
}
- (UIView *)bottomDisplayView{
    if (!_bottomDisplayView) {
        _bottomDisplayView = [[UIView alloc] init];
        _bottomDisplayView.backgroundColor = [UIColor blackColor];
    }
    return _bottomDisplayView;
}
- (UILabel *)stateLable{
    if (!_stateLable) {
        _stateLable = [[UILabel alloc] init];
        _stateLable.textColor = [UIColor blackColor];
        _stateLable.backgroundColor = [UIColor um_colorWithHexRGB:0xf5f5f5];
    }
    return _stateLable;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor um_colorWithHexRGB:0xf5f5f5];
    }
    return _bottomView;
}

- (UIView *)menuView{
    if (!_menuView) {
        _menuView = [[UIView alloc] init];
        _menuView.backgroundColor = [UIColor whiteColor];
    }
    return _menuView;
}

- (UIButton *)startOrStopBtn{
    if (!_startOrStopBtn) {
        _startOrStopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startOrStopBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_startOrStopBtn setTitle:@"停止" forState:UIControlStateSelected];
        [_startOrStopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _startOrStopBtn;
}

- (UIButton *)captureBtn{
    if (!_captureBtn) {
        _captureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_captureBtn setTitle:@"抓拍" forState:UIControlStateNormal];
        [_captureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _captureBtn;
}

- (UIButton *)recordBtn{
    if (!_recordBtn) {
        _recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recordBtn setTitle:@"录制" forState:UIControlStateNormal];
        [_recordBtn setTitle:@"录制中" forState:UIControlStateSelected];
        [_recordBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _recordBtn;
}

- (UIButton *)talkButton{
    if (!_talkButton) {
        _talkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_talkButton setTitle:@"对讲" forState:UIControlStateNormal];
        [_talkButton setTitle:@"对讲中" forState:UIControlStateSelected];
        [_talkButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _talkButton;
}

- (UIButton *)apButton{
    if (!_apButton) {
        _apButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_apButton setTitle:@"正常模式" forState:UIControlStateNormal];
        [_apButton setTitle:@"AP模式" forState:UIControlStateSelected];
        [_apButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _apButton;
}

- (UIButton *)soundButton{
    if (!_soundButton) {
        _soundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_soundButton setTitle:@"监听" forState:UIControlStateNormal];
        [_soundButton setTitle:@"关闭" forState:UIControlStateSelected];
        [_soundButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _soundButton;
}
@end
