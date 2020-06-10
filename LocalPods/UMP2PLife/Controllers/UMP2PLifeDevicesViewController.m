//
//  UMP2PLifeDevicesViewController.m
//  UMP2PLife
//
//  Created by fred on 2019/4/2.
//

#import "UMP2PLifeDevicesViewController.h"
#import "UMP2PLifeDevicesViewModel.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import <UMP2PVisual/UMP2PVisualLivePreiviewViewController.h>
@interface UMP2PLifeDevicesViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UMP2PLifeDevicesViewModel *viewModel;
@property (nonatomic, assign) BOOL isGetData;
@end

@implementation UMP2PLifeDevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isGetData) {
        [self.tableView.mj_header beginRefreshing];
    }
    self.isGetData = YES;
}

- (void)createViewForConctroller{
    [self.view addSubview:self.tableView];
    [self.view setNeedsUpdateConstraints];
}

- (void)initialDefaultsForController{
    self.isGetData = NO;
}
- (void)configNavigationForController{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStyleDone target:self action:@selector(doEventLogout)];
}

- (void)bindViewModelForController{
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    [refreshHeader setTitle:UMLocalized(@"You can drop down to refresh") forState:(MJRefreshStateIdle)];
    [refreshHeader setTitle:UMLocalized(@"Release immediately refresh") forState:(MJRefreshStatePulling)];
    [refreshHeader setTitle:UMLocalized(@"It is to help you refresh") forState:(MJRefreshStateRefreshing)];
    self.tableView.mj_header = refreshHeader;
    
    
    [RACObserve(self.viewModel, sParentNodeId) subscribeNext:^(id  _Nullable x) {
        [self.viewModel updateDatas];
        [self.tableView reloadData];
    }];
    
    // 刷新session
    [SVProgressHUD show];
    [self.viewModel subscribeNext:^(id  _Nonnull x) {
        [self.viewModel subscribeNext:^(id  _Nonnull x) {
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
        } error:^(NSError * _Nonnull error) {
            [SVProgressHUD um_displayErrorWithStatus:error.localizedDescription];
        }];
    } error:^(NSError * _Nonnull error) {
        [SVProgressHUD um_displayErrorWithStatus:error.localizedDescription];
    } api:1];
}
- (void)updateViewConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [super updateViewConstraints];
}

#pragma mark -
#pragma mark 下拉刷新设备列表
- (void)headerRereshing{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.viewModel subscribeNext:^(id  _Nonnull x) {
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];

        } error:^(NSError * _Nonnull error) {
            [SVProgressHUD um_displayErrorWithStatus:error.localizedDescription];
            [self.tableView.mj_header endRefreshing];
        }];
    });
}

#pragma mark 注销账号
- (void)doEventLogout{
    [[NSNotificationCenter defaultCenter] postNotificationName:UMLogoutNotificationKey object:self];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"Devices Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    TreeListItem *aItem = self.viewModel.datas[indexPath.row];
    cell.textLabel.text = aItem.sNodeName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TreeListItem *aItem = self.viewModel.datas[indexPath.row];
    if (aItem.iNodeType != HKS_NPC_D_MPI_MON_DEV_NODE_TYPE_CAMERA) {
        // 进入下一级节点
        self.viewModel.sParentNodeId = aItem.sNodeId;
    }else{
        self.viewModel.sParentNodeId = @"0";
        // camera节点，进入播放界面
        UMP2PVisualLivePreiviewViewController *vc = [[UMP2PVisualLivePreiviewViewController alloc] init];
        vc.playItem = aItem;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark -
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Devices Cell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UMP2PLifeDevicesViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[UMP2PLifeDevicesViewModel alloc] init];
    }
    return _viewModel;
        
}
@end
