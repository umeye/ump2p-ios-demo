//
//  UMCamVisualFilePlayViewModel
//  UMP2PVisual
//
//  Created by Fred on 2019/3/15.
//

#import <Foundation/Foundation.h>
#import <UMViewUtils/UMViewUtils.h>
#import <UMP2P/CloudSDK.h>

@interface UMCamVisualFilePlayViewModel : NSObject<UMViewModelProtocol>
@property (nonatomic, strong) TreeListItem *devItem;
@property (nonatomic, assign) int displayIndex;
/// 播放状态
@property (nonatomic, assign) int playState;

@property (nonatomic, assign) int audioEnable;

@property (nonatomic, copy) NSString *playStateDescription;

@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

/// 根据画面索引获取播放视图
- (UIView *)displayView;

/// 设置播放连接参数数据
- (void)setupDeviceConnData:(TreeListItem *)aItem;

- (void)setClientDelegate:(id)delegate;



@end
