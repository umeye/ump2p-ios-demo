//
//  UMP2PAccountLoginView
//  UMP2PAccount
//
//  Created by Fred on 2019/3/15.
//

#import <Foundation/Foundation.h>
#import <UMViewUtils/UMViewUtils.h>

@interface UMP2PAccountLoginView : UIView <UMViewProtocol>

/// 登录按钮
@property (nonatomic, strong) UIButton *loginBtn;
/// 注册按钮
@property (nonatomic, strong) UIButton *registerBtn;
/// 忘记密码
@property (nonatomic, strong) UIButton *forgotBtn;
/// 请求短信
@property (nonatomic, strong) UIButton *smsBtn;

@end
