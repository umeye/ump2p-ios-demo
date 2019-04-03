//
//  UMSDKConfig.h
//  UMLaunchKit
//
//  Created by Fred on 2019/3/15.
//

#import <Foundation/Foundation.h>

@interface UMSDKConfig : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *version;

@property (nonatomic, strong) NSString *desc;

@property (nonatomic, strong) NSString *initializerClassName;
@property (nonatomic, strong) NSArray *glueClassList;

@property (nonatomic, assign, getter=needsRunInMainThread) BOOL runInMainThread;

@property (nonatomic, strong) NSDictionary *options;

@end
