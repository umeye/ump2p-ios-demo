//
//  UMLocalFilePlayView.m
//  UMLocalFile
//
//  Created by fred on 2020/2/22.
//

#import "UMLocalFilesHLSView.h"
#import "UMLocalFilesHLSViewModel.h"
#define kButtonSpacing  8

@interface UMLocalFilesHLSView()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UILabel *liveLabel;
@end
@implementation UMLocalFilesHLSView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViewForView];
    }
    return self;
}

- (void)createViewForView{
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:self.playButton];
    [self addSubview:self.liveLabel];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.playOrPauseButton];
    [self.bottomView addSubview:self.curLabel];
    [self.bottomView addSubview:self.totalLabel];
    [self.bottomView addSubview:self.slider];
}

- (void)updateConstraints{
    [self.liveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 40));
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(20);
    }];
    [self.playButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(90, 90));
        make.center.mas_equalTo(self);
    }];
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(80);
    }];
    [self.playOrPauseButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(self.bottomView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    [self.curLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.playOrPauseButton.mas_right).offset(5);
        make.centerY.mas_equalTo(self.bottomView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    [self.totalLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.right.mas_equalTo(-5);
    }];
    [self.slider mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.curLabel.mas_right).offset(5);
        make.right.mas_equalTo(self.totalLabel.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.bottomView);
    }];
    [super updateConstraints];
}
#pragma mark - 绑定ViewModel
- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params{
    UMLocalFilesHLSViewModel *_viewModel = (UMLocalFilesHLSViewModel *)viewModel;
    // 关联播放视图
    [self addSubview:_viewModel.hlsClient.view];
    [self sendSubviewToBack:_viewModel.hlsClient.view];
    [_viewModel.hlsClient.view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    // 直播类型隐藏底部菜单
    self.bottomView.hidden = _viewModel.type == UMHLSTypeLive;
    // 监听播放的位置
    [RACObserve(_viewModel, currentTime) subscribeNext:^(id  _Nullable x) {
        self.curLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _viewModel.currentTime/60, _viewModel.currentTime % 60];
    }];
    // 监听播放的总时长
    [RACObserve(_viewModel, totalTime) subscribeNext:^(id  _Nullable x) {
        self.totalLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", _viewModel.totalTime/60, _viewModel.totalTime % 60];
    }];
}

#pragma mark - Get/Set
- (UIButton *)playOrPauseButton{
    if (!_playOrPauseButton) {
        _playOrPauseButton = [[UIButton alloc] init];
        [_playOrPauseButton setImage:UMLocalFileImage(@"umhlsvisual_play") forState:UIControlStateNormal];
        [_playOrPauseButton setImage:UMLocalFileImage(@"umhlsvisual_pause") forState:UIControlStateSelected];
        [_playOrPauseButton setImageEdgeSpaing:kButtonSpacing];
    }
    return _playOrPauseButton;
}
- (UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc] init];
        _slider.maximumTrackTintColor = [UIColor lightGrayColor];
    }
    return _slider;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
    }
    return _bottomView;
}

- (UILabel *)curLabel{
    if (!_curLabel) {
        _curLabel = [[UILabel alloc] init];
        _curLabel.backgroundColor = [UIColor clearColor];
        _curLabel.textColor = [UIColor whiteColor];
        _curLabel.text = @"00:00";
    }
    return _curLabel;
}

- (UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.backgroundColor = [UIColor clearColor];
        _totalLabel.textColor = [UIColor whiteColor];
        _totalLabel.text = @"00:00";
    }
    return _totalLabel;
}

- (UIButton *)playButton{
    if (!_playButton) {
        _playButton = [[UIButton alloc] init];
        [_playButton setBackgroundImage:UMLocalFileImage(@"umhlsvisual_play_c") forState:UIControlStateNormal];
        [_playButton setBackgroundImage:UMLocalFileImage(@"umhlsvisual_play_c_h") forState:UIControlStateSelected];
        _playButton.hidden = YES;
    }
    return _playButton;
}

- (UILabel *)liveLabel{
    if (!_liveLabel) {
        _liveLabel = [[UILabel alloc] init];
        NSString *str = @"";
        NSArray *date = [str componentsSeparatedByString:@" "];
        NSString *subTitle = date.lastObject;
        NSString *title = date.firstObject;
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:16]} range:[str rangeOfString:title]];
        [attrStr addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:16]} range:[str rangeOfString:subTitle]];
        _liveLabel.attributedText = attrStr;
        _liveLabel.layer.masksToBounds = YES;
        _liveLabel.layer.cornerRadius = 5.;
        _liveLabel.hidden = YES;
        _liveLabel.textAlignment = NSTextAlignmentCenter;
//        _liveLabel.backgroundColor = [UIColor um_colorWithHexRGB:0x000000 alpha:0.5];
    }
    return _liveLabel;
}

@end
