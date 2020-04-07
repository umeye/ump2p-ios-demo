//
//  UMP2PVisualLivePreiviewView
//  UMP2PVisual
//
//  Created by Fred on 2019/3/15.
//

#import <Foundation/Foundation.h>


@interface UMP2PVisualLivePreiviewView : UIView
/// 视频播放视图
@property (nonatomic, strong) UIView *displayView;
/// 播放状态Label
@property (nonatomic, strong) UILabel *stateLable;
/// 菜单视图
@property (nonatomic, strong) UIView *menuView;
/// 底部菜单视图
@property (nonatomic, strong) UIView *bottomView;
/// 开始或者停止播放按钮
@property (nonatomic, strong) UIButton *startOrStopBtn;
/// 本地抓拍按钮
@property (nonatomic, strong) UIButton *captureBtn;
/// 本地录制按钮
@property (nonatomic, strong) UIButton *recordBtn;
/// 对讲
@property (nonatomic, strong) UIButton *talkButton;
/// 监听
@property (nonatomic, strong) UIButton *soundButton;

- (void)setupDisplayView:(UIView *)aView;

@end
