//
//  UMP2PVisualLivePreiviewViewModel
//  UMP2PVisual
//
//  Created by Fred on 2019/3/15.
//

#import "UMP2PVisualLivePreiviewViewModel.h"
#import "UMP2PVisualClient.h"

@interface UMP2PVisualLivePreiviewViewModel()
@property (nonatomic, strong) UMP2PVisualClient *client;

@end

@implementation UMP2PVisualLivePreiviewViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.displayIndex = 0;
        self.playState = HKS_NPC_D_MON_DEV_PLAY_STATUS_READY;
    }
    return self;
}

- (void)subscribeNext:(void (^)(id))nextBlock error:(void (^)(NSError *))errorBlock{
    [self subscribeNext:nextBlock error:errorBlock api:0 param:nil];
}

- (void)subscribeNext:(void (^)(id))nextBlock error:(void (^)(NSError *))errorBlock api:(int)api{
    [self subscribeNext:nextBlock error:errorBlock api:api param:nil];
}

- (void)subscribeNext:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock api:(int)api param:(NSDictionary *)param{
    if (api == 0) {
        [self start:nextBlock error:errorBlock];
    }
    else if (api == 1) {
        [self stop:nextBlock error:errorBlock];
    }
    else if (api == 3) {
        [self startOrStop:nextBlock error:errorBlock];
    }
    else if (api == 4) {
        [self capture:nextBlock error:errorBlock];
    }
    else if (api == 5) {
        [self record:nextBlock error:errorBlock];
    }else if (api == 6) {
        [self talk:nextBlock error:errorBlock];
    }else{
        NSString *sError = [NSString stringWithFormat:@"请求错误，该功能ID不支持[%d]", api];
        NSError *err = [NSError errorWithDomain:@"" code:1 userInfo:@{NSLocalizedDescriptionKey : sError}];
        errorBlock(err);
    }
}

- (void)startOrStop:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{

    [self.client startOrStop:^(int iError, id aParam) {
        if (iError == HKS_NPC_D_MPI_MON_ERROR_SUC) {
            nextBlock(@{});
        }else{
            NSString *sError = [NSString stringWithFormat:@"请求错误，错误码[%d]", iError];
            NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
            errorBlock(err);
        }
    } index:self.displayIndex];
}

- (void)start:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    [self.client start:^(int iError, id aParam) {
        if (iError == HKS_NPC_D_MPI_MON_ERROR_SUC) {
            nextBlock(@{});
        }else{
            NSString *sError = [NSString stringWithFormat:@"请求播放错误，错误码[%d]", iError];
            NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
            errorBlock(err);
        }
    } index:self.displayIndex];
}

- (void)capture:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    NSString *documentDirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [documentDirPath stringByAppendingPathComponent:@"file"];
    [self.client capture:^(int iError, id aParam) {
        if (iError == HKS_NPC_D_MPI_MON_ERROR_SUC) {
            nextBlock(@{});
        }else{
            NSString *sError = [NSString stringWithFormat:@"请求播放错误，错误码[%d]", iError];
            NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
            errorBlock(err);
        }
    } index:self.displayIndex param:path];
    
}
- (void)record:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    NSString *documentDirPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [documentDirPath stringByAppendingPathComponent:@"file"];
    [self.client record:^(int iError, id aParam) {
        if (iError == HKS_NPC_D_MPI_MON_ERROR_SUC) {
            nextBlock(@{});
        }else{
            NSString *sError = [NSString stringWithFormat:@"请求播放错误，错误码[%d]", iError];
            NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
            errorBlock(err);
        }
    } index:self.displayIndex param:path];
}

- (void)stop:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    
    [self.client stop:^(int iError, id aParam) {
        if (iError == HKS_NPC_D_MPI_MON_ERROR_SUC) {
            nextBlock(@{});
            self.playState = HKS_NPC_D_MON_DEV_PLAY_STATUS_STOP;
        }else{
            NSString *sError = [NSString stringWithFormat:@"请求停止错误，错误码[%d]", iError];
            NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
            errorBlock(err);
        }
    } index:self.displayIndex];
}

- (void)talk:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    
    [self.client talk:^(int iError, id aParam) {
        if (iError == HKS_NPC_D_MPI_MON_ERROR_SUC) {
            nextBlock(@{});
            return;
        }
        NSString *sError = [NSString stringWithFormat:@"请求停止错误，错误码[%d]", iError];
        NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
        errorBlock(err);
    } index:self.displayIndex];
}

- (void)setAudioEnable:(int)audioEnable{
    _audioEnable = audioEnable;
    [self.client setClientAudioEnabled:audioEnable index:self.displayIndex];
}
#pragma mark -
- (UMP2PVisualClient *)client{
    if (!_client) {
        _client = [[UMP2PVisualClient alloc] init];
    }
    return _client;
}

- (void)setupDeviceConnData:(id)aItem{
    [self.client setupDeviceConnData:aItem aIndex:self.displayIndex];
}

- (void)setClientDelegate:(id)delegate{
    self.client.delegate = delegate;
}

- (UIView *)displayView{
    return [self displayViewAtIndex:self.displayIndex];
}
- (UIView *)displayViewAtIndex:(int)aIndex{
    return [self.client displayViewAtIndex:aIndex];
}

- (NSString *)playStateDescription{
    if (self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_CONNECT_FAIL) {
        return UMLocalized(@"Fail to connect");
    }
    if (self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_MAXCONN) {
        return UMLocalized(@"Exceed the maximum number of connections");
    }
    if (self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_PASSWORD
        || self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_USER) {
        return UMLocalized(@"Login invalid user or invalid password");
    }
    if (self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_TIMEOUT
        || self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_ERROR_NETWORK) {
        return UMLocalized(@"Connection timed out");
    }
    if (self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_ERROR_NODATA) {
        return UMLocalized(@"No response");
    }
    if (self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_READY) {
        return @"";
    }
    if (self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_CONNECT_SUCESS) {
        return UMLocalized(@"Connect sucess");
    }
    if (self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING) {
        return UMLocalized(@"Playing");
    }
    if (self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_STOP) {
        return UMLocalized(@"Stopped");
    }
    if (self.playState == HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_OFFLINE) {
        return UMLocalized(@"Device offline");
    }
    
    return UMLocalized(@"");
}


@end
