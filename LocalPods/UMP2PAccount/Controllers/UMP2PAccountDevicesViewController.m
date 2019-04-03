//
//  UMP2PAccountDevicesViewController.m
//  UMP2PAccount
//
//  Created by fred on 2019/4/2.
//

#import "UMP2PAccountDevicesViewController.h"
#import "UMP2PAccountDevicesViewModel.h"

#import <SVProgressHUD/SVProgressHUD.h>
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import <UMP2P/CloudSDK.h>
#import <UMP2PVisual/UMP2PVisualLivePreiviewViewController.h>
@interface UMP2PAccountDevicesViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UMP2PAccountDevicesViewModel *viewModel;
@end

@implementation UMP2PAccountDevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
}

- (void)createViewForConctroller{
    [self.view addSubview:self.tableView];
    [self.view setNeedsUpdateConstraints];
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
    
}
- (void)updateViewConstraints{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [super updateViewConstraints];
}


#pragma mark -
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

- (UMP2PAccountDevicesViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[UMP2PAccountDevicesViewModel alloc] init];
    }
    return _viewModel;
        
}
@end
