//
//  CXNetwork+Note.h
//  xbsz
//
//  Created by lotus on 2017/5/18.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork.h"

@interface CXNetwork (Note)

+ (void)publishNote:(UIImage *)image
              isBig:(BOOL)isBig
            subject:(NSString *)subject
           location:(NSString *)location
            success:(CXNetworkSuccessBlock)success
            failure:(CXNetworkFailureBlock)failure;


+ (void)getNotesByPageOffset:(NSInteger)offset
           limit:(NSInteger)limit
         success:(CXNetworkSuccessBlock)success
         failure:(CXNetworkFailureBlock)failure;

+ (void)getNoteComments:(NSString *)noteID
                 offset:(NSInteger)offset
                  limit:(NSInteger)limit
                success:(CXNetworkSuccessBlock)success
                failure:(CXNetworkFailureBlock)failure;

+ (void)addNoteComment:(NSString *)noteID
               content:(NSString *)content
               success:(CXNetworkSuccessBlock)success
               failure:(CXNetworkFailureBlock)failure;

@end
