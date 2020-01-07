//
//  UMP2PAccountLoginViewModel
//  UMP2PAccount
//
//  Created by Fred on 2019/3/15.
//

#import <Foundation/Foundation.h>
@interface UMP2PAccountLoginViewModel : NSObject <UMViewModelProtocol>
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userPwd;
@property (nonatomic, assign) int areaCode;

@end
