//
//  AppMacro.h
//  idemo
//
//  Created by lotus on 2016/12/9.
//  Copyright © 2016年 lotus. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

//手机一些硬件信息
#define CXSystemVersion  [[[UIDevice currentDevice] systemVersion] floatValue]

//定义手机型号
#define CX_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define CX_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define CX_IS_IPHONE4 (CX_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define CX_IS_IPHONE5 (CX_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define CX_IS_IPHONE6 (CX_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define CX_IS_IPHONE6PLUS (CX_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)
#define CX_IS_RETINA ([[UIScreen mainScreen] scale] == 2.0f)

//定义屏幕框高等
#define CXScreenBounds ([UIScreen mainScreen].bounds)
#define CXScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define CXScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define CXScreenRect   (CGRectMake(0,0,CXScreenWidth,CXScreenHeight))
#define CXMainScale     ([UIScreen mainScreen].scale)


//启动次数
#define AppLaunchTimes @"AppLaunchTimes"
#define AppLastLaunchTime @"AppLastLaunchTime"


//常用单例类
#define CXStandardUserDefaults   ([NSUserDefaults standardUserDefaults])
#define CXApplication    ([UIApplication sharedApplication])
#define CXAppDelegate    ([UIApplication sharedApplication].delegate)


//3D touch item类型
//UIForceTouchCapability
//UIForceTouchCapabilityUnknown //3D Touch检测失败
//UIForceTouchCapabilityUnavailable //3D Touch不可用
//UIForceTouchCapabilityAvailable //3D Touch可用
#define CX3DTouchOpened   (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)

#define CX3DTouchItemTypeShare   @"cc.slotus.xbsz.share"
#define CX3DTouchItemTypeSearch  @"cc.slotus.xbsz.search"
#define CX3DTouchItemTypeLove    @"cc.slotus.xbsz.love"
#define CX3DTouchItemTypeMail    @"cc.slotus.xbsz.mail"


//应用里一些常见宽高或其他定义
#define CXStatusBarHeight  20
#define CXNavigationBarHeight 64
#define CXTabbarHeight  49          
#define CXDisplayTitleHeight   32           //CXStudyViewController等的导航高度
#define CXTopCornerRadius 8         //导航栏下的弧度  eg：SetViewController
#define CXDisplayContentHeight    (CXScreenHeight-CXStatusBarHeight-CXDisplayTitleHeight-CXTabbarHeight)

//一些第三方服务所需要的App ID  与  App Key

#define    BuglyAppID       @"c48b5790e9"


//定义第三方登录APP Key与Secret
#define    WeiBoAPPKey   @"2498144776";
#define    WeiBoSecret   @"2a57a50b590d3b6998ebab0c23926503"

#define    QQAPPKey      @"1105988289"
#define    QQSecret      @"McS0iWg3GBW1glQm"

#define    WechatAPPKey  @""
#define    WechatSecret   @""


//个人应用

#endif /* AppMacro_h */
