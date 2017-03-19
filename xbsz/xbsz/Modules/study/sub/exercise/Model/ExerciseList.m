//
//  ExerciseList.m
//  xbsz
//
//  Created by lotus on 18/03/2017.
//  Copyright © 2017 lotus. All rights reserved.
//

#import "ExerciseList.h"

#import "Exercise.h"

@implementation ExerciseList

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"exercises":Exercise.class
        };
}


@end
