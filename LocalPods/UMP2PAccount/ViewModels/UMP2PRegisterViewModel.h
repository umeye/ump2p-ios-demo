//
//  UMP2PRegisterViewModel.h
//  UMP2PAccount
//
//  Created by fred on 2019/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UMP2PRegisterViewModel : NSObject<UMViewModelProtocol>
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userPwd;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) int areaCode;
/// 0 邮箱注册，1 短信注册
@property (nonatomic, assign) int type;
@end

NS_ASSUME_NONNULL_END
