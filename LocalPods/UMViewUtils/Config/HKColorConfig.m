//
//  HKColorConfig.m
//  UMEye_v2
//
//  Created by HSKJ on 14-2-28.
//  Copyright (c) 2014年 UMEye. All rights reserved.
//

#import "HKColorConfig.h"
#import <UMCategory/UIColor+UMAdditions.h>
#define CONFIG_NAME @"ConfigColor"
#define CONFIG_NAME_FORMAT @"plist"


#define IOS_CONFIG_COLORE_KEY_S_VERSION         @"version"

#define IOS_CONFIG_COLORE_KEY_P_APP                     @"app"
#define IOS_CONFIG_COLORE_KEY_APP_S_NAVIGATION          @"navigation background"
#define IOS_CONFIG_COLORE_KEY_APP_S_NAVIGATION_TITLE    @"navigation title"
#define IOS_CONFIG_COLORE_KEY_APP_S_VIEW                @"view"
#define IOS_CONFIG_COLORE_KEY_APP_S_ABOUT               @"about"
#define IOS_CONFIG_COLORE_KEY_APP_S_TABLEVIEWCELL       @"tableview cell"
#define IOS_CONFIG_COLORE_KEY_APP_S_TABLEVIEWCELL_TEXT  @"tableview cell text"
#define IOS_CONFIG_COLORE_KEY_APP_S_COPYRIGHT_TEXT      @"copyright text"
#define IOS_CONFIG_COLORE_KEY_APP_S_CUSTOM_TITLE_SELECTCOLOR  @"segmentedSeletedTitle"
#define IOS_CONFIG_COLORE_KEY_APP_S_CUSTOM_TITLE_SELECT_BACKGROUNDCOLOR  @"segmentedSeletedBackground"
#define IOS_CONFIG_COLORE_KEY_APP_S_SWITCH              @"switch"
#define IOS_CONFIG_COLORE_KEY_APP_S_SEGMENTED           @"segmented"
#define IOS_CONFIG_COLORE_KEY_APP_S_SEGMENTED_H         @"segmented selected"

#define IOS_CONFIG_COLORE_KEY_APP_S_TABBARTINTCOLOR             @"tabbar tintcolor"
#define IOS_CONFIG_COLORE_KEY_APP_S_TABBARSELECTD_TINTCOLOR     @"tabbar selected tintcolor"
#define IOS_CONFIG_COLORE_KEY_APP_S_TABBARTITLE_TITLECOLOR       @"tabbartitleColor"
#define IOS_CONFIG_COLORE_KEY_APP_S_TABBARTITLE_TITLESELECTCOLOR      @"tabbartitleSelectedColor"
#define IOS_CONFIG_COLORE_KEY_P_MAINMENU                    @"main menu"
#define IOS_CONFIG_COLORE_KEY_MAINMENU_S_VIEW               @"view"
#define IOS_CONFIG_COLORE_KEY_MAINMENU_S_TEXT               @"text"
#define IOS_CONFIG_COLORE_KEY_MAINMENU_S_TABLEVIEW_SELETED  @"tableview selected"



#define IOS_CONFIG_COLORE_KEY_P_LIVEPREVIEW                     @"live preview"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_BOTTOM                @"bottom"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_BOTTOM_TEXT           @"bottom text"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_BOTTOM_SELECTED       @"bottom selected"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_PAGE                  @"page"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_PAGE_SELECT           @"page select"

#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_MENU                  @"menu"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_SPACING               @"spacing"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_DISPLAYSTATUS_TEXT    @"display status text"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_DISPLAYSTATUS         @"display status"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_DISPLAY               @"display"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_DEVICEMENU            @"device menu"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_DEVICEMENU_TEXT       @"device menu text"
#define IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_FUNCTIONSVIEW         @"functionsview"


#define IOS_CONFIG_COLORE_KEY_P_DEVICELIST                                      @"device list"
#define IOS_CONFIG_COLORE_KEY_DEVICELIST_RADARVIEW                     @"radarView"
#define IOS_CONFIG_COLORE_KEY_DEVICELIST_DELETE_DEVICE_S_TABLEVIEWCELL          @"delete device"
#define IOS_CONFIG_COLORE_KEY_DEVICELIST_DELETE_DEVICE_S_TABLEVIEWCELL_LABEL    @"delete device text"
#define IOS_CONFIG_COLORE_KEY_DEVICELIST_TABLEVIEWCELL_BUTTON_S_CHECK           @"tableview cell check button"
#define IOS_CONFIG_COLORE_KEY_DEVICELIST_TABLEVIEWCELL_BUTTON_S_CHECK_S         @"tableview cell check button selected"
#define IOS_CONFIG_COLORE_KEY_DEVICELIST_S_MESSAGE                              @"message label"
#define IOS_CONFIG_COLORE_KEY_DEVICELIST_S_MESSAGE_LABEL                        @"message label text"
#define IOS_CONFIG_COLORE_KEY_DEVICELIST_S_BOTTOM_VIEW                          @"bottom view"
#define IOS_CONFIG_COLORE_KEY_DEVICELIST_S_BOTTOM_BUTTON                        @"bottom button"
#define IOS_CONFIG_COLORE_KEY_DEVICELIST_S_BOTTOM_BUTTON_TEXT                   @"bottom button text"

#define IOS_CONFIG_COLORE_KEY_P_SEARCH                                          @"search device"
#define IOS_CONFIG_COLORE_KEY_SEARCH_S_MESSAGE                                  @"search message"
#define IOS_CONFIG_COLORE_KEY_SEARCH_S_MESSAGE_TEXT                             @"search message text"
#define IOS_CONFIG_COLORE_KEY_SEARCH_S_TABLEVIEWCELL_NAME_TEXT                  @"tableview cell name text"
#define IOS_CONFIG_COLORE_KEY_SEARCH_S_TABLEVIEWCELL_OTHER_TEXT                 @"tableview cell other text"


#define IOS_CONFIG_COLORE_KEY_P_DEVICEMODIFY                                        @"device modify"
#define IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SAVE_DEVICE_S_TABLEVIEWCELL              @"save device"
#define IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SAVE_DEVICE_S_TABLEVIEWCELL_LABEL        @"save device text"

#define IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SCAN_DEVICE                      @"scan device"
#define IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SCAN_DEVICE_LABEL                @"scan device text"

#define IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SEARCH_DEVICE                    @"search device"
#define IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SEARCH_DEVICE_LABEL              @"search device text"

#define IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_CHANNEL_TEXT                     @"channel text"
#define IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_CHANNEL                          @"channel"


#define IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_TEXTFIELD_BACKGROUND             @"text field background"



#define IOS_CONFIG_COLORE_KEY_P_MORE                    @"more"
#define IOS_CONFIG_COLORE_KEY_MORE_S_TABLEVIEWCELL      @"tableview cell"
#define IOS_CONFIG_COLORE_KEY_MORE_S_BUTTON_TEXT        @"button text"
#define IOS_CONFIG_COLORE_KEY_MORE_S_BUTTON             @"button"
#define IOS_CONFIG_COLORE_KEY_MORE_S_BUTTON_H           @"button highlighted"


#define IOS_CONFIG_COLORE_KEY_P_LOGIN                   @"login"
#define IOS_CONFIG_COLORE_KEY_LOGIN_S_TEXTFIELD         @"text field"
#define IOS_CONFIG_COLORE_KEY_LOGIN_S_TEXTFIELD_TEXT    @"text field text"
#define IOS_CONFIG_COLORE_KEY_LOGIN_S_TEXTFIELD_BORDER  @"text field border"

#define IOS_CONFIG_COLORE_KEY_LOGIN_S_TEXTFIELD_H       @"text field highlighted"
#define IOS_CONFIG_COLORE_KEY_LOGIN_S_BUTTON_TEXT       @"button text"
#define IOS_CONFIG_COLORE_KEY_LOGIN_S_BUTTON            @"button"
#define IOS_CONFIG_COLORE_KEY_LOGIN_S_BUTTON_H          @"button highlighted"
#define IOS_CONFIG_COLORE_KEY_LOGIN_S_AUTOLOGIN         @"auto login"
#define IOS_CONFIG_COLORE_KEY_LOGIN_S_AUTOLOGIN_TEXT    @"auto login text"

#define IOS_CONFIG_COLORE_KEY_LOGIN_S_REGISTER_TEXT     @"register text"





#define IOS_CONFIG_COLORE_KEY_P_ALARM                   @"alarm"
#define IOS_CONFIG_COLORE_KEY_ALARM_S_SWITCH            @"switch"

#define IOS_CONFIG_COLORE_KEY_P_ALERT                   @"alert"
#define IOS_CONFIG_COLORE_KEY_ALERT_S_TITLE             @"title"
#define IOS_CONFIG_COLORE_KEY_ALERT_S_TITLE_TEXT        @"title text"

#define IOS_CONFIG_COLORE_KEY_ALERT_S_MESSAGE           @"message"
#define IOS_CONFIG_COLORE_KEY_ALERT_S_MESSAGE_TEXT      @"message text"

#define IOS_CONFIG_COLORE_KEY_ALERT_S_BUTTON            @"button"
#define IOS_CONFIG_COLORE_KEY_ALERT_S_BUTTON_TEXT       @"button text"


#define IOS_CONFIG_COLORE_KEY_P_MESSAGELIST                         @"message lite"
#define IOS_CONFIG_COLORE_KEY_MESSAGELIST_S_TAB                     @"tab"
#define IOS_CONFIG_COLORE_KEY_MESSAGELIST_S_TAB_TEXT                @"tab text"
#define IOS_CONFIG_COLORE_KEY_MESSAGELIST_S_SELECTION_INDICATOR     @"selection indicator"

#define IOS_CONFIG_COLORE_KEY_P_REMOTEPLAYBACK                      @"remote playback"
#define IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_TIMESLIDER           @"time slider"
#define IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_TIMESLIDER_TEXT      @"time slider text"

#define IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_BOTTOM               @"bottom"
#define IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_STATUS               @"status"
#define IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_MAINMENU             @"main menu"
#define IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_SEARCHBACKGROUND     @"search background"



@interface HKColorConfig()
@property(nonatomic, strong) NSMutableDictionary *localConfigDic;
@end
static HKColorConfig *shareLocalConfig = nil;
@implementation HKColorConfig


+(HKColorConfig *)shareLocalConfig{
    if (shareLocalConfig == nil)
    {
        shareLocalConfig = [[HKColorConfig alloc] init];
        shareLocalConfig.localConfigDic = [shareLocalConfig localConfigDictionary];
    }
    return shareLocalConfig;
}

- (NSMutableDictionary *)localConfigDictionary{
    
    //获取路径对象
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);//NSLibraryDirectory
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",CONFIG_NAME,CONFIG_NAME_FORMAT]];
    NSString *localPaths = [[NSBundle mainBundle] pathForResource:CONFIG_NAME ofType:CONFIG_NAME_FORMAT];
    NSMutableDictionary *localConfigDic = [NSMutableDictionary dictionaryWithContentsOfFile:localPaths]; //mutableCopy];
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        if ([localConfigDic writeToFile:plistPath atomically:YES]) {
            NSLog(@"init local config!");
        }
        
    }
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];// mutableCopy];
    if (![newDic[IOS_CONFIG_COLORE_KEY_S_VERSION] isEqualToString:localConfigDic[IOS_CONFIG_COLORE_KEY_S_VERSION]]) {
#if 0
        NSEnumerator * enumerator = [localConfigDic keyEnumerator];
        id object;
        while(object = [enumerator nextObject]){
            if (!newDic[object]) {
                newDic[object] = localConfigDic[object];
            }
        }
        newDic[IOS_CONFIG_COLORE_KEY_S_VERSION] = localConfigDic[IOS_CONFIG_COLORE_KEY_S_VERSION];
        if ([newDic writeToFile:plistPath atomically:YES]) {
            NSLog(@"update local config!");
        }
#else
        if ([localConfigDic writeToFile:plistPath atomically:YES]) {
            NSLog(@"init local config!");
        }
#endif
    }
    return [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];// mutableCopy];
}


- (void)save{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",CONFIG_NAME,CONFIG_NAME_FORMAT]];
    if ([self.localConfigDic writeToFile:plistPath atomically:YES]) {
        NSLog(@"save local color config!");
    }
}

- (NSMutableDictionary *)dictionaryApp{
    return self.localConfigDic[IOS_CONFIG_COLORE_KEY_P_APP];
}


- (NSMutableDictionary *)dictionarySearch{
    return self.localConfigDic[IOS_CONFIG_COLORE_KEY_P_SEARCH];
}

- (NSMutableDictionary *)dictionaryLivePreview{
    return self.localConfigDic[IOS_CONFIG_COLORE_KEY_P_LIVEPREVIEW];
}

- (NSMutableDictionary *)dictionaryDeviceList{
    return self.localConfigDic[IOS_CONFIG_COLORE_KEY_P_DEVICELIST];
}

- (NSMutableDictionary *)dictionaryDeviceModify{
    return self.localConfigDic[IOS_CONFIG_COLORE_KEY_P_DEVICEMODIFY];
}

- (NSMutableDictionary *)dictionaryLogin{
    return [self.localConfigDic objectForKey:IOS_CONFIG_COLORE_KEY_P_LOGIN];
}

- (NSMutableDictionary *)dictionaryMore{
    return [self.localConfigDic objectForKey:IOS_CONFIG_COLORE_KEY_P_MORE];
}

- (NSMutableDictionary *)dictionaryMainMenu{
    return [self.localConfigDic objectForKey:IOS_CONFIG_COLORE_KEY_P_MAINMENU];
}

- (NSMutableDictionary *)dictionaryAlarm{
    return [self.localConfigDic objectForKey:IOS_CONFIG_COLORE_KEY_P_ALARM];
}

- (NSMutableDictionary *)dictionaryAlert{
    return [self.localConfigDic objectForKey:IOS_CONFIG_COLORE_KEY_P_ALERT];
}

- (NSMutableDictionary *)dictionaryMessageLite{
    return [self.localConfigDic objectForKey:IOS_CONFIG_COLORE_KEY_P_MESSAGELIST];
}

- (NSMutableDictionary *)dictionaryRemotePlayback{
    return [self.localConfigDic objectForKey:IOS_CONFIG_COLORE_KEY_P_REMOTEPLAYBACK];
}
#pragma mark ---------------- View  -------------------
- (UIColor *)appNavigationColor{
    
    return [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_NAVIGATION];
}

- (UIColor *)appNavigationTitleColor{
    
    UIColor *tempColor = [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_NAVIGATION_TITLE];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor whiteColor];
    }else{
        return tempColor;
    }
}

- (UIColor *)appSwitchColor{
    UIColor *tempColor = [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_SWITCH];
    
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [self appNavigationColor];
    }
    return tempColor;
}

- (UIColor *)appSegmentedColor{
    UIColor *tempColor = [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_SEGMENTED];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]])
    {
        return [UIColor colorWithPatternImage:[UIImage imageNamed:@"buttonbar_pressed_ch.png"]];
    }
    return tempColor;
}

- (UIColor *)appSegmentedSeletedColor{
    UIColor *tempColor = [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_SEGMENTED_H];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor colorWithPatternImage:[UIImage imageNamed:@"buttonbar_ch.png"]];
    }
    return tempColor;
}
- (UIColor *)appCustomSegmentedSeletedTitleColor{
    return [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_CUSTOM_TITLE_SELECTCOLOR];
}
- (UIColor *)appCustomSegmentedSeletedTitleBackgroundColor{
    return [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_CUSTOM_TITLE_SELECT_BACKGROUNDCOLOR];
}
- (UIColor *)appViewColor{
    
    return [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_VIEW] ? : [UIColor whiteColor];
}
- (UIColor *)appAboutColor{
   
    UIColor *tempColor = [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_ABOUT];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor blackColor];
    }else{
        return tempColor;
    }
   
}
- (UIColor *)appCopyrightTextColor{
    return [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_COPYRIGHT_TEXT];
}

- (UIColor *)appTableViewCellColor{
    return [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_TABLEVIEWCELL];
}

- (UIColor *)appTableViewCellTextColor{
    return [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_TABLEVIEWCELL_TEXT];
}

- (UIColor *)appTabbarTintColor{
    return [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_TABBARTINTCOLOR];
}

- (UIColor *)appTabbarSelectedTintColor{
    return [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_TABBARSELECTD_TINTCOLOR];
}
-(UIColor *)appTabbarTitleColor{

    UIColor *tempColor = [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_TABBARTITLE_TITLECOLOR];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor blackColor];
    }else{
        return tempColor;
    }
    
}
- (UIColor *)appTabbarTitleSelectedColor{
    UIColor *tempColor = [self paramAtKey:[self dictionaryApp] key:IOS_CONFIG_COLORE_KEY_APP_S_TABBARTITLE_TITLESELECTCOLOR];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor blackColor];
    }else{
        return tempColor;
    }
}
- (UIColor *)livePreviewBottomMenuColor{
    
    return [self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_BOTTOM];
}
- (UIColor *)livePreviewBottomMenuTextColor{
    
    UIColor *tempColor = [self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_BOTTOM_TEXT];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor blackColor];
    }
    return tempColor;
    
}


- (UIColor *)livePreviewPageOtherColor{
    return [self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_PAGE];
}
- (UIColor *)livePreviewPageCurrentColor{
    UIColor *color=[self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_PAGE_SELECT];
    if ([UIColor isTheSameColor2:color anotherColor:[UIColor clearColor] ]) {
        return [UIColor redColor];
    }
    return color;
}
- (UIColor *)livePreviewBottomSelectedColor{
    return [self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_BOTTOM_SELECTED];
}
- (UIColor *)livePreviewDisplayColor{
    return [self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_DISPLAY];
}
- (UIColor *)livePreviewDisplayStatusColor{
    return [self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_DISPLAYSTATUS];
}
- (UIColor *)livePreviewDisplayStatusTextColor{
    return [self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_DISPLAYSTATUS_TEXT];
}
- (UIColor *)livePreviewDeviceMenuColor{
    return [self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_DEVICEMENU];
}
- (UIColor *)livePreviewDeviceMenuTextColor{
    
    UIColor *tempColor = [self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_DEVICEMENU_TEXT];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor blackColor];
    }
    return tempColor;
}
- (UIColor *)livePreviewFunctionViewColor{
    return [self paramAtKey:[self dictionaryLivePreview] key:IOS_CONFIG_COLORE_KEY_LIVEPREVIEW_FUNCTIONSVIEW];
}


- (UIColor *)deviceListTableViewCellButtonCheckColor{
    return [self paramAtKey:[self dictionaryDeviceList] key:IOS_CONFIG_COLORE_KEY_DEVICELIST_TABLEVIEWCELL_BUTTON_S_CHECK];
}

- (UIColor *)deviceListTableViewCellButtonCheckSelectedColor{
    return [self paramAtKey:[self dictionaryDeviceList] key:IOS_CONFIG_COLORE_KEY_DEVICELIST_TABLEVIEWCELL_BUTTON_S_CHECK_S];
}

- (UIColor *)deviceListTableViewMessageColor{
    return [self paramAtKey:[self dictionaryDeviceList] key:IOS_CONFIG_COLORE_KEY_DEVICELIST_S_MESSAGE];
}
- (UIColor *)deviceListTableViewMessageTextColor{
    return [self paramAtKey:[self dictionaryDeviceList] key:IOS_CONFIG_COLORE_KEY_DEVICELIST_S_MESSAGE_LABEL];
}

- (UIColor *)deviceListTableViewDeleteDeviceCellColor{
    return [self paramAtKey:[self dictionaryDeviceList] key:IOS_CONFIG_COLORE_KEY_DEVICELIST_DELETE_DEVICE_S_TABLEVIEWCELL];
}
- (UIColor *)deviceListTableViewDeleteDeviceCellTextColor{
    return [self paramAtKey:[self dictionaryDeviceList] key:IOS_CONFIG_COLORE_KEY_DEVICELIST_DELETE_DEVICE_S_TABLEVIEWCELL_LABEL];
}
-(UIColor *)deviceListRadarViewColor{
    return [self paramAtKey:[self dictionaryDeviceList] key:IOS_CONFIG_COLORE_KEY_DEVICELIST_RADARVIEW];
}
- (UIColor *)deviceListBottomViewColor{
    return [self paramAtKey:[self dictionaryDeviceList] key:IOS_CONFIG_COLORE_KEY_DEVICELIST_S_BOTTOM_VIEW];
}

- (UIColor *)deviceListBottomButtonColor{
    
    return [self paramAtKey:[self dictionaryDeviceList] key:IOS_CONFIG_COLORE_KEY_DEVICELIST_S_BOTTOM_BUTTON];
}
- (UIColor *)deviceListBottomButtonTextColor{
    return [self paramAtKey:[self dictionaryDeviceList] key:IOS_CONFIG_COLORE_KEY_DEVICELIST_S_BOTTOM_BUTTON_TEXT];
}

- (UIColor *)deviceModifyTableViewSaveDeviceCellColor{
    
    return [self paramAtKey:[self dictionaryDeviceModify] key:IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SAVE_DEVICE_S_TABLEVIEWCELL];
}
- (UIColor *)deviceModifyTableViewSaveDeviceCellTextColor{
    return [self paramAtKey:[self dictionaryDeviceModify] key:IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SAVE_DEVICE_S_TABLEVIEWCELL_LABEL];
}

- (UIColor *)deviceModifyScanDeviceCellColor{
    return [self paramAtKey:[self dictionaryDeviceModify] key:IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SCAN_DEVICE];
}
- (UIColor *)deviceModifyScanDeviceCellTextColor{
    return [self paramAtKey:[self dictionaryDeviceModify] key:IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SCAN_DEVICE_LABEL];
}
- (UIColor *)deviceModifySearchDeviceCellColor{
    return [self paramAtKey:[self dictionaryDeviceModify] key:IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SEARCH_DEVICE];
}
- (UIColor *)deviceModifySearchDeviceCellTextColor{
    return [self paramAtKey:[self dictionaryDeviceModify] key:IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_SEARCH_DEVICE_LABEL];
}

- (UIColor *)deviceModifyChannelColor{
    
    UIColor *tempColor = [self paramAtKey:[self dictionaryDeviceModify] key:IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_CHANNEL];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor colorWithRGB2:@"636f83"];
    }
    return tempColor;
    
}
- (UIColor *)deviceModifyChannelTextColor{
    UIColor *tempColor = [self paramAtKey:[self dictionaryDeviceModify] key:IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_CHANNEL_TEXT];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor blackColor];
    }
    return tempColor;
    
}

- (UIColor *)searchMessageColor{
    return [self paramAtKey:[self dictionarySearch] key:IOS_CONFIG_COLORE_KEY_SEARCH_S_MESSAGE];
}
- (UIColor *)searchMessageTextColor{
    return [self paramAtKey:[self dictionarySearch] key:IOS_CONFIG_COLORE_KEY_SEARCH_S_MESSAGE_TEXT];
}

- (UIColor *)searchTableViewCellNameTextColor{
    return [self paramAtKey:[self dictionarySearch] key:IOS_CONFIG_COLORE_KEY_SEARCH_S_TABLEVIEWCELL_NAME_TEXT];
}
- (UIColor *)searchTableViewCellOtherTextColor{
    return [self paramAtKey:[self dictionarySearch] key:IOS_CONFIG_COLORE_KEY_SEARCH_S_TABLEVIEWCELL_OTHER_TEXT];
}
- (UIColor *)loginButtonTextColor{
    return [self paramAtKey:[self dictionaryLogin] key:IOS_CONFIG_COLORE_KEY_LOGIN_S_BUTTON_TEXT];
}

- (UIColor *)loginButtonColor{
    return [self paramAtKey:[self dictionaryLogin] key:IOS_CONFIG_COLORE_KEY_LOGIN_S_BUTTON];
}

- (UIColor *)loginAutoLoginButtonColor{
    return [self paramAtKey:[self dictionaryLogin] key:IOS_CONFIG_COLORE_KEY_LOGIN_S_AUTOLOGIN];
}
- (UIColor *)loginAutoLoginButtonTextColor{
    return [self paramAtKey:[self dictionaryLogin] key:IOS_CONFIG_COLORE_KEY_LOGIN_S_AUTOLOGIN_TEXT];
}

- (UIColor *)loginRegisterButtonTextColor{
    return [self paramAtKey:[self dictionaryLogin] key:IOS_CONFIG_COLORE_KEY_LOGIN_S_REGISTER_TEXT];
}


- (UIColor *)loginButtonHighlightedColor{
    return [self paramAtKey:[self dictionaryLogin] key:IOS_CONFIG_COLORE_KEY_LOGIN_S_BUTTON_H];
}


- (UIColor *)loginTextFieldColor{
    return [self paramAtKey:[self dictionaryLogin] key:IOS_CONFIG_COLORE_KEY_LOGIN_S_TEXTFIELD];
}

- (UIColor *)loginTextFieldBorderColor
{
    return [self paramAtKey:[self dictionaryLogin] key:IOS_CONFIG_COLORE_KEY_LOGIN_S_TEXTFIELD_BORDER];
}

- (UIColor *)loginTextFieldTextColor{
    
    UIColor *tempColor = [self paramAtKey:[self dictionaryLogin] key:IOS_CONFIG_COLORE_KEY_LOGIN_S_TEXTFIELD_TEXT];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor blackColor];
    }
    return tempColor;
}


- (UIColor *)loginTextFieldHighlightedColor{
    return [self paramAtKey:[self dictionaryLogin] key:IOS_CONFIG_COLORE_KEY_LOGIN_S_TEXTFIELD_H];
}


- (UIColor *)moreTableViewCellColor{
    return [self paramAtKey:[self dictionaryMore] key:IOS_CONFIG_COLORE_KEY_MORE_S_TABLEVIEWCELL];
}

- (UIColor *)moreButtonColor{
    return [self paramAtKey:[self dictionaryMore] key:IOS_CONFIG_COLORE_KEY_MORE_S_BUTTON];
}

- (UIColor *)moreButtonHighlightedColor{
    return [self paramAtKey:[self dictionaryMore] key:IOS_CONFIG_COLORE_KEY_MORE_S_BUTTON_H];
}

- (UIColor *)moreButtonTextColor{
    UIColor *tempColor = [self paramAtKey:[self dictionaryMore] key:IOS_CONFIG_COLORE_KEY_MORE_S_BUTTON_TEXT];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor whiteColor];
    }
    return tempColor;
}


- (UIColor *)mainMenuViewColor{
    return [self paramAtKey:[self dictionaryMainMenu] key:IOS_CONFIG_COLORE_KEY_MAINMENU_S_VIEW];
}

- (UIColor *)mainMenuViewTextColor{
    return [self paramAtKey:[self dictionaryMainMenu] key:IOS_CONFIG_COLORE_KEY_MAINMENU_S_TEXT];
}
- (UIColor *)mainMenuViewTableViewSeletedColor{
    UIColor *tempColor = [self paramAtKey:[self dictionaryMainMenu] key:IOS_CONFIG_COLORE_KEY_MAINMENU_S_TABLEVIEW_SELETED];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor colorWithRGB2:@"41a9cf"];
    }
    return tempColor;
}


- (UIColor *)alarmSwitchColor{
    return [self paramAtKey:[self dictionaryAlarm] key:IOS_CONFIG_COLORE_KEY_ALARM_S_SWITCH];
}

- (UIColor *)paramAtKey:(NSMutableDictionary *)theDic key:(NSString *)theKey{
    NSString *tempParam = [theDic objectForKey:theKey];
    if (tempParam == nil || [tempParam isEqualToString:@""]) {
        return [UIColor clearColor];
    }
    return [UIColor colorWithRGB2:tempParam];
}


- (UIColor *)deviceModifyTextFieldColor{
    return [self paramAtKey:[self dictionaryDeviceModify] key:IOS_CONFIG_COLORE_KEY_DEVICEMODIFY_TEXTFIELD_BACKGROUND];
    
}
- (UIColor *)alertTitleColor{
    return [self paramAtKey:[self dictionaryAlert] key:IOS_CONFIG_COLORE_KEY_ALERT_S_TITLE];
}

- (UIColor *)alertTitleTextColor{
    return [self paramAtKey:[self dictionaryAlert] key:IOS_CONFIG_COLORE_KEY_ALERT_S_TITLE_TEXT];
}

- (UIColor *)alertMessageColor{
    return [self paramAtKey:[self dictionaryAlert] key:IOS_CONFIG_COLORE_KEY_ALERT_S_MESSAGE];
}

- (UIColor *)alertMessageTextColor{
    return [self paramAtKey:[self dictionaryAlert] key:IOS_CONFIG_COLORE_KEY_ALERT_S_MESSAGE_TEXT];
}

- (UIColor *)alertButtonColor{
    return [self paramAtKey:[self dictionaryAlert] key:IOS_CONFIG_COLORE_KEY_ALERT_S_BUTTON];
}

- (UIColor *)alertButtonTextColor{
    return [self paramAtKey:[self dictionaryAlert] key:IOS_CONFIG_COLORE_KEY_ALERT_S_BUTTON_TEXT];
}

- (UIColor *)messageLiteTabColor{
    return [self paramAtKey:[self dictionaryMessageLite] key:IOS_CONFIG_COLORE_KEY_MESSAGELIST_S_TAB];
}
- (UIColor *)messageLiteTabTextColor{
    return [self paramAtKey:[self dictionaryMessageLite] key:IOS_CONFIG_COLORE_KEY_MESSAGELIST_S_TAB_TEXT];
}

- (UIColor *)messageLiteSelectionIndicatorColor{
    return [self paramAtKey:[self dictionaryMessageLite] key:IOS_CONFIG_COLORE_KEY_MESSAGELIST_S_SELECTION_INDICATOR];
}

- (UIColor *)remotePlaybackTimeSliderColor{
    return [self paramAtKey:[self dictionaryRemotePlayback] key:IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_TIMESLIDER];
}

- (UIColor *)remotePlaybackTimeSliderTextColor{
    UIColor *tempColor = [self paramAtKey:[self dictionaryRemotePlayback] key:IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_TIMESLIDER_TEXT];
    if ([UIColor isTheSameColor2:tempColor anotherColor:[UIColor clearColor]]) {
        return [UIColor whiteColor];
    }
    return tempColor;
}

- (UIColor *)remotePlaybackBottomColor{
    return [self paramAtKey:[self dictionaryRemotePlayback] key:IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_BOTTOM];
}
- (UIColor *)remotePlaybackStatusColor{
    return [self paramAtKey:[self dictionaryRemotePlayback] key:IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_STATUS];
}

- (UIColor *)remotePlaybackMainMenuColor{
    return [self paramAtKey:[self dictionaryRemotePlayback] key:IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_MAINMENU];
}
- (UIColor *)remotePlaybackSearchBackgroundColor{
    return [self paramAtKey:[self dictionaryRemotePlayback] key:IOS_CONFIG_COLORE_KEY_REMOTEPLAYBACK_S_SEARCHBACKGROUND];
}
@end
