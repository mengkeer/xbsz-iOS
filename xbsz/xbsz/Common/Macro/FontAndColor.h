//
//  FontAndColor.h
//  xbsz
//
//  Created by lotus on 2016/12/9.
//  Copyright © 2016年 lotus. All rights reserved.
//

#ifndef FontAndColor_h
#define FontAndColor_h


//定义屏幕颜色等
#define CXMainColor  [UIColor colorWithRed:0.89f green:0.49f blue:0.61f alpha:1.00f]
//#define CXMainColor  CXHexColor(0xC1CDC1)
#define CXBackGroundColor  CXHexColor(0xF6F6F6)
#define CXLineColor    CXHexColor(0xE8E8E8)
#define CXWhiteColor [UIColor whiteColor]
#define CXBlackColor   ([UIColor blackColor])
#define CXRedColor   [UIColor redColor]
#define CXGreenColor   ([UIColor greenColor])
#define CXBlueColor  [UIColor blueColor]
#define CXClearColor [UIColor clearColor]
#define CXGrayColor   [UIColor grayColor]
#define CXLightGrayColor  [UIColor lightGrayColor]
#define CXTextGrayColor    (CXHexColor(0x272b3c))

//RGB Color
#define CXRGBColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]
#define CXRGBAColor(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define CXHexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0]
#define CXHexAlphaColor(hexValue, alphaP) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:((float)alphaP)]


//字体
#define CXSystemFont(size) [UIFont systemFontOfSize:size]
#define CXSystemBoldFont(size) [UIFont boldSystemFontOfSize:size]
//#define CXSetItemFont    [UIFont fontWithName:@"Courier" size:16.f]
#define   CXSetItemFont       [UIFont systemFontOfSize:16.f]            //设置界面 与 个人信息页面里的标题字体
#define CXSetItemDetailFont    [UIFont fontWithName:@"Courier" size:13.f]       //设置界面 与 个人信息页面里的详情字


#endif /* FontAndColor_h */
