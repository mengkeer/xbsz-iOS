//
//  CXNetwork+Course.m
//  xbsz
//
//  Created by lotus on 2017/4/24.
//  Copyright © 2017年 lotus. All rights reserved.
//

#import "CXNetwork+Course.h"

@implementation CXNetwork (Course)

+ (void)getCoursesByStatus:(NSInteger)status
                   success:(CXNetworkSuccessBlock)success
                   failure:(CXNetworkFailureBlock)failure{
    NSDictionary *parameters = nil;
    if([CXLocalUser instance].isLogin){
        parameters = @{@"token":[CXLocalUser instance].token};
    }

    [self invokePostRequest:CXGetCoursesUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

+ (void)getCourseComments:(NSString *)courseID
                   offset:(NSInteger)offset
                    limit:(NSInteger)limit
                  success:(CXNetworkSuccessBlock)success
                  failure:(CXNetworkFailureBlock)failure{
    
    NSDictionary *parameters = nil;
    
    parameters = @{@"courseId": courseID,@"offset":[NSString stringWithFormat:@"%ld",offset],@"limit":[NSString stringWithFormat:@"%ld",limit]};
    
    [self invokePostRequest:CXGetCourseCommentUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

+ (void)applyCourse:(NSString *)courseID
            success:(CXNetworkSuccessBlock)success
            failure:(CXNetworkFailureBlock)failure{
    NSDictionary *parameters = nil;
    
    parameters = @{@"courseId": courseID,@"token":[CXLocalUser instance].token};
    
    [self invokePostRequest:CXApplyCourseUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

+ (void)addCourseComment:(NSString *)courseID
                 content:(NSString *)content
                   point:(NSInteger)point
                 success:(CXNetworkSuccessBlock)success
                 failure:(CXNetworkFailureBlock)failure{
    NSDictionary *parameters = nil;
    
    parameters = @{@"courseId": courseID,@"content":content,@"point":[NSString stringWithFormat:@"%ld",point],@"token":[CXLocalUser instance].token};
    
    [self invokePostRequest:CXAddCourseCommentUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

+ (void)getCourseWare:(NSString *)courseID
              success:(CXNetworkSuccessBlock)success
              failure:(CXNetworkFailureBlock)failure{
    NSDictionary *parameters = @{@"courseId": courseID};
    
    [self invokePostRequest:CXGetCourseWareUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

+ (void)getHomeworks:(NSString *)courseID
             success:(CXNetworkSuccessBlock)success
             failure:(CXNetworkFailureBlock)failure{
    NSDictionary *parameters = nil;
    if(courseID == nil){
        parameters = @{@"token":[CXLocalUser instance].token};
    }else{
        parameters = @{@"courseId":courseID,@"token":[CXLocalUser instance].token};
    }
    [self invokePostRequest:CXGetHomeworksUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

+ (void)getHomeworkQuestions:(NSString *)exerciseID
                     success:(CXNetworkSuccessBlock)success
                     failure:(CXNetworkFailureBlock)failure{
    NSDictionary *parameters = @{@"exerciseId":exerciseID,@"token":[CXLocalUser instance].token};
    
    [self invokePostRequest:CXGetHomeworkQuestionssUrl parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        CXBaseResponseModel *rsp = [CXBaseResponseModel yy_modelWithDictionary:(NSDictionary *)responseObject];
        CallbackRsp(rsp);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        InvokeFailure(error);
    }];
}

@end
