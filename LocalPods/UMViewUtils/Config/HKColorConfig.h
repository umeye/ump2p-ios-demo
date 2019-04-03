//
//  HKColorConfig.h
//  UMEye_v2
//
//  Created by HSKJ on 14-2-28.
//  Copyright (c) 2014年 UMEye. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HKColorConfig : NSObject

+(HKColorConfig *)shareLocalConfig;
- (void)save;


- (UIColor *)appNavigationColor;
- (UIColor *)appNavigationTitleColor;
- (UIColor *)appViewColor;
- (UIColor *)appAboutColor;
- (UIColor *)appTableViewCellColor;

- (UIColor *)appSwitchColor;

- (UIColor *)appSegmentedColor;

- (UIColor *)appSegmentedSeletedColor;

- (UIColor *)appTableViewCellTextColor;

- (UIColor *)appCopyrightTextColor;

- (UIColor *)appTabbarTintColor;
- (UIColor *)appTabbarSelectedTintColor;
- (UIColor *)appTabbarTitleColor;
- (UIColor *)appTabbarTitleSelectedColor;
- (UIColor *)appCustomSegmentedSeletedTitleColor;
- (UIColor *)appCustomSegmentedSeletedTitleBackgroundColor;

- (UIColor *)livePreviewBottomMenuColor;
- (UIColor *)livePreviewBottomMenuTextColor;
- (UIColor *)livePreviewPageOtherColor;
- (UIColor *)livePreviewPageCurrentColor;
- (UIColor *)livePreviewBottomSelectedColor;
- (UIColor *)livePreviewDisplayColor;
- (UIColor *)livePreviewDisplayStatusColor;
- (UIColor *)livePreviewDisplayStatusTextColor;
- (UIColor *)livePreviewDeviceMenuColor;
- (UIColor *)livePreviewDeviceMenuTextColor;
- (UIColor *)livePreviewFunctionViewColor;


- (UIColor *)deviceListTableViewCellButtonCheckColor;
- (UIColor *)deviceListTableViewCellButtonCheckSelectedColor;

- (UIColor *)deviceListTableViewMessageColor;
- (UIColor *)deviceListTableViewMessageTextColor;

- (UIColor *)deviceListBottomViewColor;
- (UIColor *)deviceListBottomButtonColor;
- (UIColor *)deviceListBottomButtonTextColor;

- (UIColor *)deviceListTableViewDeleteDeviceCellColor;
- (UIColor *)deviceListTableViewDeleteDeviceCellTextColor;
- (UIColor *)deviceListRadarViewColor;
- (UIColor *)deviceModifyTableViewSaveDeviceCellColor;
- (UIColor *)deviceModifyTableViewSaveDeviceCellTextColor;

- (UIColor *)deviceModifyTextFieldColor;
- (UIColor *)deviceModifyScanDeviceCellColor;
- (UIColor *)deviceModifyScanDeviceCellTextColor;
- (UIColor *)deviceModifySearchDeviceCellColor;
- (UIColor *)deviceModifySearchDeviceCellTextColor;

- (UIColor *)deviceModifyChannelColor;
- (UIColor *)deviceModifyChannelTextColor;

- (UIColor *)searchMessageColor;
- (UIColor *)searchMessageTextColor;
- (UIColor *)searchTableViewCellNameTextColor;
- (UIColor *)searchTableViewCellOtherTextColor;

- (UIColor *)loginButtonTextColor;
- (UIColor *)loginButtonColor;
- (UIColor *)loginButtonHighlightedColor;
- (UIColor *)loginTextFieldColor;
- (UIColor *)loginTextFieldHighlightedColor;
- (UIColor *)loginTextFieldTextColor;

- (UIColor *)loginAutoLoginButtonColor;
- (UIColor *)loginAutoLoginButtonTextColor;

- (UIColor *)loginRegisterButtonTextColor;

- (UIColor *)moreTableViewCellColor;
- (UIColor *)moreButtonColor;
- (UIColor *)moreButtonHighlightedColor;

- (UIColor *)mainMenuViewColor;
- (UIColor *)mainMenuViewTextColor;
- (UIColor *)mainMenuViewTableViewSeletedColor;
- (UIColor *)moreButtonTextColor;
- (UIColor *)alarmSwitchColor;


- (UIColor *)alertTitleColor;
- (UIColor *)alertTitleTextColor;
- (UIColor *)alertMessageColor;
- (UIColor *)alertMessageTextColor;
- (UIColor *)alertButtonColor;
- (UIColor *)alertButtonTextColor;

- (UIColor *)messageLiteTabColor;
- (UIColor *)messageLiteTabTextColor;
- (UIColor *)messageLiteSelectionIndicatorColor;


- (UIColor *)remotePlaybackTimeSliderColor;
- (UIColor *)remotePlaybackTimeSliderTextColor;

- (UIColor *)remotePlaybackBottomColor;
- (UIColor *)remotePlaybackStatusColor;
- (UIColor *)remotePlaybackMainMenuColor;
- (UIColor *)loginTextFieldBorderColor;
- (UIColor *)remotePlaybackSearchBackgroundColor;
@end
