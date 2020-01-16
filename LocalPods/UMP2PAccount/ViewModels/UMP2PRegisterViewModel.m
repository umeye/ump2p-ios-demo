//
//  UMP2PRegisterViewModel.m
//  UMP2PAccount
//
//  Created by fred on 2019/12/23.
//

#import "UMP2PRegisterViewModel.h"
@interface UMP2PRegisterViewModel()
@end
@implementation UMP2PRegisterViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.type = 0;
        self.areaCode = 86;
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
    if (api == UMHAPICmdPushSMS) {
        [self pushSMS:nextBlock error:errorBlock];
    }
    else if (api == UMHAPICmdPushEmail) {
        [self pushEmail:nextBlock error:errorBlock];
    }
    else if (api == UMHAPICmdRegist) {
        [self registerUser:nextBlock error:errorBlock];
    }
    
}

- (void)registerUser:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    if (self.userId.length == 0 || self.userPwd.length == 0 || self.code.length == 0) {
        NSString *sError = @"参数不能为空,请重新输入";
        NSError *err = [NSError errorWithDomain:@"" code:-1 userInfo:@{NSLocalizedDescriptionKey : sError}];
        errorBlock(err);
        return;
    }
    [[UMWebClient shareClient] setDataTask:^(int iMsgId, int iError, id aParam) {
        if (iMsgId == UM_WEB_API_WS_HEAD_I_USER_REGISTER) {
            if (iError == UM_WEB_API_ERROR_ID_SUC) {
                nextBlock(aParam);
            }else{
                NSString *sError = [NSString stringWithFormat:@"请求错误，错误码[%d]", iError];
                NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
                errorBlock(err);
            }
        }
    }];
    int verType = 0;
    int areaCode = 0;
    if (self.type == 0) {
        /// 邮箱注册
        verType = 4;
        areaCode = 0;
    }else{
        /// 短信注册
        verType = 3;
        areaCode = self.areaCode;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UMWebClient shareClient] registeredUser:self.userId password:self.userPwd userName:@"" verType:verType verCode:self.code areaCode:areaCode];
    });
}

- (void)pushSMS:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    
    if (self.userId.length == 0) {
        NSString *sError = @"用户名不能为空,请重新输入";
        NSError *err = [NSError errorWithDomain:@"" code:-1 userInfo:@{NSLocalizedDescriptionKey : sError}];
        errorBlock(err);
        return;
    }
    [[UMWebClient shareClient] setDataTask:^(int iMsgId, int iError, id aParam) {
        if (iMsgId == UM_WEB_API_WS_HEAD_I_PUSH_SMS) {
            if (iError == UM_WEB_API_ERROR_ID_SUC) {
                self.type = 1;
                nextBlock(aParam);
            }else{
                NSString *sError = [NSString stringWithFormat:@"请求错误，错误码[%d]", iError];
                NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
                errorBlock(err);
            }
        }
    }];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UMWebClient shareClient] pushPhoneSMS:self.userId areaCode:@"86" type:2];
    });
}

- (void)pushEmail:(void (^)(id x))nextBlock error:(void (^)(NSError *error))errorBlock{
    
    if (self.userId.length == 0) {
        NSString *sError = @"用户名不能为空,请重新输入";
        NSError *err = [NSError errorWithDomain:@"" code:-1 userInfo:@{NSLocalizedDescriptionKey : sError}];
        errorBlock(err);
        return;
    }
    [[UMWebClient shareClient] setDataTask:^(int iMsgId, int iError, id aParam) {
        if (iMsgId == UM_WEB_API_WS_HEAD_I_PUSH_EMAIL) {
            if (iError == UM_WEB_API_ERROR_ID_SUC) {
                self.type = 0;
                nextBlock(aParam);
            }else{
                NSString *sError = [NSString stringWithFormat:@"请求错误，错误码[%d]", iError];
                NSError *err = [NSError errorWithDomain:@"" code:iError userInfo:@{NSLocalizedDescriptionKey : sError}];
                errorBlock(err);
            }
        }
    }];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UMWebClient shareClient] pushEmailMsg:self.userId type:1];
    });
    
}

@end
