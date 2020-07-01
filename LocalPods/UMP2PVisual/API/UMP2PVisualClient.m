//
//  UMP2PVisualClient
//  UMP2PVisual
//
//  Created by Fred on 2019/3/15.
//

#import "UMP2PVisualClient.h"

@interface ClientModel : NSObject
@property (nonatomic, strong) id    obj;
@property (nonatomic, assign) int   index;
@property (nonatomic, assign) int   type;
@property (nonatomic, assign) BOOL  isBackplay;
@end
@implementation ClientModel

@end

@interface UMP2PVisualClient()
@property (nonatomic, assign) int displayIndex;
/// 设备client数组
@property (nonatomic, strong) NSMutableArray *deviceClients;
/// 设备连接参数数组
@property (nonatomic, strong) NSMutableArray *deviceConnDatas;
/// 设备回放数据数组
@property (nonatomic, strong) NSMutableArray *deviceRecDatas;
@end
@implementation UMP2PVisualClient

- (instancetype)init{
    self = [super init];
    if (self) {
        self.displayIndex = 0;
    }
    return self;
}

#pragma mark 开始播放 实时预览/远程回放/本地Mp4文件
- (void)start:(UMDataTask)task index:(int)aIndex{
    // 播放client模型
    ClientModel *playModel = [self clientModelAtIndex:aIndex];
    // 播放连接数据模型
    ClientModel *connModel = [self deviceConnDataAtIndex:aIndex];
    // SDK播放client
    HKSDeviceClient *client = playModel.obj;
    if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING) {
        // 当前为正在播放状态，返直接回播放成功
        task(HKS_NPC_D_MPI_MON_ERROR_SUC, nil);
        return;
    }
    else if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PAUSE) {
        // 当前为暂停状态
        if (connModel.type == HKS_NPC_D_MON_CLIENT_MODE_MP4) {
            // 本地MP4播放模式下，调用本地MP4的恢复播放接口
            [client resume];
            task(HKS_NPC_D_MPI_MON_ERROR_SUC, nil);
        }else{
            // 远程回放播放模式下，调用远程回放的恢复播放接口
            [client controlRecord:HKS_NPC_D_MON_PLAY_CTRL_RESUME data:0];
            task(HKS_NPC_D_MPI_MON_ERROR_SUC, nil);
        }
        return;
    }else if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_STOP
              || client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_READY) {
        // 当前为停止或者初始状态
        // 配置连接参数，就设置到client里面，如果没有提示播放失败
        if (connModel) {
            [client setDeviceConnParam:connModel.obj type:connModel.type];
        }else {
            task(HKS_NPC_D_MPI_MON_ERROR_FAIL, nil);
            return;
        }
        // 如果为回放模式，需要设置回放数据
        if (connModel.isBackplay) {
            ClientModel *recModel = [self deviceRecDataAtIndex:aIndex];
            if (!recModel) {
                //缺少回放数据
                task(HKS_NPC_D_MPI_MON_ERROR_FAIL, nil);
                return;
            }
            HKSRecFile *recFile = (HKSRecFile *)recModel.obj;
            [client setRecFileConnParam:recFile];
            if (recFile.fileName && recFile.fileName.length > 0) {
                client.timePlayRECEnabled = NO;
            }else{
                client.timePlayRECEnabled = YES;
            }
        }
    }
    // 关闭全屏显示模式，按比例播放
    client.fullScreenEnabled = NO;
    client.delegate = self.delegate;
    // 开始播放
    [client start:NO];
    task(HKS_NPC_D_MPI_MON_ERROR_SUC, nil);
}

- (void)startOrStop:(UMDataTask)task index:(int)aIndex{
    // 播放client模型
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_STOP
        || client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_READY) {
        [self start:task index:aIndex];
    }else{
        [self stop:task index:aIndex];
    }
}

- (void)stop:(UMDataTask)task index:(int)aIndex{
    
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    [client stop:NO exit:YES];
    task(HKS_NPC_D_MPI_MON_ERROR_SUC, nil);
}

// 录像
- (void)record:(UMDataTask)task index:(int)aIndex param:(NSString *)param{
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING) {
        NSString *filePath = nil;
        if (client.recordEnabled) {
            filePath = [client stopLocalMP4REC:YES];
        }else{
            filePath = param;
            [client startRecordToPath:param];
        }
        task(HKS_NPC_D_MPI_MON_ERROR_SUC, filePath);
    }else{
        [client stopLocalMP4REC:YES];
        task(HKS_NPC_D_MPI_MON_ERROR_NO_PLAY, nil);
    }
}
// 抓拍
- (void)capture:(UMDataTask)task index:(int)aIndex param:(NSString *)param{
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING) {
        [client savePhotosToPath:param];
        task(HKS_NPC_D_MPI_MON_ERROR_SUC, nil);
    }else{
        task(HKS_NPC_D_MPI_MON_ERROR_NO_PLAY, nil);
    }
}


// 对讲
- (void)talk:(UMDataTask)task index:(int)aIndex{
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING) {
        if (client.talkState == 1){
            [client stopPPTTalk];
        }else{
            [client startTalk:-1 type:HKS_NPC_D_AUDIO_PCM];
        }
        task(HKS_NPC_D_MPI_MON_ERROR_SUC, nil);
    }else{
        task(HKS_NPC_D_MPI_MON_ERROR_NO_PLAY, nil);
    }
}

- (void)talk:(UMDataTask)task index:(int)aIndex state:(BOOL)state{
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING) {
        if (state && client.talkState == 0){
            [client startTalk:-1 type:HKS_NPC_D_AUDIO_PCM];
        }else if(!state){
            [client stopPPTTalk];
        }
        task(HKS_NPC_D_MPI_MON_ERROR_SUC, nil);
    }else{
        task(HKS_NPC_D_MPI_MON_ERROR_NO_PLAY, nil);
    }
}


- (void)ptz:(UMDataTask)task
        cmd:(int)aCmd
      index:(int)aIndex {
    [self ptz:task cmd:aCmd param:5 index:aIndex];
}
- (void)ptz:(UMDataTask)task cmd:(int)aCmd param:(int)param index:(int)aIndex{
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING) {
        
        [client ptzControlWithCmd:aCmd data:param];
        task(HKS_NPC_D_MPI_MON_ERROR_SUC, nil);
    }else{
        task(HKS_NPC_D_MPI_MON_ERROR_NO_PLAY, nil);
    }
}

+ (void)deviceInfo:(TreeListItem *)devInfo
           handler:(void (^)(id data, int iError))completionHandler{
    HKSDeviceClient *tClient = [[HKSDeviceClient alloc] init];
    [tClient setDeviceConnParam:devInfo];
    HKSDeviceInfoItem *model = [[HKSDeviceInfoItem alloc] init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int errorCode = [tClient deviceInfo:model];
        dispatch_async(dispatch_get_main_queue(), ^{
            [tClient stop:YES];
            if (errorCode == HKS_NPC_D_MPI_MON_ERROR_SUC) {
                completionHandler(model, errorCode);
            }else{
                completionHandler(nil, errorCode);
            }
        });
    });
}

- (void)customFuncJson:(UMDataTask)task
               devInfo:(TreeListItem *)devInfo msgId:(int)msgId param:(NSMutableDictionary *)param index:(int)aIndex {
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    // 播放连接数据模型
    ClientModel *connModel = [self deviceConnDataAtIndex:aIndex];
    if (devInfo) {
        [client setDeviceConnParam:devInfo];
    }else if(connModel){
        [client setDeviceConnParam:connModel.obj];
    }
    [client customFuncJson:msgId param:param autoStop:NO handler:^(id data, int errorCode) {
        if (errorCode == HKS_NPC_D_MPI_MON_ERROR_SUC){
            
        }else{
            
        }
        task(errorCode, data);
    }];
    client.hCallbackEx = ^(int iMsgId, void *target, char *in_pDataBuf, id data, int in_iDataLen){
        NSLog(@"iMsgId %d, %d, %@", iMsgId, in_iDataLen, data);
    };
}

#pragma mark - 设备搜索
static BOOL _isDeviceSearching = NO;
+ (void)startSearch:(void (^)(id data, BOOL isUpdate, NSError *error))completionHandler{
    NSLog(@"开始进行局域网设备发现.");
    [HKSDeviceClient startSearchDevice];
    _isDeviceSearching = YES;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *localDevices = nil;
        while (_isDeviceSearching) {
            NSMutableArray *tempLocalDevices = [NSMutableArray array];
            [HKSDeviceClient getSearchDevTable:tempLocalDevices];
            // 没有发现设备，重新进行下次提取
            if (tempLocalDevices.count == 0) {
                NSLog(@"没有发现到任何设备.");
                dispatch_async(dispatch_get_main_queue(), ^{
                   completionHandler(tempLocalDevices, NO, nil);
                });
                [NSThread sleepForTimeInterval:0.5];
                continue;
            }
            // 跟上次搜索到的数量一致，重新进行下次提取
            if (tempLocalDevices.count == localDevices.count) {
                NSLog(@"没有发现新设备.上次发现设备数:%zi", tempLocalDevices.count);
                
                dispatch_async(dispatch_get_main_queue(), ^{
                   completionHandler(tempLocalDevices, NO, nil);
                });
                [NSThread sleepForTimeInterval:0.5];
                continue;
            }
            NSLog(@"发现设备数:%zi", tempLocalDevices.count);
            localDevices = tempLocalDevices;
            dispatch_async(dispatch_get_main_queue(), ^{
               completionHandler(tempLocalDevices, YES, nil);
            });
        }
    });
}
+ (void)stopSearch{
    _isDeviceSearching = NO;
    [HKSDeviceClient stopSearchDevice];
    NSLog(@"停止进行局域网设备发现.");
}


- (void)customFuncJson:(int)aIndex
                 msgId:(int)msgId
                 param:(NSDictionary *)param
               handler:(void (^)(id data, int iError))completionHandler{
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    [client customFuncJson:msgId param:param autoStop:NO handler:^(id data, int errorCode) {
        if (errorCode == HKS_NPC_D_MPI_MON_ERROR_SUC) {
            completionHandler(data, nil);
        }else{
            completionHandler(nil, errorCode);
        }
    }];
}

#pragma mark - Get/Set
#pragma mark 根据索引获取播放句柄
- (HKSDeviceClient *)deviceClientAtIndex:(int)aIndex{
    ClientModel *model = [self clientModelAtIndex:aIndex];
    return model.obj;
}

- (void)setClientAudioEnabled:(BOOL)enabled index:(int)aIndex{
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    client.audioEnabled = enabled;
}

- (UIView *)displayView{
    return [self displayViewAtIndex:self.displayIndex];
}
- (UIView *)displayViewAtIndex:(int)aIndex{
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    return client.view;
}

- (int)playStateAtIndex:(int)aIndex{
    HKSDeviceClient *client = [self deviceClientAtIndex:aIndex];
    return client.playerState;
}

#pragma mark 根据索引获取当前句柄所需连接参数数据
- (ClientModel *)deviceConnDataAtIndex:(int)aIndex{
    for (ClientModel *aModel in self.deviceConnDatas) {
        if (aModel.index == aIndex) {
            return aModel;
        }
    }
    return nil;
}

#pragma mark 根据索引获取当前句柄所需回放数据
- (ClientModel *)deviceRecDataAtIndex:(int)aIndex{
    for (ClientModel *aModel in self.deviceRecDatas) {
        if (aModel.index == aIndex) {
            return aModel;
        }
    }
    return nil;
}

#pragma mark 根据索引获取当前句柄所需连接参数Model
- (ClientModel *)clientModelAtIndex:(int)aIndex{
    for (ClientModel *aModel in self.deviceClients) {
        if (aModel.index == aIndex) {
            return aModel;
        }
    }
    ClientModel *model = [[ClientModel alloc] init];
    model.index = aIndex;
    model.obj = [[HKSDeviceClient alloc] init];
    [self.deviceClients addObject:model];
    return model;
}

#pragma mark 设置播放数据-实时预览
- (void)setupDeviceConnData:(TreeListItem *)aItem{
    [self setupDeviceConnData:aItem aIndex:self.displayIndex];
}
- (void)setupDeviceConnData:(TreeListItem *)aItem aIndex:(int)aIndex{
    ClientModel *model = nil;
    for (ClientModel *aModel in self.deviceConnDatas) {
        if (aModel.index == aIndex) {
            model = aModel;
            break;
        }
    }
    if (!model) {
        model = [[ClientModel alloc] init];
        model.index = aIndex;
        [self.deviceConnDatas addObject:model];
    }
    model.obj = aItem;
    model.type = HKS_NPC_D_MON_CLIENT_MODE_LOCALUMID;
    model.isBackplay = NO;
}

#pragma mark 设置播放数据-远程回放
- (void)setupDeviceRecData:(HKSRecFile *)aItem{
    [self setupDeviceRecData:aItem aIndex:self.displayIndex];
}
- (void)setupDeviceRecData:(HKSRecFile *)aItem aIndex:(int)aIndex{
    for (ClientModel *aModel in self.deviceRecDatas) {
        if (aModel.index == aIndex) {
            aModel.obj = aItem;
            return;
        }
    }
    ClientModel *model = [[ClientModel alloc] init];
    model.index = aIndex;
    model.obj = aItem;
    model.type = HKS_NPC_D_MON_CLIENT_MODE_LOCALUMID;
    [self.deviceRecDatas addObject:model];
    
    // 设置了回放数据，则当作该client为回放模式
    ClientModel *connModel = [self deviceConnDataAtIndex:aIndex];
    if (connModel) {
        connModel.isBackplay = YES;
    }
}

#pragma mark 设置播放数据-本地MP4文件
- (void)setupDeviceConnDataAtURL:(NSString *)param{
    [self setupDeviceConnDataAtURL:param aIndex:self.displayIndex];
}
- (void)setupDeviceConnDataAtURL:(NSString *)param aIndex:(int)aIndex{
    for (ClientModel *aModel in self.deviceConnDatas) {
        if (aModel.index == aIndex) {
            TreeListItem *item = aModel.obj;
            item.sDevId = param;
            return;
        }
    }
    ClientModel *model = [[ClientModel alloc] init];
    model.index = aIndex;
    TreeListItem *item = [[TreeListItem alloc] init];
    item.sDevId = param;
    model.obj = item;
    model.type = HKS_NPC_D_MON_CLIENT_MODE_MP4;
    [self.deviceConnDatas addObject:model];
}

#pragma mark 设备播放句柄列表
- (NSMutableArray *)deviceClients{
    if (!_deviceClients) {
        _deviceClients = [[NSMutableArray alloc] init];
    }
    return _deviceClients;
}
#pragma mark 设备连接数据列表
- (NSMutableArray *)deviceConnDatas{
    if (!_deviceConnDatas) {
        _deviceConnDatas = [[NSMutableArray alloc] init];
    }
    return _deviceConnDatas;
}

- (NSMutableArray *)deviceRecDatas{
    if (!_deviceRecDatas) {
        _deviceRecDatas = [[NSMutableArray alloc] init];
    }
    return _deviceRecDatas;
}

@end
