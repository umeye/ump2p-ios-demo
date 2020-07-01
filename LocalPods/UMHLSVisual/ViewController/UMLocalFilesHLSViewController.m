//
//  UMLocalFilesHLSViewController.m
//  UMLocalFile
//
//  Created by fred on 2020/2/22.
//

#import "UMLocalFilesHLSViewController.h"
#import "UMLocalFilesHLSView.h"
#import "UMLocalFilesHLSViewModel.h"
@interface UMLocalFilesHLSViewController ()<UMHLSClientDelegate>
@property (nonatomic, strong) UMLocalFilesHLSView *mView;
@property (nonatomic, strong) UMLocalFilesHLSViewModel *viewModel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation UMLocalFilesHLSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [UMLogClient addTag:UMHLSVisualLogTag];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self play];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self stop];
    
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (void)configNavigationForController{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setImage:UMLocalFileTemplateImage(@"umhlsvisual_snap") forState:UIControlStateNormal];
    [button setTintColor:[UIColor blackColor]];
    [button setImageEdgeSpaing:10];
    [button addTarget:self action:@selector(snap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)createViewForConctroller{
    self.navigationItem.titleView = self.titleLabel;
    [self updateTitle];
    [self.view addSubview:self.mView];
    [self.view setNeedsUpdateConstraints];
}


- (void)updateViewConstraints{
    [self.mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    [super updateViewConstraints];
}
#pragma mark - 控件事件
- (void)bindViewModelForController{
    
    [self.mView bindViewModel:self.viewModel withParams:nil];
    // 底部播放or暂停按钮
    [self.mView.playOrPauseButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    // 中间播放按钮
    [self.mView.playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    // 进度条
    [self.mView.slider addTarget:self action:@selector(seekTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.mView.slider addTarget:self action:@selector(seekTouchTouchUp:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel];
    
    UITapGestureRecognizer *tapViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doEventTapView:)];
    [self.mView addGestureRecognizer:tapViewGesture];
}

- (void)doEventTapView:(UITapGestureRecognizer *)gesture{
    if (self.viewModel.type == UMHLSTypeLive) {
        self.mView.playButton.hidden = !self.mView.playButton.hidden;
    }
}

- (void)snap{
    if (self.viewModel.hlsClient.status != UMHLSClientStatusPlaying) {
        NSLog(@"snap fail, state %zi", self.viewModel.hlsClient.status);
        return;
    }
    UIImage *img = [self.viewModel.hlsClient snapshotImage];
    if (!img) {
        return;
    }
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = documentPaths.firstObject;
    path = [path stringByAppendingPathComponent:@"MediaFile"];
    path = [path stringByAppendingPathComponent:@"Photos"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *name = [NSString stringWithFormat:@"%@.png", [dateFormatter stringFromDate:[NSDate date]]];
    path = [path stringByAppendingPathComponent:name];
    NSLog(@"path %@", path);
    BOOL result = [UIImagePNGRepresentation(img) writeToFile:path atomically:YES];
    if (result == YES) {
        [SVProgressHUD um_displaySuccessWithStatus:NSLocalizedString(@"Saved to photo album", @"")];
    }
}
- (void)play{
    if (self.viewModel.hlsClient.status == UMHLSClientStatusPlaying) {
        UMHLSVisualLog(@"启动暂停");
        [self.viewModel.hlsClient pause];
    }else{
        UMHLSVisualLog(@"启动播放");
        [self.viewModel.hlsClient play];
    }
}

- (void)stop{

    [self.viewModel.hlsClient stop];
    self.mView.playOrPauseButton.selected = NO;
    self.mView.playButton.selected = NO;
}

- (void)seekTouchDown:(UISlider *)slider{
    // 开始拖动进度条，设置为拖动中状态，不进行进度同步
    self.viewModel.seeking = YES;
}
- (void)seekTouchTouchUp:(UISlider *)slider{
    // 发起seek请求
    self.viewModel.seeking = NO;
    [self.viewModel.hlsClient seekToTime:slider.value completionHandler:^(BOOL finished){
        // seek回调结果通知
        
    }];
}


/// 更新标题
- (void)updateTitle{
    NSString *dateTime = self.params[UMLocalFileParamKeyDateTime];
    if (!dateTime) {
        return;
    }
    NSArray *date = [dateTime componentsSeparatedByString:@" "];
    NSString *subTitle = date.lastObject;
    NSString *title = date.firstObject;
     NSString *str = [NSString stringWithFormat:@"%@\n%@",title, subTitle];
     NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
     [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:title]];
     [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:subTitle]];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.attributedText = attrStr;
}

#pragma mark - UMHLS Delegate
- (void)umHLSTime:(id)client currentTime:(NSInteger)currentTime totalBuffer:(NSInteger)totalBuffer totalTime:(NSInteger)totalTime{
//    UMHLSVisualLog(@"current time %zi,buffer time %zi,total time %zi",  currentTime, totalBuffer, totalTime);
    if (self.viewModel.seeking) {
        return;
    }
    self.viewModel.currentTime = currentTime;
    self.viewModel.totalBuffer = totalBuffer;
    self.viewModel.totalTime = totalTime;
    self.mView.slider.maximumValue = totalTime;
    self.mView.slider.minimumValue = 0;
    self.mView.slider.value = currentTime;
}
- (void)umHLSStatus:(id)client status:(UMHLSClientStatus)status error:(NSError *)error{
    UMHLSVisualLog(@"status %zi", status);
    if (status == UMHLSClientStatusPlaying) {
        self.mView.playOrPauseButton.selected = YES;
        self.mView.playButton.selected = YES;
    }else if (status == UMHLSClientStatusEnd) {
//        [self.navigationController popViewControllerAnimated:YES];
        self.mView.playOrPauseButton.selected = NO;
        self.mView.playButton.selected = NO;
    }else{
        self.mView.playOrPauseButton.selected = NO;
        self.mView.playButton.selected = NO;
    }
    if (error) {
        UMHLSVisualLog(@"error %@", error.localizedDescription);
    }
}
#pragma mark -
- (UIModalPresentationStyle)modalPresentationStyle{
    return UIModalPresentationFullScreen;
}
#pragma mark -
- (UMLocalFilesHLSView *)mView{
    if (!_mView) {
        _mView = [[UMLocalFilesHLSView alloc] initWithFrame:self.view.bounds];
    }
    return _mView;
}

- (UMLocalFilesHLSViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[UMLocalFilesHLSViewModel alloc] initWithParams:self.params];
        _viewModel.hlsClient.delegate = self;
    }
    return _viewModel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 55)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
