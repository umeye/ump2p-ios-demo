//
//  UMP2PLifeDevicesViewModel.m
//  UMP2PLife
//
//  Created by fred on 2019/4/2.
//

#import "UMP2PLifeDevicesViewModel.h"
#import <UMP2P/CloudSDK.h>
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
    }
}
- (void)devices:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.devices removeAllObjects];
        UM_WEB_API_ERROR_ID iError = [[UMWebClient shareClient] nodeList:self.devices];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (iError == UM_WEB_API_ERROR_ID_SUC) {
                [self updateDatas];
                nextBlock(@{});
            }else{
                NSString *sError = [NSString stringWithFormat:@"请求错误，错误码[%d]", iError];
                NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
                errorBlock(err);
            }
        });
    });
}

- (void)updateDatas{
    [self.datas removeAllObjects];
    for (TreeListItem *aItem in self.devices) {
        if ([aItem.sParentNodeId isEqualToString:self.sParentNodeId]) {
            [self.datas addObject:aItem];
        }
    }
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
