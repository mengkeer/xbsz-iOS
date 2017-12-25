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
#define CX_IS_IPHONEX (CX_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0f)     //是否是iPhoneX




//定义屏幕框高等
#define CXScreenBounds ([UIScreen mainScreen].bounds)
#define CXScreenWidth  ([UIScreen mainScreen].bounds.size.width)
#define CXScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define CXScreenRect   (CGRectMake(0,0,CXScreenWidth,CXScreenHeight))
#define CXMainScale     ([UIScreen mainScreen].scale)
#define CX_PHONE_STATUSBAR_HEIGHT  (CX_IS_IPHONEX ? 44.f : 20.f)
#define CX_PHONE_NAVIGATIONBAR_HEIGHT   (CX_IS_IPHONEX ? 88.f : 64.f)
#define CX_PHONEX_HOME_INDICATOR_HEIGHT   (CX_IS_IPHONEX ? 34.f : 0)
#define CX_PHONE_TABBAR_HEIGHT (49.f + CX_PHONEX_HOME_INDICATOR_HEIGHT)        //系统推荐是49.f  + 34.f





//启动次数
#define APPFirstLaunchTime @"APPFirstLaunchTime"

//题库修改时间
#define TikuModTime    @"TikuModTime"


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
#define CXStatusBarHeight  (CX_IS_IPHONEX ? 44.f : 20.f)
#define CXNavigationBarHeight 64
#define CXTabbarHeight  (49.f + CX_PHONEX_HOME_INDICATOR_HEIGHT)
#define CXDisplayTitleHeight   32           //CXStudyViewController等的导航高度
#define CXTopCornerRadius 8         //导航栏下的弧度  eg：SetViewController
#define CXDisplayContentHeight    (CXScreenHeight-CXStatusBarHeight-CXDisplayTitleHeight-CXTabbarHeight)

//一些第三方服务所需要的App ID  与  App Key

#define APPID           @"1247054879"
#define APP_IAP_AD1       @"cc.slotus.dhu.support"
#define APP_IAP_AD2       @"cc.slotus.dhu.support2"
#define APP_IAP_AD3       @"cc.slotus.dhu.support3"


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
