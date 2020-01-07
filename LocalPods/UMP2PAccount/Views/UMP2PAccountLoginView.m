//
//  UMP2PAccountLoginView
//  UMP2PAccount
//
//  Created by Fred on 2019/3/15.
//

#import "UMP2PAccountLoginView.h"
#import "UMP2PAccountLoginViewModel.h"
#import <Masonry/Masonry.h>
@interface UMP2PAccountLoginView()
@property (nonatomic, strong) UITextField *userIdTextField;
@property (nonatomic, strong) UITextField *userPwdTextField;
@end

@implementation UMP2PAccountLoginView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViewForView];
    }
    return self;
}

- (void)createViewForView{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.userIdTextField];
    [self addSubview:self.userPwdTextField];
    [self addSubview:self.loginBtn];
    [self addSubview:self.phoneLoginBtn];
    [self addSubview:self.forgotBtn];
//    [self addSubview:self.smsBtn];
    [self addSubview:self.registerBtn];
}

- (void)updateConstraints{
    [self.userIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(20).priorityHigh();
        make.right.mas_equalTo(-20).priorityHigh();
        make.height.mas_equalTo(35);
    }];
    
    [self.userPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userIdTextField.mas_bottom).offset(20);
        make.left.right.height.mas_equalTo(self.userIdTextField);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.userPwdTextField.mas_bottom).offset(20);
        make.left.height.mas_equalTo(self.userIdTextField);
        make.right.mas_equalTo(self.mas_centerX).offset(-10);
    }];
    
    [self.phoneLoginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(self.loginBtn);
        make.right.mas_equalTo(self.userIdTextField);
        make.left.mas_equalTo(self.mas_centerX).offset(10);
    }];
    
//    [self.smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//       make.top.mas_equalTo(self.forgotBtn.mas_bottom).offset(20);
//        make.left.right.height.mas_equalTo(self.loginBtn);
//    }];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(20);
        make.left.right.height.mas_equalTo(self.userIdTextField);
    }];
    [self.forgotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.registerBtn.mas_bottom).offset(20);
        make.left.right.height.mas_equalTo(self.registerBtn);
    }];
    [super updateConstraints];
}
#pragma mark -
- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params{
    UMP2PAccountLoginViewModel *_viewModel = (UMP2PAccountLoginViewModel *)viewModel;
    RAC(_viewModel, userId) = [[RACObserve(self.userIdTextField, text)  merge:self.userIdTextField.rac_textSignal] map:^id(NSString *value) {
        return self.userIdTextField.text;
    }];
    
    RAC(_viewModel, userPwd) = [[RACObserve(self.userPwdTextField, text)  merge:self.userPwdTextField.rac_textSignal] map:^id(NSString *value) {
        return self.userPwdTextField.text;
    }];
}
#pragma mark -
- (UITextField *)userIdTextField{
    if (!_userIdTextField) {
        _userIdTextField = [[UITextField alloc] init];
        _userIdTextField.borderStyle = UITextBorderStyleRoundedRect;
        _userIdTextField.text = @"fred";
        _userIdTextField.placeholder = @"User Id";
    }
    return _userIdTextField;
}

- (UITextField *)userPwdTextField{
    if (!_userPwdTextField) {
        _userPwdTextField = [[UITextField alloc] init];
        _userPwdTextField.borderStyle = UITextBorderStyleRoundedRect;
        _userPwdTextField.placeholder = @"Password";
        _userPwdTextField.text = @"111111";
    }
    return _userPwdTextField;
}

- (UIButton *)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:[UIColor lightGrayColor]];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 5;
    }
    return _loginBtn;
}

- (UIButton *)phoneLoginBtn{
    if (!_phoneLoginBtn) {
        _phoneLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_phoneLoginBtn setTitle:@"手机登录" forState:UIControlStateNormal];
        [_phoneLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_phoneLoginBtn setBackgroundColor:[UIColor lightGrayColor]];
        _phoneLoginBtn.layer.masksToBounds = YES;
        _phoneLoginBtn.layer.cornerRadius = 5;
    }
    return _phoneLoginBtn;
}


- (UIButton *)forgotBtn{
    if (!_forgotBtn) {
        _forgotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgotBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgotBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_forgotBtn setBackgroundColor:[UIColor lightGrayColor]];
        _forgotBtn.layer.masksToBounds = YES;
        _forgotBtn.layer.cornerRadius = 5;
    }
    return _forgotBtn;
}

- (UIButton *)smsBtn{
    if (!_smsBtn) {
        _smsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_smsBtn setTitle:@"请求验证码" forState:UIControlStateNormal];
        [_smsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_smsBtn setBackgroundColor:[UIColor lightGrayColor]];
        _smsBtn.layer.masksToBounds = YES;
        _smsBtn.layer.cornerRadius = 5;
    }
    return _smsBtn;
}

- (UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_registerBtn setBackgroundColor:[UIColor lightGrayColor]];
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.cornerRadius = 5;
    }
    return _registerBtn;
}
@end
