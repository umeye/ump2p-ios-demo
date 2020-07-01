//
//  UMLocalFilePlayView.h
//  UMLocalFile
//
//  Created by fred on 2020/2/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UMLocalFilesHLSView : UIView<UMViewProtocol>
/// 中间播放按钮
@property (nonatomic, strong) UIButton *playButton;
/// 开始 暂停
@property (nonatomic, strong) UIButton *playOrPauseButton;
/// 进度条
@property (nonatomic, strong) UISlider *slider;
/// 当前时间
@property (nonatomic, strong) UILabel *curLabel;
/// 总时间
@property (nonatomic, strong) UILabel *totalLabel;
@end

NS_ASSUME_NONNULL_END
