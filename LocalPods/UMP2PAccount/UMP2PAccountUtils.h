//
//  UMP2PAccountUtils.h
//  Pods
//
//  Created by fred on 2019/12/23.
//

#ifndef UMP2PAccountUtils_h
#define UMP2PAccountUtils_h

#import <UMViewUtils/UMViewUtils.h>
#import <Masonry/Masonry.h>
#import <UMP2P/CloudSDK.h>

typedef NS_ENUM(NSUInteger, UMHAPICmd){
    /// 登录
    UMHAPICmdLogin = 1,
    /// 注册
    UMHAPICmdRegist,
    /// 找回密码
    UMHAPICmdFindPwd,
    /// 请求短信
    UMHAPICmdPushSMS,
    /// 请求邮件
    UMHAPICmdPushEmail,
};

#endif /* UMP2PAccountUtils_h */
