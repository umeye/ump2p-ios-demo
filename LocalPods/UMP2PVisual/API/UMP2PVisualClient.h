//
//  UMP2PVisualClient
//  UMP2PVisual
//
//  Created by Fred on 2019/3/15.
//

#import <UMP2P/CloudSDK.h>

/// 错误Code码
typedef NS_ENUM(NSUInteger, UMP2PVisualClientCmd){
    /// 预览
    UMP2PVisualClientCmdPreview = 0,
    /// 停止
    UMP2PVisualClientCmdPreviewStop,
    /// 回放
    UMP2PVisualClientCmdBackplay,
};

typedef void (^UMDataTask)(int iError, id aParam);

/// 播放Client
@interface UMP2PVisualClient : NSObject

/// 设置播放连接参数数据
- (void)setupDeviceConnData:(TreeListItem *)aItem aIndex:(int)aIndex;
- (void)setupDeviceConnData:(TreeListItem *)aItem;

/// 设置回放数据
- (void)setupDeviceRecData:(HKSRecFile *)aItem aIndex:(int)aIndex;
- (void)setupDeviceRecData:(HKSRecFile *)aItem;

/// 设置本地MP4播放数据
- (void)setupDeviceConnDataAtURL:(NSString *)param aIndex:(int)aIndex;
- (void)setupDeviceConnDataAtURL:(NSString *)param;

/// 根据画面索引获取播放视图
- (UIView *)displayViewAtIndex:(int)aIndex;
- (UIView *)displayView;

/// 播放状态
- (int)playStateAtIndex:(int)aIndex;

/// 开始/恢复 播放
- (void)start:(UMDataTask)task index:(int)aIndex;
/// 停止播放
- (void)stop:(UMDataTask)task index:(int)aIndex;
/// 开始播放或者停止播放
- (void)startOrStop:(UMDataTask)task index:(int)aIndex;
/// 抓拍
- (void)capture:(UMDataTask)task index:(int)aIndex param:(NSString *)param;
/// 录像
- (void)record:(UMDataTask)task index:(int)aIndex param:(NSString *)param;

@end
