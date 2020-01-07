//
//  UMP2PRegisterViewController.m
//  UMP2PVisual
//
//  Created by fred on 2019/12/23.
//

#import "UMP2PRegisterViewController.h"
#import "UMP2PRegisterView.h"
#import "UMP2PRegisterViewModel.h"
#import <Masonry/Masonry.h>

@interface UMP2PRegisterViewController ()
@property (nonatomic, strong) UMP2PRegisterView *mView;
@property (nonatomic, strong) UMP2PRegisterViewModel *viewModel;
@end

@implementation UMP2PRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/// 初始化数据
- (void)initialDefaultsForController{
    
}

/// 配置导航栏
- (void)configNavigationForController{
    
}

/// 创建视图
- (void)createViewForConctroller{
    [self.view addSubview:self.mView];
    [self.view setNeedsUpdateConstraints];
}

/// 绑定 vm
- (void)bindViewModelForController{
    
    [self.mView.sendCodeBtn addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mView.okBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mView bindViewModel:self.viewModel withParams:nil];
    
    [RACObserve(self.viewModel, type) subscribeNext:^(id  _Nullable x) {
        if (self.viewModel.type == 0) {
            self.title = @"邮箱注册";
        }else{
            self.title = @"手机注册";
        }
    }];
}

- (void)updateViewConstraints{
    [self.mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    [super updateViewConstraints];
}

- (void)registerUser{
    [SVProgressHUD show];
    [self.viewModel subscribeNext:^(id x) {
        [SVProgressHUD um_displaySuccessWithStatus:@"请求注册成功"];
    } error:^(NSError *error) {
        [SVProgressHUD um_displayErrorWithStatus:error.localizedDescription];
    } api:UMHAPICmdRegist];
}

- (void)sendCode{
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionPush = [UIAlertAction actionWithTitle:@"请求短信验证码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD show];
        [self.viewModel subscribeNext:^(id x) {
            [SVProgressHUD um_displaySuccessWithStatus:@"请求短信成功"];
        } error:^(NSError *error) {
            [SVProgressHUD um_displayErrorWithStatus:error.localizedDescription];
        } api:UMHAPICmdPushSMS];
    }];
    
    UIAlertAction *actionEmail = [UIAlertAction actionWithTitle:@"请求邮箱验证码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD show];
        [self.viewModel subscribeNext:^(id x) {
            [SVProgressHUD um_displaySuccessWithStatus:@"请求邮件成功"];
        } error:^(NSError *error) {
            [SVProgressHUD um_displayErrorWithStatus:error.localizedDescription];
        } api:UMHAPICmdPushEmail];
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:actionPush];
    [ac addAction:actionEmail];
    [ac addAction:actionCancel];
    [self presentViewController:ac animated:YES completion:nil];
}

#pragma mark -
- (UMP2PRegisterView *)mView{
    if (!_mView) {
        _mView = [[UMP2PRegisterView alloc] init];
    }
    return _mView;
}

- (UMP2PRegisterViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[UMP2PRegisterViewModel alloc] init];
    }
    return _viewModel;
}
@end
