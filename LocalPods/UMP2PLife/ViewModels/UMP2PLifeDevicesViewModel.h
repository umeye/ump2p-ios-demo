//
//  UMP2PLifeDevicesViewModel.h
//  UMP2PLife
//
//  Created by fred on 2019/4/2.
//

#import <Foundation/Foundation.h>
#import <UMViewUtils/UMViewUtils.h>

@interface UMP2PLifeDevicesViewModel : NSObject <UMViewModelProtocol>
@property (nonatomic, strong) NSMutableArray *datas;

/// 父节点ID
@property (nonatomic, copy) NSString *sParentNodeId;

- (void)updateDatas;
@end

