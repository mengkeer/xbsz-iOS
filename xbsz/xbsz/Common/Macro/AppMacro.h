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
#define CXUserDefaults   ([NSUserDefaults standardUserDefaults])
#define CXApplication    ([UIApplication sharedApplication])
#define CXAppDelegate    ([UIApplication sharedApplication].delegate)


//3D touch item类型
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


#endif /* AppMacro_h */
