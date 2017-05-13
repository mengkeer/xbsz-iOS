//
//  UtilsMacro.h
//  xbsz
//
//  Created by lotus on 2016/12/30.
//  Copyright © 2016年 lotus. All rights reserved.
//

#ifndef UtilsMacro_h
#define UtilsMacro_h


//DEBUG
#if DEBUG

#define CXLog(FORMAT, ...) fprintf(stderr, "[%s:%d行] %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

#else

#define CXLog(FORMAT, ...) nil

#endif

#define  CXDefaultAvatar    [UIImage imageNamed:@"defaultUserPhoto"]
#define  CXFileUrlByName(fileName)             ([NSString stringWithFormat:@"%@/%@",CXFileBaseUrl,fileName])


#endif /* UtilsMacro_h */
