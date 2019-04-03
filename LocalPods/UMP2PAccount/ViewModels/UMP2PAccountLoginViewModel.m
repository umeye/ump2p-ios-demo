//
//  UMP2PAccountLoginViewModel
//  UMP2PAccount
//
//  Created by Fred on 2019/3/15.
//

#import "UMP2PAccountLoginViewModel.h"
#import <UMP2P/CloudSDK.h>
@implementation UMP2PAccountLoginViewModel

- (void)subscribeNext:(void (^)(id))nextBlock error:(void (^)(NSError *))errorBlock{
    [self subscribeNext:nextBlock error:errorBlock api:0 param:nil];
}

- (void)subscribeNext:(void (^)(id))nextBlock error:(void (^)(NSError *))errorBlock api:(int)api{
    [self subscribeNext:nextBlock error:errorBlock api:api param:nil];
}

- (void)subscribeNext:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock api:(int)api param:(NSDictionary *)param{
    if (api == 0) {
        [self login:nextBlock error:errorBlock];
    }
}

- (void)login:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    
    if (self.userId.length == 0) {
        NSString *sError = @"用户名不能为空,请重新输入";
        NSError *err = [NSError errorWithDomain:@"" code:-1 userInfo:@{NSLocalizedDescriptionKey : sError}];
        errorBlock(err);
        return;
    }
    if (self.userPwd.length == 0) {
        NSString *sError = @"密码不能为空,请重新输入";
        NSError *err = [NSError errorWithDomain:@"" code:-2 userInfo:@{NSLocalizedDescriptionKey : sError}];
        errorBlock(err);
        return;
    }
    [[UMWebClient shareClient] setDataTask:^(int iMsgId, int iError, id aParam) {
        if (iMsgId == UM_WEB_API_WS_HEAD_I_USER_LOGIN) {
            if (iError == UM_WEB_API_ERROR_ID_SUC) {
                // 开启用户推送，关联属性-sClientToken
                [[UMWebClient shareClient] modifyUserPushInfo:YES disableOtherUsers:YES unReadCount:0 userId:nil];
                nextBlock(aParam);
            }else{
                NSString *sError = [NSString stringWithFormat:@"请求错误，错误码[%d]", iError];
                NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
                errorBlock(err);
            }
        }
    }];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UMWebClient shareClient] loginServerAtUserId:self.userId password:self.userPwd];
    });
}


@end
