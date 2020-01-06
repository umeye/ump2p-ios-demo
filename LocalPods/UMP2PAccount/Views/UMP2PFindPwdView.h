//
//  UMP2PFindPwdView.h
//  UMP2PAccount
//
//  Created by fred on 2019/12/23.
//

#import <UIKit/UIKit.h>
@interface UMP2PFindPwdView : UIView<UMViewProtocol>

@property (nonatomic, strong) UITextField *userIdTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UITextField *codeTextField;

@property (nonatomic, strong) UIButton *sendCodeBtn;
@property (nonatomic, strong) UIButton *okBtn;
@end

