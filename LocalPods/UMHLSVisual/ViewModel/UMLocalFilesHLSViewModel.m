//
//  UMLocalFilesHLSViewModel.m
//  UMLocalFile
//
//  Created by fred on 2020/2/22.
//

#import "UMLocalFilesHLSViewModel.h"
@interface UMLocalFilesHLSViewModel()
@property (nonatomic, strong) NSURL *url;
@end
@implementation UMLocalFilesHLSViewModel

- (instancetype)initWithParams:(NSDictionary *)params{
    self = [super initWithParams:params];
    if (self) {
        self.currentTime = 0;
        self.totalTime = 0;
        self.totalBuffer = 0;
        self.type = [params[UMLocalFileParamKeyType] intValue];
        id url = params[UMParamKeyPath];
        if ([url isKindOfClass:[NSString class]]) {
            self.url = [NSURL URLWithString:url];
        }else{
            self.url = url;
        }
    }
    return self;
}
#pragma mark -
- (UMHLSClient *)hlsClient{
    if (!_hlsClient) {
        _hlsClient = [[UMHLSClient alloc] initWithURL:self.url];
        _hlsClient.logEnable = YES;
    }
    return _hlsClient;
}
@end
