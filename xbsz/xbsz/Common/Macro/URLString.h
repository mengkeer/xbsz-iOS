//
//  URLString.h
//  xbsz
//
//  Created by lotus on 2017/4/7.
//  Copyright © 2017年 lotus. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef URLString_h
#define URLString_h

#define CXLoginUrl          @"http://www.slotus.cc/common-api/login"
#define CXRegisterUrl       @"http://www.slotus.cc/common-api/register"
#define CXGetUserInfoUrl      @"http://www.slotus.cc/limit-api/getUserInfo"
#define CXUpdateUserInfoUrl   @"http://www.slotus.cc/limit-api/updateUserInfo"

//学习
#define CXGetCoursesUrl     @"http://www.slotus.cc/common-api/getCourses"

#define JWLoginUrl   @"https://mobile4.dhu.edu.cn/_ids_mobile/login18_9"
#define JWRefreshLoginURL       @"https://mobile4.dhu.edu.cn/_ids_mobile/serialNoLogin18_9" 
#define JWAPNSKey      @"%3Ca5c64187%20308303f1%20b9fcb265%208782b8bb%20b43ef8d5%207df584b5%203d6146e8%206d832958%3E"
#define JWSerialNo    @"10afab0aa-4c27-4c5b-a9da-f89773655714"

//定义app里的一些url
//个人应用

#define  JWURLMyCourseTable         @"http://wxserver.dhu.edu.cn/msmis/course.do?method=getCourseTab"
#define  JWURLMyExamQuery                   @"http://wxserver.dhu.edu.cn/msmis/course.do?method=getExamQuery"
#define  JWURLMyScore                 @"http://wxserver.dhu.edu.cn/msmis/course.do?method=getScore"
#define  JWURLMyScorePoint                  @"http://wxserver.dhu.edu.cn/msmis/studentMsg.do?method=scorePoint"

#define  JWURLMyBookInfo                           @"http://wxserver.dhu.edu.cn/msmis/mlMag.do?method=showLibraryUserInfo"
#define    JWURLMyTuition                                 @"http://wxserver.dhu.edu.cn/msmis/wd_mobile.do?method=tuitionQuery"

//校园应用
#define  JWURLStudentService    @"http://dhuservice.dhu.edu.cn/sscwp_app/login.do?method=index&iportal.uxid=131340126"
#define  JWURLSchoolScenery      @"http://wxserver.dhu.edu.cn/msmis/wd_mobile.do?method=schoolView"
#define  JWURLPhoneYellowPages                    @"http://wxserver.dhu.edu.cn/msmis/queryMag.do?method=dhhyShow"
#define   JWURLSchoolLecture                    @"http://wxserver.dhu.edu.cn/msmis/queryMag.do?method=toNewList"
#define   JWURLEmployment             @"http://wxserver.dhu.edu.cn/msmis/wd_mobile.do?method=imain"
#define   JWURLBookFind              @"http://wxserver.dhu.edu.cn/msmis/mlMag.do?method=show"
#define   JWURLFreeClassroom         @"http://wxserver.dhu.edu.cn/msmis/dhu/mobile/kyjs/kyjs.jsp"


typedef NS_ENUM(NSUInteger,CXResponseCode){
    CXResponseCodeOK = 300,
    CXResponseCodeUserRepeat = 402,         //注册时用户名 重复
    CXResponseCodeTokenIsVoid = 501,                //token为空
    CXResponseCodeTokenIsExpired = 502              //token过期了
};



#endif /* URLString_h */


