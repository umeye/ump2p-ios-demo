//
//  UMP2PVisualLivePreiviewViewController
//  UMP2PVisual
//
//  Created by Fred on 2019/3/15.
//
#import "UMP2PVisualLivePreiviewViewController.h"
#import "UMP2PVisualLivePreiviewView.h"
#import "UMP2PVisualLivePreiviewViewModel.h"
#import "UMP2PVisualClient.h"
#import "UMCamVisualFilePlayViewController.h"
#import <Masonry/Masonry.h>
#import <UMHLSVisual/UMHLSVisual.h>
@interface UMP2PVisualLivePreiviewViewController()<HKPlayerDelegate>

@property (nonatomic, strong) UMP2PVisualLivePreiviewView *mView;
@property (nonatomic, strong) UMP2PVisualLivePreiviewViewModel *viewModel;
@end
@implementation UMP2PVisualLivePreiviewViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回放" style:UIBarButtonItemStyleDone target:self action:@selector(doPlayback)];
}

/// 创建视图
- (void)createViewForConctroller{
    self.mView.apButton.hidden = YES;
    [self.view addSubview:self.mView];
    // 播放视图，添加到显示视图
    [self.mView setupTopDisplayView:[self.viewModel displayViewAtIndex:0]];
    [self.mView setupBottomDisplayView:[self.viewModel displayViewAtIndex:1]];
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
    
    self.viewModel.devs = self.devs;
    // 更新播放状态
    [RACObserve(self.viewModel, playState) subscribeNext:^(id  _Nullable x) {
        if (self.viewModel.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_STOP
            || self.viewModel.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_READY) {
            self.mView.startOrStopBtn.selected = NO;
        }else  if (self.viewModel.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING){
            
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
    for (int i = 0; i<self.devs.count && i <= self.viewModel.maxDisplayNum; i++){
        self.viewModel.displayIndex = i;
        [self.viewModel subscribeNext:^(id x) {
            
        } error:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        } api:3];
    }
}

- (void)doPlayback{
    UMCamVisualFilePlayViewController *vc = [[UMCamVisualFilePlayViewController alloc] initWithParams:@{@"dev":self.devs[0]}];
    [self.navigationController pushViewController:vc animated:YES];
}
/// 本地抓拍
- (void)capture{
    self.mView.captureBtn.selected = !self.mView.captureBtn.selected;
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
            [SVProgressHUD showSuccessWithStatus:@"录像保存成功"];
            self.mView.recordBtn.selected = NO;
            
            // 保存视频到系统相册-用于Demo测试
            UISaveVideoAtPathToSavedPhotosAlbum(x, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
            // 回放本地视频-用于Demo测试
#if 0
            UMLocalFilesHLSViewController *vc = [[UMLocalFilesHLSViewController alloc] initWithParams:@{UMParamKeyPath:[NSURL fileURLWithPath:x]}];
            [self.navigationController pushViewController:vc animated:YES];
#endif
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
    if (self.viewModel.playState != status) {
        NSLog(@"state %d",status);
    }
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

- (void)playerFeedback:(id)player status:(int)status currentTime:(long)aCurrentTime totalTime:(long)aTotalTime{
//    HKSDeviceClient *client = player;
//    NSLog(@"video fps %d", client.iVideoFps);
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
- (UMP2PVisualLivePreiviewView *)mView{
    if (!_mView) {
        _mView = [[UMP2PVisualLivePreiviewView alloc] init];
    }
    return _mView;
}

- (UMP2PVisualLivePreiviewViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[UMP2PVisualLivePreiviewViewModel alloc] init];
        [_viewModel setClientDelegate:self];
    }
    return _viewModel;
}


@end
