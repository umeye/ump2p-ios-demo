//
//  UMP2PLifeDevicesViewModel.m
//  UMP2PLife
//
//  Created by fred on 2019/4/2.
//

#import "UMP2PLifeDevicesViewModel.h"
@interface UMP2PLifeDevicesViewModel()
@property (nonatomic, strong) NSMutableArray *devices;
@end
@implementation UMP2PLifeDevicesViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.sParentNodeId = @"0";
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
        [self devices:nextBlock error:errorBlock];
    }else if (api == 1) {
        [self refreshSessionID:nextBlock error:errorBlock];
    }
    else if (api == 2) {
        /// 查询设备的分享用户列表
        [self shareDevUsers:nextBlock error:errorBlock];
    }
    
}

/// 刷新session
- (void)refreshSessionID:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    [[UMWebClient shareClient] setDataTask:^(int iMsgId, int iError, id aParam) {
        if (iMsgId == UM_WEB_API_WS_HEAD_I_LOGIN_SESSION) {
            if (iError == UM_WEB_API_ERROR_ID_SUC) {
                // 获取成功
                nextBlock(aParam);
            }else{
                // 失败
                NSString *sError = [NSString stringWithFormat:@"请求错误，错误码[%d]", iError];
                NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
                errorBlock(err);
            }
        }
    }];
    [[UMWebClient shareClient] refreshSessionID];
}

/// 查询设备的分享用户列表
- (void)shareDevUsers:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    [[UMWebClient shareClient] setDataTask:^(int iMsgId, int iError, id aParam) {
        if (iMsgId == UM_WEB_API_WS_HEAD_I_DEVICE_SHARE_USERS) {
            if (iError == UM_WEB_API_ERROR_ID_SUC) {
                // 获取成功
                nextBlock(aParam);
            }else{
                // 失败
                NSString *sError = [NSString stringWithFormat:@"请求错误，错误码[%d]", iError];
                NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
                errorBlock(err);
            }
        }
    }];
    
    // 提取一个做测试数据
    TreeListItem *item = self.datas.firstObject;
    
    [[UMWebClient shareClient] sharkUserList:item];
}

/// 获取设备列表
- (void)devices:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    [[UMWebClient shareClient] setDataTask:^(int iMsgId, int iError, id aParam) {
        if (iMsgId == UM_WEB_API_WS_HEAD_I_DEVICE_QUERY) {
            if (iError == UM_WEB_API_ERROR_ID_SUC) {
                self.devices = aParam;
                // 获取成功
                [self updateDatas];
                nextBlock(aParam);
            }else{
                // 失败
                NSString *sError = [NSString stringWithFormat:@"请求错误，错误码[%d]", iError];
                NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
                errorBlock(err);
            }
        }
    }];
    [[UMWebClient shareClient] nodeList];
}

- (void)updateDatas{
    [self.datas removeAllObjects];
    for (TreeListItem *aItem in self.devices) {
        if ([aItem.sParentNodeId isEqualToString:self.sParentNodeId]) {
            [self.datas addObject:aItem];
        }
    }
}

- (NSMutableArray *)devicesAtParentNodeId:(NSString *)parentNodeId {
    NSMutableArray *tmpDevs = [NSMutableArray array];
    for (TreeListItem *aItem in self.devices) {
        if ([aItem.sParentNodeId isEqualToString:parentNodeId]) {
            [tmpDevs addObject:aItem];
        }
    }
    return tmpDevs;
}

- (NSMutableArray *)datas{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}

- (NSMutableArray *)devices{
    if (!_devices) {
        _devices = [NSMutableArray array];
    }
    return _devices;
}
@end
