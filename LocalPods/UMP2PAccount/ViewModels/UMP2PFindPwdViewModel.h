//
//  UMP2PFindPwdViewModel.h
//  UMP2PAccount
//
//  Created by fred on 2019/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UMP2PFindPwdViewModel : NSObject<UMViewModelProtocol>
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userPwd;
@property (nonatomic, copy) NSString *code;
/// 0 邮箱，1 短信
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int areaCode;
@end

NS_ASSUME_NONNULL_END
