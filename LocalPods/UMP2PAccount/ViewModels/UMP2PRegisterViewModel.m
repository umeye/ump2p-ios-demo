//
//  UMP2PRegisterViewModel.m
//  UMP2PAccount
//
//  Created by fred on 2019/12/23.
//

#import "UMP2PRegisterViewModel.h"
@interface UMP2PRegisterViewModel()
/// 0 邮箱注册，1 短信注册
@property (nonatomic, assign) int type;
@end
@implementation UMP2PRegisterViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.type = 0;
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
    NSString *userId = nil;
    NSString *email = nil;
    NSString *phone = nil;
    int mailType = 0;
    if (self.type == 0) {
        /// 邮箱注册
        mailType = 4;
        email = self.userId;
        userId = self.userId;
        phone = @"";
    }else{
        /// 短信注册
        mailType = 3;
        email = @"";
        userId = [NSString stringWithFormat:@"86%@",self.userId];
        phone = self.userId;
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[UMWebClient shareClient] registeredUser:userId password:self.userPwd email:email userName:@"" phone:phone cardId:@"" sex:0 telephone:@"" address:@"" birth:@"" mailType:mailType code:self.code];
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
        [[UMWebClient shareClient] pushEmailMsg:self.userId];
    });
    
}

@end
