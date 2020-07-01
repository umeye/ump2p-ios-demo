//
//  UMHLSVisualUtils.h
//  Pods
//
//  Created by fred on 2020/7/1.
//

#ifndef UMHLSVisualUtils_h
#define UMHLSVisualUtils_h
    #import <UMHLS/UMHLS.h>
    #import <UMLog/UMLog.h>
    #import <UMViewUtils/UMViewUtils.h>
    #import <Masonry/Masonry.h>
    #import <UMCategory/UMCategory.h>
    #import "UMHLSVisual.h"
    typedef NS_ENUM(int, UMHLSType) {
        /// 点播
        UMHLSTypeReplay,
        /// 直播
        UMHLSTypeLive,
    };
    

    #define UMLocalFileImage(name) [UIImage imageNamed:[NSString     stringWithFormat:@"UMHLSVisual.bundle/%@", name]]

    #define UMLocalFileTemplateImage(name) [UMLocalFileImage(name) imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
    // 日志
    #define UMHLSVisualLogTag           @"UMHLSVisual"
    #define UMHLSVisualLog(frmt, ...)   ULog(UMHLSVisualLogTag, frmt, ##__VA_ARGS__)

    #define UMLocalFileLocalized(key) [NSBundle localizedStringForKey:key name:@"UMHLSVisual"]
#endif /* UMHLSVisualUtils_h */
