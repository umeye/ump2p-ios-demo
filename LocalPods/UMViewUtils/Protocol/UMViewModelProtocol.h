//
//  ViewModelProtocol.h
//
//  Created by fred on 2019/1/21.
//

@protocol UMViewModelProtocol <NSObject>

#pragma mark - 方法绑定
@required
- (void)subscribeNext:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock;
- (void)subscribeNext:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock api:(int)api;
- (void)subscribeNext:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock api:(int)api param:(NSDictionary *)param;
@end
