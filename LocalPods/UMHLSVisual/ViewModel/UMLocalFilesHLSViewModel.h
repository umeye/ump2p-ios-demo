//
//  UMLocalFilesHLSViewModel.h
//  UMLocalFile
//
//  Created by fred on 2020/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UMLocalFilesHLSViewModel : NSObject
@property (nonatomic, assign) NSInteger currentTime;
@property (nonatomic, assign) NSInteger totalTime;
@property (nonatomic, assign) NSInteger totalBuffer;

@property (nonatomic, assign) BOOL seeking;
/// 播放句柄
@property (nonatomic, strong) UMHLSClient *hlsClient;
/// 文件类型
@property (nonatomic, assign) UMHLSType type;
@end

NS_ASSUME_NONNULL_END
