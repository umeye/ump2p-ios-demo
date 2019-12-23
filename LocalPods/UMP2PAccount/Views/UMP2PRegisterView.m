//
//  UMP2PRegisterView.m
//  UMP2PAccount
//
//  Created by fred on 2019/12/23.
//

#import "UMP2PRegisterView.h"
#import "UMP2PRegisterViewModel.h"

@implementation UMP2PRegisterView

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
    [self addSubview:self.passwordTextField];
    [self addSubview:self.codeTextField];
    [self addSubview:self.sendCodeBtn];
    [self addSubview:self.okBtn];
}
#pragma mark -
- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params{
    UMP2PRegisterViewModel *_viewModel = (UMP2PRegisterViewModel *)viewModel;
    RAC(_viewModel, userId) = [[RACObserve(self.userIdTextField, text)  merge:self.userIdTextField.rac_textSignal] map:^id(NSString *value) {
        return self.userIdTextField.text;
    }];
    
    RAC(_viewModel, userPwd) = [[RACObserve(self.passwordTextField, text)  merge:self.passwordTextField.rac_textSignal] map:^id(NSString *value) {
        return self.passwordTextField.text;
    }];
    
    RAC(_viewModel, code) = [[RACObserve(self.codeTextField, text)  merge:self.codeTextField.rac_textSignal] map:^id(NSString *value) {
        return self.codeTextField.text;
    }];
}
- (void)updateConstraints{
    [self.userIdTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    [self.passwordTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userIdTextField.mas_bottom).offset(10);
        make.left.right.height.mas_equalTo(self.userIdTextField);
    }];
    [self.codeTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(10);
        make.left.height.mas_equalTo(self.userIdTextField);
        make.width.mas_equalTo(180);
    }];
    
    [self.sendCodeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeTextField);
        make.right.height.mas_equalTo(self.userIdTextField);
        make.left.mas_equalTo(self.codeTextField.mas_right).offset(5);
    }];
    
    [self.okBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sendCodeBtn.mas_bottom).offset(10);
        make.left.right.height.mas_equalTo(self.userIdTextField);
    }];
    [super updateConstraints];
}

- (UITextField *)userIdTextField{
    if (!_userIdTextField) {
        _userIdTextField = [[UITextField alloc] init];
        _userIdTextField.borderStyle = UITextBorderStyleRoundedRect;
        _userIdTextField.placeholder = @"请输入用户ID";
    }
    return _userIdTextField;
}

- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordTextField.placeholder = @"请输入用户密码";
    }
    return _passwordTextField;
}

- (UITextField *)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [[UITextField alloc] init];
        _codeTextField.borderStyle = UITextBorderStyleRoundedRect;
        _codeTextField.placeholder = @"验证码";
    }
    return _codeTextField;
}

- (UIButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendCodeBtn setTitle:@"请求验证码" forState:UIControlStateNormal];
        [_sendCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sendCodeBtn setBackgroundColor:[UIColor lightGrayColor]];
        _sendCodeBtn.layer.masksToBounds = YES;
        _sendCodeBtn.layer.cornerRadius = 5;
    }
    return _sendCodeBtn;
}

- (UIButton *)okBtn{
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_okBtn setBackgroundColor:[UIColor lightGrayColor]];
        _okBtn.layer.masksToBounds = YES;
        _okBtn.layer.cornerRadius = 5;
    }
    return _okBtn;
}
@end
