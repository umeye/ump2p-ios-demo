[TOC]

##1.版本记录
|文档版本|版本说明|修改人|修改时间|
|--|--|--|--|
|1.0.1|增加人脸识别相关接口|王伏|2018-7-17|
|1.0.0|初版|王伏|2018-7-5|

## 2.系统依赖框架
```
    GLKit.framework
    Security.framework
    AVFoundation.framework
    CoreMedia.framework
    CoreVideo.framework
    UIKit.framework
    Foundation.framework
    CoreGraphics.framework
    OpenGLES.framework
    QuartzCore.framework
    AudioToolbox.framework
    libicucore.tbdµ
    libstdc++.6.0.9.tbd
    libbz2.1.0.tbd
    libiconv.tbd
    libz.1.2.5.tbd
    VideoToolbox.framework
```

## 3.工程配置

> C++ Standard Library:libc++
>
> Compile Sources As:Objective-c++
>
> Other Linker Flags = -ObjC

## 4.接口说明

### 4.1.用户系统接口-UMWebClient

***

#### 错误码
```
#pragma mark - error id
enum{
    /** @brief  connection failed  */
    UM_WEB_API_ERROR_ID_CONN = 0,
    /** @brief  协议头解析错误  */
    /** @brief  protocol head parsing error  */
    UM_WEB_API_ERROR_ID_HEAD = 1,
    /** @brief  消息ID解析错误  */
    /** @brief  message ID parsing error  */
    UM_WEB_API_ERROR_ID_MSGID = 2,
    /** @brief  协议主体解析错误  */
    /** @brief  protocol bouncer parsing error  */
    UM_WEB_API_ERROR_ID_BODY = 3,
    /** @brief  成功  */
    /** @brief  successful  */
    UM_WEB_API_ERROR_ID_SUC = 200,
    /** @brief  无效的请求，缺少参数，比如必填参数没有填写数据  */
    /** @brief  invalid request, lacking parameters, such as not filling in requested parameters  */
    UM_WEB_API_ERROR_ID_BAD_REQUEST = 400,
    /** @brief  该用户在其他地方登录，当前登录失效  */
    UM_WEB_API_ERROR_ID_HTTP_UNAUTHORIZED = 401,
    /** @brief  数据非法，请求被拒绝，比如：登录密码恢复出厂设置的时候，请求的用户没有在该手机登录过，就会提示该错误码  */
    /** @brief  request rejected, for example, after the password is reset to factory setting, if the user did not sign in on the phone before, the error code pops out    */
    UM_WEB_API_ERROR_ID_FORBIDDEN= 403,
    /** @brief  请求没找到。不支持该功能的请求  */
    /** @brief  request not found. the request for this function unsupported  */
    UM_WEB_API_ERROR_ID_NOT_FOUND = 404,
    /** @brief  非法请求。未登录，请登录  */
    /** @brief  illegal request. unlogged in, pls login  */
    UM_WEB_API_ERROR_ID_NOT_ALLOWED = 405,
    /** @brief  请求不被接受。参数错误，比如：用户名或密码不正确  */
    /** @brief  request unaccepted. parameter error, such as wrong user name or password  */
    UM_WEB_API_ERROR_ID_NOT_ACCEPTABLE = 406,
    /** @brief  请求发送冲突，数据中数据库已经存在，比如用户已注册，设备id已添加  */
    /** @brief  request conflict, for example, the registered user name already exists  */
    UM_WEB_API_ERROR_ID_CONFLICT = 409,
    /** @brief  请求用户太多  */
    /** @brief  too many requesting users  */
    UM_WEB_API_ERROR_ID_TOO_MANY_REQUESTS = 429,
    /** @brief  请求被拒绝。登录失效，请重新登录  */
    /** @brief  request rejected. Login failed. Pls login again.  */
    UM_WEB_API_ERROR_ID_ILLEGAL = 451,
    /** @brief  服务器错误，常见错误：1、数据库操作错误，查询不到符合条件的数据，2、请求外部资源失败  */
    UM_WEB_API_ERROR_ID_DB = 500,
    /** @brief  账号未激活  */
    UM_WEB_API_ERROR_ID_USER_NOT_ACTIVE = 508,
    /** @brief  账号停用  */
    UM_WEB_API_ERROR_ID_USER_NOT_ENABLE = 509,
    /** @brief  用户名不存在  */
    UM_WEB_API_ERROR_ID_USER = 899999,
    /** @brief  获取认证服务器错误，比如：用户名不存在，网络不好  */
    UM_WEB_API_ERROR_ID_GETQUTH = 899998,
    /** @brief  分享设备失败，不能分享给自己  */
    UM_WEB_API_ERROR_ID_SHARK_USER = 899997,
    
};
/** @brief  错误ID  */
/** @brief  wrong ID  */
typedef int UM_WEB_API_ERROR_ID;
```

***

#### 启动SDK
接口:
```
- (void)startSDK:(NSString *)aHost
            port:(int)aPort
      customFlag:(NSString *)aCustomFlag;
```

参数:

|参数|结果类型|说明|
|--|:--:|--|
|aHost|IN|server ip,v0.api.umeye.com|
|aPort|IN|server port,8888|
|aCustomFlag|IN|app custom flag|

示例:
```
[[UMWebClient shareClient:UM_WEB_API_TYPE_WS] startSDK:@"服务器地址" port:服务器端口 customFlag:@"客户端唯一标识"];
```

***

#### 登录

功能ID：
```
UM_WEB_API_WS_HEAD_I_USER_LOGIN
```

接口：
```
- (void)loginServerAtUserId:(NSString *)aUserId
                   password:(NSString *)aPassword;
```

参数:

|参数|结果类型|说明|
|--|:--:|--|
|aUserId|IN|用户ID(user ID)|
|aPassword|IN|用户密码(user password)|

示例:
```
//设置回调
[UMWebClient shareClient].dataTask = ^(int iMsgId, int iError, id aParam){
    if (iError == UM_WEB_API_ERROR_ID_SUC) {
        //监听登录事件回调
        if (iMsgId == UM_WEB_API_WS_HEAD_I_USER_LOGIN) {
            //如果成功，则可以进行获取设备列表操作
        }
    }else{
        //根据错误码返回对应的提示语
    }
};
//开始登录
[[UMWebClient shareClient] loginServerAtUserId:@“test” password:@"123456"];
```

***

#### 获取用户推送状态

功能ID：
```
UM_WEB_API_WS_HEAD_I_USER_PUSH_QUERY
```


接口：
```
- (void)userPushInfo;
```

参数:

|参数|结果类型|说明|
|--|:--:|--|

回调返回：

|参数|数据类型|说明|
|--|:--:|--|
|aParam|NSDictionary|用户推送配置信息|
|aParam->is_recv_push|int|用户是否接受推送|
|aParam->unread_push_count|int|用户未读数|

示例:
```
//设置回调
[UMWebClient shareClient].dataTask = ^(int iMsgId, int iError, id aParam){
    //处理回调逻辑
};
[[UMWebClient shareClient] userPushInfo];
```

***

#### 设置用户推送状态

功能ID：
```
UM_WEB_API_WS_HEAD_I_USER_PUSH_SET
```


接口：
```
- (void)modifyUserPushInfo:(BOOL)aIfEnable
         disableOtherUsers:(BOOL)aIfDisableOtherUsers
               unReadCount:(int)aUnReadCount
                    userId:(NSString *)aUserId;
```

参数:

|参数|结果类型|说明|
|--|:--:|--|
|aIfEnable|IN|是否开启推送|
|aIfDisableOtherUsers|IN|是否禁止当前手机本APP的其他账号推送(inhibit the push of other accounts of this mobile appor not)|
|aUnReadCount|IN|把推送的未读记录数设置为指定的值(set the number of unread records as a specified value)|
|aUserId|IN|用户id，无需填写|

示例:
```
//设置回调
[UMWebClient shareClient].dataTask = ^(int iMsgId, int iError, id aParam){
    //处理回调逻辑
};

[[UMWebClient shareClient] modifyUserPushInfo:YES disableOtherUsers:YES unReadCount:0 userId:nil];
```

***

#### 获取设备节点列表

接口：
```
- (UM_WEB_API_ERROR_ID)nodeList:(NSMutableArray *)aDevices;
```

参数:

|参数|数据类型|结果类型|说明|
|--|--|:--:|--|
|aDevices|NSMutableArray[TreeListItem]|OUT|获取得到的设备节点列表，需要上层初始化|

示例:
```
//建议定义全局数组，传入进去提取设备列表，方便所有UI使用
NSMutableArray *_camlistArray = [[NSMutableArray alloc] init];
UM_WEB_API_ERROR_ID iError = [[UMWebClient shareClient] nodeList:_camlistArray];

```

***

#### 新增设备节点

功能ID：
```
UM_WEB_API_WS_HEAD_I_DEVICE_ADD
```

接口：
```
- (void)addNodeInfo:(TreeListItem *)aNode;
```

参数:

|参数|结果类型|说明|
|--|:--:|--|
|aNode|IN|设备连接对象|

示例:
```
//添加节点
TreeListItem *tempAddNode = [[TreeListItem alloc] init];
//父节点ID，固定写0
tempAddNode.sParentNodeId = @"0";

//节点名称
tempAddNode.sNodeName = @"testsmart";

//节点类型,DVR,IPC
tempAddNode.iNodeType = HKS_NPC_D_MPI_MON_DEV_NODE_TYPE_CAMERA;

//连接模式
tempAddNode.iConnMode = HKS_NPC_D_MON_DEV_CONN_MODE_CLOUD_P2P;

//设备序列号
tempAddNode.sDeviceId = @"um0000000000";

//设备用户id和密码
tempAddNode.sUserId = @"admin";
tempAddNode.sUserPwd = @"";
    
//设备通道,iNodeType为DVR的时候为设备通道数，从1开始.为CAMERA的时候为通道号，从0开始
tempAddNode.iChannel = 0;
    
//厂家协议，固定写HKS_NPC_D_MON_VENDOR_ID_UMSP
tempAddNode.iVendorId = HKS_NPC_D_MON_VENDOR_ID_UMSP;

//码流，1：子码流，0：子码流
tempAddNode.iStream = 1;
    
//设置回调
[UMWebClient shareClient].dataTask = ^(int iMsgId, int iError, id aParam){
    //处理回调逻辑
};
//添加设备
[[UMWebClient shareClient] addNodeInfo:tempAddNode];
```

***

#### 修改设备节点

功能ID：
```
UM_WEB_API_WS_HEAD_I_DEVICE_MODIFY
```

接口：
```
- (void)modifyNodeInfo:(TreeListItem *)aNode;
```

参数:

|参数|结果类型|说明|
|--|:--:|--|
|aNode|IN|设备连接对象|

示例:
```
//设置回调
[UMWebClient shareClient].dataTask = ^(int iMsgId, int iError, id aParam){
    //处理回调逻辑
};
//修改设备
[[UMWebClient shareClient] modifyNodeInfo:aNode];
```

***

#### 删除设备节点

功能ID：
```
UM_WEB_API_WS_HEAD_I_DEVICE_DEL
```

接口：
```
- (void)deleteNodeInfo:(TreeListItem *)aNode;
```

参数:

|参数|结果类型|说明|
|--|:--:|--|
|aNode|IN|设备连接对象|

示例:
```
//设置回调
[UMWebClient shareClient].dataTask = ^(int iMsgId, int iError, id aParam){
    //处理回调逻辑
};
//删除设备
[[UMWebClient shareClient] deleteNodeInfo:aNode];
```

***

#### 查询布放状态

功能ID：
```
UM_WEB_API_WS_HEAD_I_ALARM_INFO_QUERY
```

接口：
```
- (void)deviceAlarmInfoAtItem:(TreeListItem *)aDevItem;
```

参数:

|参数|结果类型|说明|
|--|:--:|--|
|aDevItem|IN|设备连接对象|

回调返回：

|参数|数据类型|说明|
|--|:--:|--|
|aParam|HKSDeviceAlarmItem|布放状态对象|

示例:
```
//设置回调
[UMWebClient shareClient].dataTask = ^(int iMsgId, int iError, id aParam){
    //处理回调逻辑
};
//删除设备
[[UMWebClient shareClient] deviceAlarmInfoAtItem:aNode];
```

***

#### 修改布放状态

功能ID：
```
UM_WEB_API_WS_HEAD_I_ALARM_SET
```

接口：
```
- (void)modifyDeviceAlarmInfoAtItem:(id)aDevItems
                             opcode:(int)aOpcode
                        alarmEvents:(NSMutableArray *)aAlarmEvents
                      disableNotify:(int)aDisableNotify;
```

参数:

|参数|数据类型|结果类型|说明|
|--|--|:--:|--|
|aDevItems|NSMutableArray<TreeListItem*> or TreeListItem|IN|设备连接对象|
|aOpcode|int|IN|操作ID，1：布防/布防通知，2：撤防，3：取消布防通知，4，取消用户下所有设备布放记录，免登入模式使用|
|aAlarmEvents|NSMutableArray|IN|报警事件,参考HKS_NPC_D_MON_ALARM_TYPE_*|
|aDisableNotify|int|IN|是否关闭通知推送|

回调返回：

|参数|数据类型|说明|
|--|:--:|--|

示例:
```
//设置回调
[UMWebClient shareClient].dataTask = ^(int iMsgId, int iError, id aParam){
    //处理回调逻辑
};

[[UMWebClient shareClient] modifyDeviceAlarmInfoAtItem:aNode opcode:1 alarmEvents:@[@1,@2] disableNotify:0];
```

***

#### 查询报警记录

功能ID：
```
UM_WEB_API_WS_HEAD_I_ALARM_LOG_QUERY
```

接口：
```
- (void)alarmLogs:(int)aPageIndex
             size:(int)aPageSize
            devId:(NSString *)aDevId
      alarmEvents:(NSArray *)aAlarmEvents
        startTime:(NSString *)aStartTime
          endTime:(NSString *)aEndTime
        is_grater:(int)is_grater
          alarmId:(int)aAlarmId;
```

参数:

|参数|结果类型|说明|
|--|:--:|--|
|aPageIndex|IN|分页功能，可选，指定从第几页开始，起始值：1，0为不分页|
|aPageSize|IN|分页功能，可选，每页返回的记录数，0为不限制|
|aDevId|IN|设备ID，可选|
|aAlarmEvents|IN|报警事件，可选|
|aStartTime|IN|开始时间，可选，格式：xxxx-xx-xx xx:xx:xx|
|aEndTime|IN|结束时间，可选，格式：xxxx-xx-xx xx:xx:xx|
|is_grater|IN|是否查询大于指定alarm_id的数据，可选：-1，传1的时候查询到的是最新的数据|
|aAlarmId|IN|指定报警ID，可选：-1|

回调返回：

|参数|数据类型|说明|
|--|:--:|--|
|aParam|NSMutableArray[HKSDeviceAlarmRecordItem]|报警记录数组|

示例:
```
//设置回调
[UMWebClient shareClient].dataTask = ^(int iMsgId, int iError, id aParam){
    //处理回调逻辑
};

[[UMWebClient shareClient] deleteAlarmLogs:nil devId:nil alarmEvents:nil startTime:nil endTime:nil];
```

***

#### 删除报警记录

功能ID：
```
UM_WEB_API_WS_HEAD_I_ALARM_DEL
```

接口：
```
- (void)deleteAlarmLogs:(id)aAlarmId
                  devId:(NSString *)aDevId
            alarmEvents:(NSArray *)aAlarmEvents
              startTime:(NSString *)aStartTime
                endTime:(NSString *)aEndTime;
```

参数:

|参数|结果类型|说明|
|--|:--:|--|
|aAlarmId|IN|报警ID,可选|
|aDevId|IN|设备ID，可选|
|aAlarmEvents|IN|报警事件，可选|
|aStartTime|IN|开始时间，可选|
|aEndTime|IN|结束时间，可选|

回调返回：

|参数|数据类型|说明|
|--|:--:|--|

示例:
```
//设置回调
[UMWebClient shareClient].dataTask = ^(int iMsgId, int iError, id aParam){
    //处理回调逻辑
};

//删除单条记录
[[UMWebClient shareClient] deleteAlarmLogs:item.sAlarmRecordId devId:nil alarmEvents:nil startTime:nil endTime:nil];
//删除用户下所有记录
[[UMWebClient shareClient] deleteAlarmLogs:nil devId:nil alarmEvents:nil startTime:nil endTime:nil];
```

***

### 4.2.设备端控制接口-HKSDeviceClient

***

#### 设备端控制错误码

```
enum {
    /** @brief  成功  */
    HKS_NPC_D_MPI_MON_ERROR_SUC                         = 0,
    /** @brief  注册数据为空  */
    HKS_NPC_D_MPI_MON_ERROR_REGISTER_FAIL               = 9999,
    /** @brief  操作失败  */
    HKS_NPC_D_MPI_MON_ERROR_FAIL                        = 9998,
    /** @brief  读取数据失败  */
    HKS_NPC_D_MPI_MON_ERROR_FILE_READ_FAIL              = 9997,
    /** @brief  保存数据失败  */
    HKS_NPC_D_MPI_MON_ERROR_FILE_SAVE_FAIL              = 9996,
    /** @brief  本地模式模式下不支持该功能  */
    HKS_NPC_D_MPI_MON_ERROR_LOCAL_FAIL                  = 9995,
    /** @brief  远程录像搜索失败  */
    HKS_NPC_D_MPI_MON_ERROR_REC_SEARCH_FAIL             = 9994,
    /** @brief  客户端定制标识错误,请联系业务人员  */
    HKS_NPC_D_MPI_MON_ERROR_CLIENT_FLAG                 = 9993,
    /** @brief  门锁密码错误  */
    HKS_NPC_D_MPI_MON_ERROR_DOOR_PWD                    = 9992,
    /** @brief  系统错误  */
    HKS_NPC_D_MPI_MON_ERROR_SYS_ERROR                 = 1,
    /** @brief  连接失败  */
    HKS_NPC_D_MPI_MON_ERROR_CONNECT_FAIL              = 2,
    /** @brief  访问数据库失败,网络不稳定  */
    HKS_NPC_D_MPI_MON_ERROR_DBACCESS_FAIL             = 3,
    /** @brief  分配资源失败,可能是网络不稳定  */
    HKS_NPC_D_MPI_MON_ERROR_ALLOC_RES_FAIL            = 4,
    /** @brief  内部操作失败，如内存操作失败  */
    HKS_NPC_D_MPI_MON_ERROR_INNER_OP_FAIL             = 5,
    /** @brief  执行命令调用失败,可能是网络不稳定  */
    HKS_NPC_D_MPI_MON_ERROR_EXEC_ORDER_CALL_FAIL      = 6,
    /** @brief  执行命令结果失败,可能是网络不稳定  */
    HKS_NPC_D_MPI_MON_ERROR_EXEC_ORDER_RET_FAIL       = 7,
    /** @brief  文件不存在  */
    HKS_NPC_D_MPI_MON_ERROR_FILE_NONENTITY            = 8,
    /** @brief  未知，其它原因失败  */
    HKS_NPC_D_MPI_MON_ERROR_OTHER_FAIL                = 9,
    /** @brief  网络错误  */
    HKS_NPC_D_MPI_MON_ERROR_NET_ERROR                 = 10,
    /** @brief  服务器请求客户端重定向  */
    HKS_NPC_D_MPI_MON_ERROR_REDIRECT                  = 11,
    /** @brief  传入参数格式错误,如UMID没有12位  */
    HKS_NPC_D_MPI_MON_ERROR_PARAM_ERROR               = 12,
    /** @brief  错误的功能ID消息，当前服务器不支持该功能  */
    HKS_NPC_D_MPI_MON_ERROR_ERROR_FUNCID              = 13,
    /** @brief  该消息ID已过时，即已作废，当前服务器不支持该功能  */
    HKS_NPC_D_MPI_MON_ERROR_MSG_PAST_TIME             = 14,
    /** @brief  系统未授权  */
    HKS_NPC_D_MPI_MON_ERROR_SYS_NO_GRANT              = 15,
    /** @brief  网络错误，解析域名失败  */
    HKS_NPC_D_MPI_MON_ERROR_DNS_FAIL                  = 16,
    /** @brief  用户名格式错误  */
    HKS_NPC_D_MPI_MON_ERROR_USERNAME_FORMAT_ERROR     = 17,
    /** @brief  等待应答消息超时  */
    HKS_NPC_D_MPI_MON_ERROR_RESP_TIMEOUT              = 18,
    /** @brief  协议错误  */
    HKS_NPC_D_MPI_MON_ERROR_PROTOCOL_ERROR            = 19,
    /** @brief  用户ID或用户名错误  */
    HKS_NPC_D_MPI_MON_ERROR_USERID_ERROR              = 101,
    /** @brief  用户密码错误  */
    HKS_NPC_D_MPI_MON_ERROR_USERPWD_ERROR             = 102,
    /** @brief  用户名或密码错误  */
    HKS_NPC_D_MPI_MON_ERROR_USER_PWD_ERROR            = 103,
    /** @brief  正在连接  */
    HKS_NPC_D_MPI_MON_ERROR_CONNECTING                = 104,
    /** @brief  已连接  */
    HKS_NPC_D_MPI_MON_ERROR_CONNECTED                 = 105,
    /** @brief  播放失败  */
    HKS_NPC_D_MPI_MON_ERROR_PLAY_FAIL                 = 106,
    /** @brief  未连接摄像机  */
    HKS_NPC_D_MPI_MON_ERROR_NO_CONNECT_CAMERA         = 107,
    /** @brief  正在播放  */
    HKS_NPC_D_MPI_MON_ERROR_PLAYING                   = 108,
    /** @brief  未播放  */
    HKS_NPC_D_MPI_MON_ERROR_NO_PLAY                   = 109,
    /** @brief  不支持的厂家  */
    HKS_NPC_D_MPI_MON_ERROR_NONSUP_VENDOR             = 110,
    /** @brief  权限不够  */
    HKS_NPC_D_MPI_MON_ERROR_REJECT_ACCESS             = 111,
    /** @brief  摄像机离线  */
    HKS_NPC_D_MPI_MON_ERROR_CAMERA_OFFLINE            = 112,
    /** @brief  帐号已登录  */
    HKS_NPC_D_MPI_MON_ERROR_ACCOUNT_LOGINED           = 113,
    /** @brief  用户帐号已过有效期  */
    HKS_NPC_D_MPI_MON_ERROR_ACCOUNT_HAVE_EXPIRED      = 114,
    /** @brief  用户帐号未激活  */
    HKS_NPC_D_MPI_MON_ERROR_ACCOUNT_NO_ACTIVE         = 115,
    /** @brief  用户帐号已欠费停机  */
    HKS_NPC_D_MPI_MON_ERROR_ACCOUNT_DEBT_STOP         = 116,
    /** @brief  用户已注册  */
    HKS_NPC_D_MPI_MON_ERROR_USER_EXIST                = 117,
    /** @brief  该用户名不允许注册（不在许可表中）  */
    HKS_NPC_D_MPI_MON_ERROR_NOT_ALLOW_REG_NOPERM      = 118,
    /** @brief  不允许注册（在黑名单中）  */
    HKS_NPC_D_MPI_MON_ERROR_NOT_ALLOW_REG_ATBLACK     = 119,
    /** @brief  验证码已过期  */
    HKS_NPC_D_MPI_MON_ERROR_SECCODE_HAVE_EXPIRED      = 120,
    /** @brief  验证码错误  */
    HKS_NPC_D_MPI_MON_ERROR_SECCODE_ERROR             = 121,
    /** @brief  帐号已存在  */
    HKS_NPC_D_MPI_MON_ERROR_ACCOUNT_EXIST             = 122,
    /** @brief  无空闲流媒体服务器  */
    HKS_NPC_D_MPI_MON_ERROR_NO_IDLE_STREAMSERVER      = 123,
    /** @brief  用户未登录  */
    HKS_NPC_D_MPI_MON_ERROR_USER_NO_LOGIN             = 124,
    /** @brief  帐号长度错误  */
    HKS_NPC_D_MPI_MON_ERROR_ACCOUNT_LEN_ERROR         = 125,
    /** @brief  接收授权的用户ID不存在  */
    HKS_NPC_D_MPI_MON_ERROR_EMP_ACC_USERID_NOT_EXIST  = 126,
    /** @brief  当前的IP地址禁止登录  */
    HKS_NPC_D_MPI_MON_ERROR_IPADDR_BAN_LOGIN          = 127,
    /** @brief  该手机不允许登录该帐号  */
    HKS_NPC_D_MPI_MON_ERROR_CLIENTID_NOT_ALLOW_LOGIN  = 128,
    /** @brief  该时间段不允许访问该摄像机  */
    HKS_NPC_D_MPI_MON_ERROR_TIMESECT_NOT_ALLOW_CAMERA = 129,
    /** @brief  文件不存在  */
    HKS_NPC_D_MPI_MON_ERROR_VOD_FILE_NOT_EXIST        = 130,
    /** @brief  拒绝登录  */
    HKS_NPC_D_MPI_MON_ERROR_REJECT_LOGIN              = 131,
    /** @brief  设备组ID不存在  */
    HKS_NPC_D_MPI_MON_ERROR_DEVGROUPID_NOT_EXIST      = 132,
    /** @brief  设备组认证：密码错误  */
    HKS_NPC_D_MPI_MON_ERROR_DEVGROUP_PWD_ERROR        = 133,
    /** @brief  资源已被占用  */
    HKS_NPC_D_MPI_MON_ERROR_RESOURCE_USED             = 134,
    /** @brief  资源已未被打开  */
    HKS_NPC_D_MPI_MON_ERROR_RESOURCE_NOT_OPEN         = 135,
    /** @brief  操作成功，但需要重启设备才生效  */
    HKS_NPC_D_MPI_MON_ERROR_SUCCESS_AND_RESTART       = 136,
    /** @brief  设备组下的结点不能操作  */
    HKS_NPC_D_MPI_MON_ERROR_OPNO_DEVGROUP             = 137,
    /** @brief  无空闲资源可使用  */
    HKS_NPC_D_MPI_MON_ERROR_RESOURCE_NO_IDLE          = 138,
    /** @brief  资源不存在 */
    HKS_NPC_D_MPI_MON_ERROR_RESOURCE_NOT_EXIST        = 139,
    /** @brief  打开资源失败  */
    HKS_NPC_D_MPI_MON_ERROR_RESOURCE_OPEN_FAIL        = 140,
    /** @brief  不支持该操作  */
    HKS_NPC_D_MPI_MON_ERROR_NOT_SUPPORT_OP = 141,
    /** @brief  禁止修改  */
    HKS_NPC_D_MPI_MON_ERROR_BAN_MODIFY = 142,
    /** @brief  打开媒体流失败（打开实时预览失败）  */
    HKS_NPC_D_MPI_MON_ERROR_OPEN_STREAM_FAIL = 143,
    /** @brief  不支持该子码流  */
    HKS_NPC_D_MPI_MON_ERROR_NOT_SUPPORT_SUBSTREAM = 144,
    /** @brief  不支持云台控制  */
    HKS_NPC_D_MPI_MON_ERROR_NOT_SUPPORT_PTZ = 145,
    /** @brief  不支持强制I帧  */
    HKS_NPC_D_MPI_MON_ERROR_NOT_SUPPORT_FORCE_I_FRAME = 146,
    /** @brief  不支持语音对讲  */
    HKS_NPC_D_MPI_MON_ERROR_NOT_SUPPORT_TALK = 147,
    /** @brief  文件操作失败  */
    HKS_NPC_D_MPI_MON_ERROR_FILE_OP_FAIL = 148,
    /** @brief  ID错误  */
    HKS_NPC_D_MPI_MON_ERROR_ID_ERROR = 149,
    /** @brief  通道号错误  */
    HKS_NPC_D_MPI_MON_ERROR_CHANNEL_NO_ERROR = 150,
    /** @brief  子码流号错误  */
    HKS_NPC_D_MPI_MON_ERROR_SUB_STREAM_NO_ERROR = 151,
    /** @brief  启动对讲失败  */
    HKS_NPC_D_MPI_MON_ERROR_START_TALK_FAIL = 152,
    /** @brief  设备端主动关闭连接  */
    HKS_NPC_D_MPI_MON_ERROR_NET_PEER_CLOSE = 153,
};
/** @brief  接口返回错误码定义  */
typedef int HKS_NPC_D_MPI_MON_ERROR;

```

***

#### 播放状态
```
enum {
    /** @brief  准备播放  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_READY = 0,
    /** @brief  正在播放  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING = 1,
    /** @brief  已停止  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_STOP = 2,
    /** @brief  连接失败  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_CONNECT_FAIL = 3,
    /** @brief  正在连接  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_CONNECT_SERVER = 4,
    /** @brief  连接成功  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_CONNECT_SUCESS = 5,
    /** @brief  暂停  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_PAUSE = 6,
    /** @brief  正在停止中  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_STOPING = 7,
    /** @brief  登录失败,无权限  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_PERMISSION = 8,
    /** @brief  登录失败,离线  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_OFFLINE = 9,
    /** @brief  登录失败,超过最大连接数  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_MAXCONN = 10,
    /** @brief  资源不存在  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_ERROR_RESOURCE_NOT_EXIST = 11,
    /** @brief  码流错误，当前请求的码流设备不支持  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_STEAM_NOT_EXIST = 12,
    /** @brief  向服务器请求建立连接超时  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_SERVER_CONNECT_FAIL = 13,
    /** @brief  登录失败,用户名或密码错误  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_PASSWORD = -1,
    /** @brief  登录失败,用户名或用户名错误  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_USER = -2,
    /** @brief  登录失败,超时  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_TIMEOUT = -3,
    /** @brief  登录失败  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_RELOGGIN = -4,
    /** @brief  登录失败  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_LOCKED = -5,
    /** @brief  登录失败，连接被设备端主动断开  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_BUSY = -6,
    /** @brief  登录失败  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_LOGIN_ERROR_UNKNOW = -7,
    /** @brief  播放失败或中断,网络错误  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_ERROR_NETWORK = -9,
    /** @brief  播放失败或中断,无数据返回  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_ERROR_NODATA = -10,
    /** @brief  播放失败或中断,异常情况  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_ERROR_EXCEPTION = -11,
    /** @brief  文件播放结束  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_FILE_END = -15,
    /** @brief  下载中断  */
    HKS_NPC_D_MON_DEV_PLAY_STATUS_ERROR_DEWNLOAD_BLOCKED = -18,


};
/** @brief  客户端连接模式,自定义错误码6150-6179,对应的设备自定义错误码150-179 */
typedef int HKSDevicePlayStatus;
```

***

#### 在播放界面初始化播放句柄
        
    //初始化client
    HKSDeviceClient *_client = [[HKSDeviceClient alloc] init];  
    //设置视频窗口的坐标
    [_client.view setFrame:CGRectMake(0, 0, CGRectGetWidth(self.displayView.frame), CGRectGetHeight(self.displayView.frame))];
    //把视频窗口添加到界面上
    [self.view addSubview:_client.view];
    

***

#### 设置播放连接参数，注意 初始化HKSDeviceClient对象以后，必须调用该接口才能调用其他控制设备接口
      
    //如果有使用用户系统模块，可以通过获取设备列表接口获取设备连接对象，然后把获取到的某对象直接传入，如果没有使用自带用户系统，只需要自己创建设备连接对象，以下为自己创建
    //创建连接参数数据对象
    TreeListItem *_devItem = [[TreeListItem alloc] init];
    /*设置设备连接模式：p2p穿透模式或者直连，如果是p2p就需要设置把umid设置给sDeviceId，如果是direct直连模式，就需要把ip和端口设置给sAddress和iPort
    */
    _devItem.iConnMode = HKS_NPC_D_MON_DEV_CONN_MODE_CLOUD_P2P;
    //设备序列号
    _devItem.sDeviceId = @"um0000000000";
    //设备用户名
    _devItem.sUserId = @"admin";
    //设备密码
    _devItem.sUserPwd = @"";
    //设备通道,从0开始
    _devItem.iChannel = 0;
    //设备码流，1:子码流，0:主码流
    _devItem.iStream = 1;
    //设置设备协议类型，p2p模式可以不填写，直连直接写死UMSP类型
    _devItem.iVendorId = HKS_NPC_D_MON_VENDOR_ID_UMSP
    
    //设置设备连接参数
    [_client setDeviceConnParam:_devItem];

***

#### 设置远程回放连接参数
    
    HKSRecFile *tempFile = [[HKSRecFile alloc] init];
    Date_Time startTime,endTime;
    startTime.year = 2017;
    startTime.month = 11;
    startTime.day = 20;
    startTime.hour = 0;
    startTime.minute = 0;
    startTime.second = 0;
    tempFile.startTime = startTime;
    
    endTime.year = 2017;
    endTime.month = 11;
    endTime.day = 20;
    endTime.hour = 23;
    endTime.minute = 59;
    endTime.second = 59;
    tempFile.endTime = endTime;
    //设置设备远程回放连接参数
    [_client setRecFileConnParam:tempFile];
    //开启按时间回放
    _client.timePlayRECEnabled = YES;

***

#### 开始实时预览/远程回放播放
        
    //播放
    [_client start];
    

***

#### 停止播放
        
    //停止
    //@param[in] block[BOOL]:阻塞线程控制
    //@param[in] theExit[BOOL]:是否真正退出，在正在连接过程中是无法停止的，如果该值设置为YES,将会在连接结束以后发送停止操作。
    [_client stop:YES exit:YES];
    

***

#### 播放状态
        
    //播放状态
    //在播放界面启动计时器来进行循环的获取，得到不同的状态进行特定的UI展示
    - (HKSDevicePlayStatus)playerState;

***

#### 云台控制
        
    /**
    *  @brief  当摄像头状态为HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING播放中的时候，就可以调用该接口进行摄像头的云台控制
    *
    *  @param[in]  ptzData[int] 控制参数，根据云台控制命定，填写相对于的数据
    *  @param[in]  thePtzCmd[HKSDevicePtzCmd] 云台控制命定，请参考HKSDevicePtzCmd
    *  @since v1.0.0.0
    */
    - (int)ptzControlWithCmd:(HKSDevicePtzCmd)ptzCmd data:(int)ptzData;

***

#### 其他配置
```
//实时播放的平均帧率，fps(the average fps of real-time play) 
@property(nonatomic, assign, readonly) int          videoFrameRate;
//是否播放的平均码流，kps (the average stream of whether to play, kps)  
@property(nonatomic, assign, readonly) float        videoNetworkSpeed;
// 是否开启音频,缺省:NO */
@property(nonatomic, assign) BOOL                   audioEnabled;

//拍照
- (void)savePhotosToPath:(NSString *)path;
    
//录像
/** @brief  开始本地MP4录制
  *  @param[in]  path[NSString] 文件保存位置
  */
- (void)startRecordToPath:(NSString *)path;

/**
  *  @brief  结束本地MP4录制
  *  @param[in]  block[BOOL]:阻塞线程控制，YES：阻塞，NO：不阻塞
  */
- (NSString *)stopLocalMP4REC:(BOOL)block;
```

***

#### 设置、获取报警（移动、探头）参数
```
/**
 *  @brief  摄像机报警参数获取
 *
 *  @param   [HKSDeviceConfigItem]outAlarmMotionDetect 上层负责初始化，
 底层只会把获取到的wifi信息赋值给HKSDeviceConfigItem对应的属性
 *  @param  [int]theConfigId 报警类型：参见HKS_NPC_D_PVM_CFG_FUNCID_DEV_ALARM_*定义
 *
 *  @return [int]调用接口是否成功，参见HKS_NPC_D_MPI_MON_ERROR_*定义
 */
- (int)deviceAlarmInfo:(HKSDeviceConfigItem *)outAlarmMotionDetect configId:(int)theConfigId;

/**
 *  @brief  摄像机报警参数设置
 *
 *  @param  [HKSDeviceConfigItem]theItem 报警数据对象
 *  @param  [int]theConfigId报警类型 参见HKS_NPC_D_PVM_CFG_FUNCID_DEV_ALARM_*定义
 *
 *  @return [int]调用接口是否成功，参见HKS_NPC_D_MPI_MON_ERROR_*定义
 */
- (int)setDeviceAlarmInfo:(HKSDeviceConfigItem *)theItem  configId:(int)theConfigId;
```

***

#### 定制接口
```
/**
 *  @brief          定制功能json接口
 *  @param[in]      aCusFuncId[int]                 定制功能ID，
 *  @param[in]      aSendBuffer[NSString]           发送的数据
 *  @return         [NSString]  返回的数据，为nil的时候表示失败
 */
- (NSString *)callCustomFuncAtJson:(int)aCusFuncId sendBuffer:(NSString *)aSendBuffer encoding:(NSStringEncoding)encoding;

/**
 *  @brief          定制功能接口
 *  @param[in]      aCusFuncId[int]                 定制功能ID，
 *  @param[in]      aCusBodyBuf[unsigned char *]    定制包体缓冲区
 *  @param[in]      aCusBoyLen[int]                 定制包体长度
 *  @param[out]     aRespBodyBuf[unsigned char **]  应答包体缓冲区，由该函数分配内存，需调用callCustomFuncReleaseBuf释放
 *  @param[out]     out_pRespBodyLen[int*]          应答包体长度

 *  @return         [int] 错误码
 */
- (int)callCustomFunc:(int)aCusFuncId bodyBuffer:(unsigned char *)aCusBodyBuf bodyLen:(int)aCusBoyLen respBodyBuf:(unsigned char **)aRespBodyBuf respBodyLen:(int *)aRespBodyLen;


/**
 *  @brief          定制功能资源释放
 *  @param[in]      aDataBuf[unsigned char *]   定制包体缓冲区
 */
- (void)callCustomFuncReleaseBuf:(unsigned char *)aDataBuf;
```


#### 人脸识别相关接口

##### 获取实时抓拍图片
```
1、设置HKSDeviceClient对象的回调
@property(nonatomic, copy) RawDataCallExback    hCallbackEx;

tempClient.hCallbackEx = ^(int iMsgId, void *target, char *in_pDataBuf, id data, int in_iDataLen){
    if (iMsgId == HKS_NPC_D_UMSP_CUSTOM_FUNCID_CMP_DATA) {
        //比对数据
        /*
        data[NSMutableDictionary]:实时对比数据
        {
            "s_capImg":<UIImage>,//实时图片
            "s_libImg":<UIImage>,//比对图片
            "i_iBWMode":1,//名单类型，
            "i_sLibName":"xx",//名字
            "i_fSimilarity":10,//相识度
            "i_iCount":111,//来访次数
            "i_sCapTime":"x"//抓拍比对时间
        }
        */
        HKSDeviceClient *client = (__bridge HKSDeviceClient *)target;
        if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING){
            //正在播放中，收到比对信息，在此处处理业务逻辑            
        }
    }
    else if (iMsgId == HKS_NPC_D_UMSP_CUSTOM_FUNCID_CAP_JPG) {
        //上传实时抓拍图片
        HKSDeviceClient *client = (__bridge HKSDeviceClient *)target;
        if (client.playerState == HKS_NPC_D_MON_DEV_PLAY_STATUS_PLAYING){
            //正在播放中，收到比对信息，在此处处理业务逻辑
        }
                
    }
};

```

##### 获取黑、白、非白名单人脸库图片
```
需先调用获取人脸图片索引列表->根据单个图片索引对象获取该索引对应的图片数据

/**
 *  @brief      黑白名单：查询图片索引列表
 *
 *  @param[in]  aBWMode[int]                黑白名单类型：参考HKS_NPC_D_FACE_MODE_TYPE_*
 *  @param[out] aData[NSMutableArray->NSMutableDictionary]  返回图片索引列表数据
 *
 *  @return [HKS_NPC_D_MPI_MON_ERROR]       接口执行状态
 *
 *  @since  v2.4.11.15
 */
- (int)bwIndexList:(int)aBWMode data:(id)aData;


/**
 *  @brief      根据图片索引查询图片
 *
 *  @param[out] aData[NSMutableDictionary]  图片索引数据
 *
 *  @return [HKS_NPC_D_MPI_MON_ERROR]       接口执行状态
 *
 *  @since  v2.4.11.15
 */
- (int)bwImageAtIndex:(id)aData;

```

##### 添加、删除人脸库图片
```
/**
 *  @brief      添加图片
 *
 *  @param[int] aData[NSMutableDictionary]      图片数据
 {
     @"sImgPath": @"图片完整路径",
     @"sImg": @"图片UIImage数据，跟sImgPath字段二选一",
     @"iCtrlType": @"操作类型，填写0",
     @"iBWMode": @"黑白名单类型：参考HKS_NPC_D_FACE_MODE_TYPE_*",
     @"sImgName": @"姓名",
     @"sImgId": @"编号"
 }

 WB_FAILE = -1              添加失败
 WB_COLLECT_ERROR = -2      提取特征值失败
 WB_FILEINDEX_ERROR = -3    图片名称或编号重复
 WB_LIB_FULL = -4           名单库已满，无法添加
 WB_ADD_TIME_OUT = -5       添加超时
 WB_PARA_ERROR = -6         参数错误
 WB_FILE_BIG = -7           图片过大，添加失败（上限960*960）
 WB_SPACE_ERROR = -8        设备存储空间不足
 WB_FILE_OPEN_ERROR = -9    文件打开失败
 WB_NO_DBFILE = -10         未检测到人脸库
 WB_FILE_ERROR = -11        图片读取失败
 WB_DBFILE_BAD = -12        数据库文件损坏
 WB_PIC_QUALITY_ERROR = -13 图片质量差，无法添加
 WB_FILE_WHSIZE_ERROR = -14 图片宽高不能为奇数
 WB_FILE_FACE_ERROR = -15   检测人脸失败（无人脸或多张人脸）
 WB_PIC_FORMAT_ERROR = -16  图片格式错误（支持JPG）
 *
 *  @return [HKS_NPC_D_MPI_MON_ERROR]   接口执行状态，0：成功，<0：使用注释上面对应说明，>0:使用HKS_NPC_D_MPI_MON_ERROR对应说明
 *
 *  @since  v2.4.11.15
 */
- (int)addBWImageAtImage:(id)aData;


/**
 *  @brief      删除图片
 *
 *  @param[int] aData[id->NSMutableDictionary]  图片索引数据
 *
 *  @return [HKS_NPC_D_MPI_MON_ERROR]           接口执行状态
 *
 *  @since  v2.4.11.15
 */
- (int)delBWImageAtIndex:(id)aData;
```

##### 识别人脸库图片进行推送配置设置
```

/**
 *  @brief      获取推送配置
 *
 *  @param[out] aData[NSMutableDictionary]      返回推送配置数据
 {
     "PushEnable":   0,//推送总开关
     "BPushEnable":  0,//黑名单消息推送
     "WPushEnable":  0,//白名单消息推送
     "NWPushEnable": 0//非白名单消息推送
 }
 *  @return [HKS_NPC_D_MPI_MON_ERROR]           接口执行状态
 *
 *  @since  v2.4.11.15
 */
- (int)bwPushInfo:(id)aData;

/**
 *  @brief      设置推送配置
 *
 *  @param[in] aData[NSMutableDictionary]      推送配置数据
 {
     "PushEnable":   0,//推送总开关
     "BPushEnable":  0,//黑名单消息推送
     "WPushEnable":  0,//白名单消息推送
     "NWPushEnable": 0//非白名单消息推送
 }
 *  @return [HKS_NPC_D_MPI_MON_ERROR]           接口执行状态
 *
 *  @since  v2.4.11.15
 */
- (int)setBWPushInfo:(id)aData;

```

##### 人脸识别设备参数获取/设置
```
/**
 *  @brief      获取人脸参数配置
 *
 *  @param[out] aData[NSMutableDictionary]      返回人脸配置数据
 {
     "FaceSize":80,
     "SnapMode":2,
     "TrackFrameNum":3,
     "SnapNum":1,
     "IntervalTime": 1,
     "IntervalFrame":2,
     "IntervalSnapNum":3,
     "GateIntervalFrame":10,
     "Similarity":80,
     "CompareMode":1,
     "CompareCount":3
 }
 FaceSize：人脸最小识别像素（30-300）
 SnapMode：抓拍模式（0-5） 0=离开后抓拍（距离优先），1=快速抓拍，2=间隔抓拍（以秒为单位），3=间隔抓拍（以帧为单位），4=单人模式,5=离开后抓拍（质量优先）
 SnapNum：最大抓拍次数（1-3），对应 离开后抓拍（距离优先）和 离开后抓拍（质量优先）
 TrackFrameNum：快速抓拍帧数（10-1500），对应快速抓拍
 IntervalTime：间隔时间（1-30s），对应间隔抓拍（以秒为单位）
 IntervalFrame：间隔帧数（10-1500），对应间隔抓拍（以帧为单位）
 IntervalSnapNum：抓拍次数(0-20),0=持续抓拍，1-20是对应抓拍次数，对应 应间隔抓拍（以帧为单位）和 间隔抓拍（以秒为单位）
 GateIntervalFrame：间隔帧数（10-1500），对应单人模式
 Similarity：比对相似度（0-100）
 CompareMode：识别模式：0=次数识别，1=一直识别
 CompareCount：识别次数（1-10），对应次数识别模式
 
 *  @return [HKS_NPC_D_MPI_MON_ERROR]           接口执行状态
 *
 *  @since  v2.4.11.15
 */
- (int)bwParamInfo:(id)aData;

/**
 *  @brief      设置人脸参数配置
 *
 *  @param[in] aData[NSMutableDictionary]      返回人脸配置数据
 {
     "FaceSize":80,
     "SnapMode":2,
     "TrackFrameNum":3,
     "SnapNum":1,
     "IntervalTime": 1,
     "IntervalFrame":2,
     "IntervalSnapNum":3,
     "GateIntervalFrame":10,
     "Similarity":80,
     "CompareMode":1,
     "CompareCount":3
 }
 FaceSize：人脸最小识别像素（30-300）
 SnapMode：抓拍模式（0-5） 0=离开后抓拍（距离优先），1=快速抓拍，2=间隔抓拍（以秒为单位），3=间隔抓拍（以帧为单位），4=单人模式,5=离开后抓拍（质量优先）
 SnapNum：最大抓拍次数（1-3），对应 离开后抓拍（距离优先）和 离开后抓拍（质量优先）
 TrackFrameNum：快速抓拍帧数（10-1500），对应快速抓拍
 IntervalTime：间隔时间（1-30s），对应间隔抓拍（以秒为单位）
 IntervalFrame：间隔帧数（10-1500），对应间隔抓拍（以帧为单位）
 IntervalSnapNum：抓拍次数(0-20),0=持续抓拍，1-20是对应抓拍次数，对应 应间隔抓拍（以帧为单位）和 间隔抓拍（以秒为单位）
 GateIntervalFrame：间隔帧数（10-1500），对应单人模式
 Similarity：比对相似度（0-100）
 CompareMode：识别模式：0=次数识别，1=一直识别
 CompareCount：识别次数（1-10），对应次数识别模式

 *  @return [HKS_NPC_D_MPI_MON_ERROR]           接口执行状态
 *
 *  @since  v2.4.11.15
 */
- (int)setBWParamInfo:(id)aData;
```

