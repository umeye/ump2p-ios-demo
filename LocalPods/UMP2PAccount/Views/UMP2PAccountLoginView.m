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
}

- (void)updateConstraints{
    [self.userIdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(35);
    }];
    
    [self.userPwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.userIdTextField.mas_bottom).offset(20);
        make.left.right.height.mas_equalTo(self.userIdTextField);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.userPwdTextField.mas_bottom).offset(20);
        make.left.right.height.mas_equalTo(self.userIdTextField);
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
        [_loginBtn setTitle:@"Login" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_loginBtn setBackgroundColor:[UIColor lightGrayColor]];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 5;
    }
    return _loginBtn;
}
@end
