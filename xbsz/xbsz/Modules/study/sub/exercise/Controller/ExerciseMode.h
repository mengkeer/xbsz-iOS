//
//  ExerciseMode.h
//  xbsz
//
//  Created by lotus on 2017/4/25.
//  Copyright © 2017年 lotus. All rights reserved.
//
#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger,ExerciseMode){
    ExerciseModeRecite,               //预览模式
    ExerciseModePractice,               //做题模式
    ExerciseModePracticeRandom,          //做题模式,随机
    ExerciseModeExam,                           //考试模式
    ExerciseModeMistakes,                    //错题集模式
    ExerciseModeUnknown
};

typedef NS_ENUM(NSInteger,ExerciseType){
    ExerciseTypeNetworkSecurity,        //网络安全
    ExerciseTypePassword,       //密码学
    ExerciseTypeSystemSecurity,         //系统安全
    ExerciseTypeMao1,       //毛概1
    ExerciseTypeMao2,       //毛概2
    ExerciseTypeHistory,        //近代史
    ExerciseTypeMarx,       //马克思
    ExerciseTypeThought,     //思修
    ExerciseTypeXiGai,        //习近平新时代中国特色社会主义思想概论
    ExerciseTypeUnknown     //未知
};


