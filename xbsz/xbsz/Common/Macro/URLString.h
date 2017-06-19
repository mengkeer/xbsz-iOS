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



#define CXBaseUrl            @"http://www.slotus.cc/"
#define CXAvatarsBaseUrl     @"http://www.slotus.cc/avatars"
#define CXFileBaseUrl        @"http://www.slotus.cc/uploads"
#define CXNoteBaseUrl        @"http://www.slotus.cc/note"
#define CXTiKuUrl            @"http://www.slotus.cc/files/tiku.db"
#define CXDefaultUserAvatarUrl  @"http://www.slotus.cc/files/avatar.png"

//用户协议
#define CXUserProtocolUrl     @"http://www.slotus.cc/agreement.htm"

//系统
#define CXGetSystemInforms   @"http://www.slotus.cc/common-api/getInform"

#define CXLoginUrl          @"http://www.slotus.cc/common-api/login"
#define CXRegisterUrl       @"http://www.slotus.cc/common-api/register"
#define CXGetUserInfoUrl      @"http://www.slotus.cc/limit-api/getUserInfo"
#define CXUpdateUserInfoUrl   @"http://www.slotus.cc/limit-api/updateUserInfo"
#define CXUpdateUserAvatar    @"http://www.slotus.cc/file/updateAvatar"

//学习
#define CXGetCoursesUrl     @"http://www.slotus.cc/common-api/getCourses"
#define CXGetCourseCommentUrl     @"http://www.slotus.cc/common-api/getCourseComment"
#define CXAddCourseCommentUrl   @"http://www.slotus.cc/limit-api/addCourseComment"
#define CXApplyCourseUrl   @"http://www.slotus.cc/limit-api/applyCourse"
#define CXGetCourseWareUrl      @"http://www.slotus.cc/common-api/getCourseware"

#define CXGetHomeworksUrl   @"http://www.slotus.cc/limit-api/getExerciseList"
#define CXGetHomeworkQuestionssUrl   @"http://www.slotus.cc/limit-api/getExercise"





//校园动态
#define CXPublishNoteUrl    @"http://www.slotus.cc/file/publishNote"
#define CXGetNotesUrl       @"http://www.slotus.cc/common-api/getNotes"
#define CXGetNoteCommentsUrl   @"http://www.slotus.cc/common-api/getThreadNotes"
#define CXAddNoteCommentUrl    @"http://www.slotus.cc/limit-api/threadNote"


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

#define  JWURLMyBookInfo               @"http://wxserver.dhu.edu.cn/msmis/mlMag.do?method=showLibraryUserInfo"
#define    JWURLMyTuition                @"http://wxserver.dhu.edu.cn/msmis/wd_mobile.do?method=tuitionQuery"
#define JWURLMySchedule                  @"http://wxserver.dhu.edu.cn/msmis/wd_mobile.do?method=taskCalendar"

//校园应用
#define JWURLDHUCalendar          @"http://wxserver.dhu.edu.cn/msmis/wd_mobile.do?method=dhuCalendar"

#define  JWURLStudentService    @"http://dhuservice.dhu.edu.cn/sscwp_app/login.do?method=index&iportal.uxid=131340126"
#define  JWURLSchoolScenery      @"http://wxserver.dhu.edu.cn/msmis/wd_mobile.do?method=schoolView"
#define  JWURLPhoneYellowPages                    @"http://wxserver.dhu.edu.cn/msmis/queryMag.do?method=dhhyShow"
#define   JWURLSchoolLecture                    @"http://wxserver.dhu.edu.cn/msmis/queryMag.do?method=toNewList"
#define   JWURLEmployment             @"http://wxserver.dhu.edu.cn/msmis/wd_mobile.do?method=imain"
#define   JWURLBookFind              @"http://wxserver.dhu.edu.cn/msmis/mlMag.do?method=show"
#define   JWURLFreeClassroom         @"http://wxserver.dhu.edu.cn/msmis/dhu/mobile/kyjs/kyjs.jsp"
#define   JWURLAlumniAssociation    @"http://alumni.dhu.edu.cn/"


typedef NS_ENUM(NSUInteger,CXResponseCode){
    CXResponseCodeOK = 3300,
    CXResponseCodeUserRepeat = 4022,         //注册时用户名 重复
    CXResponseCodeTokenIsVoid = 5001,                //token为空
    CXResponseCodeTokenIsExpired = 5002,             //token过期了
    CXResponseCodeOldPasswordError = 4043               //修改密码时  旧密码错误
};



#endif /* URLString_h */


