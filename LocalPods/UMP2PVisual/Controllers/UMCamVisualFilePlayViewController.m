//
//  UMCamVisualFilePlayViewController
//  UMP2PVisual
//
//  Created by Fred on 2019/3/15.
//
#import "UMCamVisualFilePlayViewController.h"
#import "UMCamVisualFilePlayView.h"
#import "UMCamVisualFilePlayViewModel.h"
#import "UMP2PVisualClient.h"
#import <Masonry/Masonry.h>
@interface UMCamVisualFilePlayViewController()<HKPlayerDelegate>

@property (nonatomic, strong) UMCamVisualFilePlayView *mView;
@property (nonatomic, strong) UMCamVisualFilePlayViewModel *viewModel;
@end
@implementation UMCamVisualFilePlayViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self playOrStop];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 停止播放
    [self.viewModel subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    } api:1];
}

/// 初始化数据
- (void)initialDefaultsForController{
    
}

/// 配置导航栏
- (void)configNavigationForController{
    
}

/// 创建视图
- (void)createViewForConctroller{
    [self.view addSubview:self.mView];
    // 播放视图，添加到显示视图
    [self.mView setupDisplayView:[self.viewModel displayView]];
    [self.view setNeedsUpdateConstraints];
}

/// 绑定 vm
- (void)bindViewModelForController{
    // 开始/停止
    [self.mView.startOrStopBtn addTarget:self action:@selector(playOrStop) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mView.captureBtn addTarget:self action:@selector(capture) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mView.recordBtn addTarget:self action:@selector(record) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mView.soundButton addTarget:self action:@selector(sound) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mView.talkButton addTarget:self action:@selector(talk) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mView.apButton addTarget:self action:@selector(apMode:) forControlEvents:UIControlEventTouchUpInside];

    // 更新播放状态
    [RACObserve(self.viewModel, playState) subscribeNext:^(id  _Nullable x) {
        if (self.viewModel.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_STOP
            || self.viewModel.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_READY) {
            self.mView.startOrStopBtn.selected = NO;
        }else{
            self.mView.startOrStopBtn.selected = YES;
        }
        self.mView.stateLable.text = self.viewModel.playStateDescription;
    }];
    
    //APP运行状态通知，将要被挂起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:) name:UIApplicationWillResignActiveNotification object:nil];
    // APP进入前台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterPlayground:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)updateViewConstraints{
    [self.mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [super updateViewConstraints];
}

#pragma mark -
- (void)playOrStop{
    [self.viewModel subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    } api:3];
}

/// 本地抓拍
- (void)capture{
    [self.viewModel subscribeNext:^(id x) {
        [SVProgressHUD showSuccessWithStatus:@"抓拍成功"];
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    } api:4];
}

/// 对讲
- (void)talk{
    [self.viewModel subscribeNext:^(id x) {

    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    } api:6];
}
/// 声音
- (void)sound{
    
    self.viewModel.audioEnable = !self.viewModel.audioEnable;
    self.mView.soundButton.selected = self.viewModel.audioEnable;
}
- (void)record{
    if (self.mView.recordBtn.selected) {
        // 停止录像
        [self.viewModel subscribeNext:^(id x) {
            self.mView.recordBtn.selected = NO;
            // 保存视频到系统相册
            UISaveVideoAtPathToSavedPhotosAlbum(x, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            [SVProgressHUD showSuccessWithStatus:@"录像保存成功"];
        } error:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        } api:5];
    }else{
        // 开启录像
        [self.viewModel subscribeNext:^(id x) {
            self.mView.recordBtn.selected = YES;
            [SVProgressHUD showSuccessWithStatus:@"开启录像"];
        } error:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        } api:5];
    }
    
}
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {

}
- (void)apMode:(UIButton *)button{
    button.selected = !button.selected;
    [UMUSTSDK setLocalMode:button.selected];
}
#pragma mark -
- (void)appDidEnterBackground:(NSNotification *)note{
    /// 后台停止播放
    [self.viewModel subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
            
    } api:1];
}

- (void)appDidEnterPlayground:(NSNotification *)note{
    // 前台继续播放
    [self.viewModel subscribeNext:^(id x) {
        
    } error:^(NSError *error) {
            
    } api:0];
}
#pragma mark -
#pragma mark 播放
- (void)playerFeedback:(id)player status:(int)status{
    self.viewModel.playState = status;
    if (status == HKS_NPC_D_MON_DEV_PLAY_STATUS_ERROR_NODATA) {
        // 超时无媒体数据返回，重连
    }
}

- (void)playerFeedbackConnect:(id)player{
    [SVProgressHUD um_dispalyLoadingMsgWithStatus:@"Loading"];
}

- (void)playerFeedbackError:(id)player error:(NSError *)error{
    [SVProgressHUD um_displayErrorWithStatus:[NSString stringWithFormat:@"播放失败,错误码%zi", error.code]];
}

- (void)playerFeedbackPlaying:(id)player{
    [SVProgressHUD dismiss];
}
#pragma mark 回放
- (void)playerFeedback:(id)player status:(int)status currentTime:(long)aCurrentTime totalTime:(long)aTotalTime{
    NSLog(@"aCurrentTime %lu,aTotalTime %lu", aCurrentTime, aTotalTime);
}
#pragma mark 对讲
- (void)playerTalkError:(id)player error:(NSError *)error{
    [SVProgressHUD um_displayErrorWithStatus:@"Talk failed"];
    self.mView.talkButton.selected = NO;
}

- (void)playerTalkSuccess:(id)player{
    [SVProgressHUD dismiss];
    self.mView.talkButton.selected = YES;
}

- (void)playerTalkConnect:(id)player{
    [SVProgressHUD um_dispalyLoadingMsgWithStatus:@"Loading"];
}

- (void)playerTalkStop:(id)player{
    self.mView.talkButton.selected = NO;
}

#pragma mark -
- (UMCamVisualFilePlayView *)mView{
    if (!_mView) {
        _mView = [[UMCamVisualFilePlayView alloc] init];
    }
    return _mView;
}

- (UMCamVisualFilePlayViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[UMCamVisualFilePlayViewModel alloc] initWithParams:self.params];
        [_viewModel setClientDelegate:self];
    }
    return _viewModel;
}
@end
